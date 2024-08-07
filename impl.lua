---@class Class
---@field destroyed boolean
---@field originalMethods table
---@field eventHandlers table
Class = {}
env = IsDuplicityVersion() and "sv" or "cl"
-- default (empty) constructor
function Class:Init(...) end

---comment
---@param obj any
---@return any
function Class:extend(obj)
	local obj = obj or {}

	local function copyTable(table, destination)
		local table = table or {}
		local result = destination or {}

		for k, v in pairs(table) do
			if not result[k] then
				if type(v) == "table" and k ~= "__index" and k ~= "__newindex" then
					result[k] = copyTable(v)
				else
					result[k] = v
				end
			end
		end

		return result
	end

	copyTable(self, obj)

	obj._ = obj._ or {}

	local mt = {}

	-- create new objects directly, like o = Object()
	mt.__call = function(self, ...)
		return self:new(...)
	end


	setmetatable(obj, mt)

	return obj
end

-- set properties outside the constructor or other functions
function Class:set(prop, value)
	if not value and type(prop) == "table" then
		for k, v in pairs(prop) do
			---@diagnostic disable-next-line: undefined-field
			rawset(self._, k, v)
		end
	else
		---@diagnostic disable-next-line: undefined-field
		rawset(self._, prop, value)
	end
end

-- create an instance of an object with constructor parameters
function Class:new(...)
	local obj = self:extend({
		destroyed = false,
		originalMethods = {},
		eventHandlers = {}
	})
	if obj.Init then obj:Init(...) end
	return obj
end

---@diagnostic disable-next-line: lowercase-global
function class(attr)
	attr = attr or {}
	return Class:extend(attr)
end

---@class Impl:Class
---@field name string
---@field config table
---@field implType "impl"
Impl = class()

function Impl:GetName()
	return self.name
end

function Impl:Destroy()
	self.destroyed = true
	main:LogInfo("%s destroyed", self.name)
	for k, v in pairs(self.eventHandlers) do
		RemoveEventHandler(v)
	end
	self:OnDestroy()
end

function Impl:OnReady(...)
end

function Impl:OnDestroy(...)
end

function Impl:HookMethod(method, hookFn)
	local oldMethod = self[method]
	if not oldMethod then
		main:LogError("Impl %s missing method %s", self.name, method)
		return
	end
	self.originalMethods[method] = oldMethod

	self[method] = function(...)
		if self.destroyed then
			return
		end
		local result = { pcall(hookFn, ...) }
		local success = table.remove(result, 1)
		if not success then
			main:LogError("Impl %s hook %s error: %s", self.name, method, result[2])
			self[method] = oldMethod
			return oldMethod(...)
		end
		return oldMethod(self, table.unpack(result))
	end
end

function Impl:GetMethod(method)
	return self[method]
end

function Impl:ReplaceMethod(method, newMethod)
	if not self[method] then
		main:LogError("Impl %s missing method %s", self.name, method)
		return
	end
	if not self.originalMethods[method] then
		self.originalMethods[method] = self[method]
	end
	self[method] = newMethod
end

function Impl:RefreshMethod(method)
	if not self.originalMethods[method] then
		main:LogError("Impl %s missing method %s", self.name, method)
		return
	end
	self[method] = self.originalMethods[method]
end

function Impl:RegisterCallback(name, cb)
	lib.callback.register(("%s_%s:%s"):format(self.name, env, name), cb)
end

function Impl:On(name, ...)
	if self.eventHandlers[name] then
		return main:LogError("Event %s:%s already registered", self.name, name)
	end
	local handler = AddEventHandler(("%s_%s:%s"):format(self.name, env, name), ...)
	self.eventHandlers[name] = handler
	return handler
end

function Impl:OnNet(name, ...)
	if self.eventHandlers[name] then
		return main:LogError("Event %s:%s already registered", self.name, name)
	end
	local handler = RegisterNetEvent(("%s_%s:%s"):format(self.name, env, name), ...)
	self.eventHandlers[name] = handler
	return handler
end

function Impl:Off(name, handler)
	if self.eventHandlers[name] then
		RemoveEventHandler(self.eventHandlers[name])
		self.eventHandlers[name] = nil
		return;
	end
	main:LogError("Event %s:%s not registered", self.name, name)
end

function Impl:AddEventHandler(eventName, ...)
	self.eventHandlers[eventName] = AddEventHandler(eventName, ...)
end

function Impl:RegisterNetEvent(eventName, ...)
	self.eventHandlers[eventName] = RegisterNetEvent(eventName, ...)
end

if env == 'sv' then
	function Impl:Callback(impl, name, source, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		if not source then return main:LogError("param source missing") end
		return lib.callback.await(("%s_%s:%s"):format(impl, "cl", name), source, ...)
	end

	function Impl:EmitNet(impl, name, source, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		if not source then return main:LogError("param source missing") end
		return TriggerClientEvent(("%s_%s:%s"):format(impl, "cl", name), source, ...)
	end

	function Impl:Emit(impl, name, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		return TriggerEvent(("%s_%s:%s"):format(impl, "sv", name), ...)
	end
else
	function Impl:Callback(impl, name, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		return lib.callback.await(("%s_%s:%s"):format(impl, "sv", name), false, ...)
	end

	function Impl:Emit(impl, name, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		return TriggerEvent(("%s_%s:%s"):format(impl, "cl", name), ...)
	end

	function Impl:EmitNet(impl, name, ...)
		if type(impl) == "object" then
			impl = impl:GetName()
		end
		if not impl then return main:LogError("param impl missing") end
		if not name then return main:LogError("param name missing") end
		return TriggerServerEvent(("%s_%s:%s"):format(impl, "sv", name), ...)
	end
end

function Impl:LogInfo(msg, ...)
	main:LogInfo("[^6" .. self.name .. "^0] " .. msg, ...)
end

function Impl:LogError(msg, ...)
	main:LogError("[^6" .. self.name .. "^0] " .. msg, ...)
end

function Impl:LogSuccess(msg, ...)
	main:LogSuccess("[^6" .. self.name .. "^0] " .. msg, ...)
end

function Impl:LogWarning(msg, ...)
	main:LogWarning("[^6" .. self.name .. "^0] " .. msg, ...)
end

function Impl:GetConfig()
	return self.config
end

---Create a new Implemented class
---@param name string
---@return Impl
function NewImpl(name, extends)
	---@type Impl
	local impl = Impl:extend({
		name = name,
		config = Config[name] or {},
		implType = "impl"
	})
	if extends then
		for k, v in ipairs(extends) do
			impl = impl:extend(v)
		end
	end
	main:RegisterImpl(name, impl)
	return impl
end

function NewSyncImpl(name, extends)
	local impl = Impl:extend({
		name = name,
		config = Config[name] or {},
		implType = "syncImpl",
	})
	if extends then
		for k, v in ipairs(extends) do
			impl = impl:extend(v)
		end
	end
	impl.start = function()
		main.initializedImpls[name] = impl(main)
	end
	return impl
end
