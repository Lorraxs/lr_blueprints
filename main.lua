Framework = nil
if Config.Framework == 'esx' then
  Framework = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb" then
  Framework = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "ProjectStarboy" then
  Framework = CORE
else
  Framework = {}
  Framework.Functions = {}
  Framework.Functions.GetPlayerData = function()
    return {}
  end
end

---@class Main
---@field impls table<string, Impl>
---@field initializedImpls table<string, Impl>
Main = {}
ResourceName = GetCurrentResourceName()
local RegisteredEvents = {}
if IsDuplicityVersion() then
  function GetGameTimer()
    return os.clock() * 1000
  end
else
  RegisterNUICallback('AppReady', function(data, cb)
    cb(Config.Settings or {})
    NuiReady = true
  end)
end

---Init main class
---@return Main
function Main:Init()
  local o = {}
  setmetatable(o, { __index = Main })
  o.impls = {}
  o.initializedImpls = {}
  o.lastTimeImplRegistered = 0
  o.onReadyCallbacks = {}
  o.ready = false
  if not IsDuplicityVersion() then
    o.playerId = PlayerId()
    o.playerPed = PlayerPedId()
    o.playerCoords = GetEntityCoords(o.playerPed)
    o.playerHeading = GetEntityHeading(o.playerPed)
    o.playerServerId = GetPlayerServerId(o.playerId)
    o:Thread1()
  else
    o.ClientImpls = {}
    if Config.ClientLazyLoad then
      for k, v in pairs(Config.EnableModules) do
        if v and v.client then
          local path = "client/impl/" .. k .. ".impl.lua"
          local source = LoadResourceFile(ResourceName, path)
          if source == nil then
            self:LogWarning("Failed to load %s", path)
          else
            --[[ self:LogInfo("Loading %s", path)
            self:LogInfo("Loaded %s", source) ]]
            o.ClientImpls[k] = source
          end
        end
      end
      lib.callback.register(ResourceName .. ":getClientImpl", function(source, implName)
        return o.ClientImpls[implName]
      end)
    end
  end
  o:Exports()
  o:RegisterCommands()
  o:RegisterEvents()
  o:LogInfo("Main initialized")
  return o
end

function Main:ListenOnReady(handler)
  if self.ready then return handler() end
  table.insert(self.onReadyCallbacks, handler)
end

if not IsDuplicityVersion() then
  function Main:Thread1()
    self.playerServerId = GetPlayerServerId(self.playerId)
    Citizen.CreateThread(function()
      while true do
        self.playerId = PlayerId()
        self.playerPed = PlayerPedId()
        self.playerCoords = GetEntityCoords(self.playerPed)
        self.playerHeading = GetEntityHeading(self.playerPed)
        Citizen.Wait(1000)
      end
    end)
  end
end

function Main:RegisterCommands()
  if not IsDuplicityVersion() then
    RegisterCommand("toggledebug:" .. ResourceName, function(source, args, rawCommand)
      Config.Debug = not Config.Debug
      self:LogInfo("Debug %s", Config.Debug)
    end, false)
    RegisterCommand("toggledev:" .. ResourceName, function(source, args, rawCommand)
      Config.Dev = not Config.Dev
      self:LogInfo("Dev %s", Config.Dev)
      SendNUIMessage({
        action = "updateServerState",
        data = {
          isDev = Config.Dev,
        }
      })
    end, false)
    RegisterCommand("implinfo:" .. ResourceName, function(source, args, rawCommand)
      self:ImplInfo()
    end, false)
    RegisterCommand("test", function()
      TriggerEvent("test")
    end, false)
  else
    RegisterCommand("reload:" .. ResourceName, function(source, args, rawCommand)
      if Config.ClientLazyLoad == false then return print("Lazyload was disabled") end
      local implName = args[1]
      local mode = args[2]
      if mode == nil then
        mode = "0"
      end
      self:LogInfo("Restarting impl: %s | side: %s (0: both, 1: client, 2: server)", implName, mode)
      if mode == "0" or mode == "2" then
        local svImpl = self:GetImpl(implName)
        if svImpl then
          svImpl:Destroy()
          self.impls[implName] = nil
          self.initializedImpls[implName] = nil
        end
        local source = LoadResourceFile(ResourceName, "server/impl/" .. implName .. ".impl.lua")
        if source == nil then
          self:LogWarning("Failed to load %s", ResourceName, "server/impl/" .. implName .. ".impl.lua")
        else
          self:LogInfo("Loading %s", implName)
          load(source)()
        end
      end
      if mode == "0" or mode == "1" then
        local clSource = LoadResourceFile(ResourceName, "client/impl/" .. implName .. ".impl.lua")
        if clSource == nil then
          self:LogWarning("Failed to load %s", ResourceName, "client/impl/" .. implName .. ".impl.lua")
        else
          self:LogInfo("Loading %s", "client/impl/" .. implName .. ".impl.lua")
          TriggerClientEvent(ResourceName .. ":restartClientImpl", -1, implName, clSource)
        end
      end
    end, true)
  end
end

function Main:RegisterEvents()
  RegisterNetEvent(ResourceName .. ":restartClientImpl", function(implName, source)
    local clImpl = self:GetImpl(implName)
    if clImpl then
      clImpl:Destroy()
      self.impls[implName] = nil
      self.initializedImpls[implName] = nil
    end
    load(source)()
  end)
end

function Main:LogError(msg, ...)
  print(("[^1ERROR^0] " .. ("[%s] "):format(GetGameTimer()) .. msg):format(...))
end

function Main:LogWarning(msg, ...)
  print(("[^3WARNING^0] " .. ("[%s] "):format(GetGameTimer()) .. msg):format(...))
end

function Main:LogSuccess(msg, ...)
  if not Config.Debug then return end
  print(("[^2INFO^0] " .. ("[%s] "):format(GetGameTimer()) .. msg):format(...))
end

function Main:LogInfo(msg, ...)
  if not Config.Debug then return end
  print(("[^5INFO^0] " .. ("[%s] "):format(GetGameTimer()) .. msg):format(...))
end

function Main:CheckValidImpl(name, impl)
  if not impl then
    self:LogError("Impl %s is nil", name)
    return false
  end
  if not impl.Init then
    self:LogError("Impl %s missing Init function", name)
    return false
  end
  return true
end

function Main:RegisterImpl(name, impl)
  if impl.implType == "syncImpl" then
    return
  end
  if impl.implType == "impl" and (Config.EnableModules[name] == nil or not Config.EnableModules[name].enabled) then
    self:LogWarning("Impl %s not enabled", name)
    return
  end
  if self.impls[name] then
    self:LogWarning("Impl %s already registered", name)
    return
  end
  if not self:CheckValidImpl(name, impl) then
    return
  end
  self.impls[name] = impl
  self.lastTimeImplRegistered = GetGameTimer()

  self:LogSuccess("Impl %s registered", name)
  if self.ready then
    Citizen.CreateThread(function()
      self:LogSuccess("Impl %s hot reloading", name)
      Wait(1000)
      self.initializedImpls[name] = impl(self)
      if not self.initializedImpls[name] then
        self:LogError("Impl %s failed to hot reload", name)
        return
      end
      self.initializedImpls[name]:OnReady()
      self:LogSuccess("Impl %s hot reloaded", name)
    end)
  end
end

function Main:InitImpl()
  if Config.Dependencies then
    for k, v in ipairs(Config.Dependencies) do
      local p = promise.new()
      TriggerEvent(('%s:onReady'):format(v), function()
        p:resolve()
      end)
      Citizen.Await(p)
    end
  end
  if not IsDuplicityVersion() then
    if Config.ClientLazyLoad then
      for k, v in pairs(Config.EnableModules) do
        if v.enabled and v.priority == 1 and v.client then
          self:LogInfo("Loading %s", k)
          local source = lib.callback.await(ResourceName .. ":getClientImpl", false, k)
          if source ~= nil then
            self:LogInfo("Loaded %s", k)
            load(source)()
          end
        end
      end
      for name, impl in pairs(self.impls) do
        if impl.implType ~= "impl" or (Config.EnableModules[name] and Config.EnableModules[name].priority == 1) then
          self.initializedImpls[name] = impl(self)
        end
      end
      self:LogInfo("All priority 1 initialized")
      for name, impl in pairs(self.initializedImpls) do
        if impl.implType ~= "impl" or (Config.EnableModules[name] and Config.EnableModules[name].priority == 1) then
          impl:OnReady()
        end
      end
    else
      for name, impl in pairs(self.impls) do
        if impl.implType ~= "impl" or (Config.EnableModules[name] and Config.EnableModules[name].priority == 1) then
          self.initializedImpls[name] = impl(self)
        end
      end
      self:LogInfo("All priority 1 initialized")
      for name, impl in pairs(self.initializedImpls) do
        if impl.implType ~= "impl" or (Config.EnableModules[name] and Config.EnableModules[name].priority == 1) then
          impl:OnReady()
        end
      end
    end
  else
    for name, impl in pairs(self.impls) do
      self.initializedImpls[name] = impl(self)
    end
    for name, impl in pairs(self.initializedImpls) do
      impl:OnReady()
    end
  end
end

function Main:InitImplAfterPlayerLoaded()
  if not IsDuplicityVersion() then
    for k, v in pairs(Config.EnableModules) do
      if v.enabled and v.priority == 2 and v.client then
        self:LogInfo("Loading %s", k)
        if Config.ClientLazyLoad then
          local source = lib.callback.await(ResourceName .. ":getClientImpl", false, k)
          if source ~= nil then
            self:LogInfo("Loaded %s", k)
            load(source)()
          end
        else
          if self.initializedImpls[k] then
            self.initializedImpls[k]:OnReady()
          end
        end
      end
    end

    for name, impl in pairs(self.impls) do
      if Config.EnableModules[name] and Config.EnableModules[name].priority == 2 then
        self.initializedImpls[name] = impl(self)
      end
    end
    self:LogInfo("All priority 2 initialized")
    for name, impl in pairs(self.initializedImpls) do
      if Config.EnableModules[name] and Config.EnableModules[name].priority == 2 then
        impl:OnReady()
      end
    end
    SendNUIMessage({
      action = "updateServerState",
      data = {
        isDev = Config.Dev,
      }
    })
  end
  self.ready = true
  for k, v in ipairs(self.onReadyCallbacks) do
    v()
  end
  self.onReadyCallbacks = {}
end

function Main:GetImpl(name)
  if not self.initializedImpls[name] then
    self:LogError("Impl %s not found", name)
    return
  end
  return self.initializedImpls[name]
end

function Main:ImplCall(name, func, ...)
  local impl = self:GetImpl(name)
  if not impl then
    return
  end
  if not impl[func] then
    self:LogError("Impl %s missing function %s - args %s", name, func, json.encode({ ... }))
    return
  end
  return impl[func](impl, ...)
end

function Main:ImplInfo()
  for name, impl in pairs(self.impls) do
    local debug = debug.getinfo(impl.OnReady, "S")
    self:LogInfo("Impl %s - %s", name, debug.short_src)
  end
end

function Main:Exports()
  exports("ImplCall", function(name, func, ...)
    return self:ImplCall(name, func, ...)
  end)
end

function Main:ToggleUI(state)
  self.showUI = state
  if Config.Nui then
    SendNUIMessage({
      event = "main:setShow",
      data = state
    })
  end
end

main = Main:Init()
AddEventHandler(("%s:onReady"):format(GetCurrentResourceName()), function(handler)
  local invokingResource = GetInvokingResource()
  main:LogInfo(invokingResource)
  main:ListenOnReady(handler)
end)



Citizen.CreateThread(function()
  while GetGameTimer() < main.lastTimeImplRegistered + 1000 do
    Citizen.Wait(0)
  end
  while Framework == nil do
    main:LogInfo("Waiting for Framework")
    Wait(100)
    if Config.Framework == 'esx' then
      Framework = exports["es_extended"]:getSharedObject()
    elseif Config.Framework == "qb" then
      Framework = exports['qb-core']:GetCoreObject()
    elseif Config.Framework == "ProjectStarboy" then
      Framework = CORE
    else
      Framework = {}
      Framework.Functions = {}
      Framework.Functions.GetPlayerData = function()
        return {}
      end
    end
  end
  main:InitImpl()
  if not IsDuplicityVersion() then
    if Config.Framework == 'esx' then
      while not Framework.IsPlayerLoaded() do
        Wait(100)
      end
    elseif Config.Framework == 'qb' then
      local player = Framework.Functions.GetPlayerData()
      while player == nil do
        Wait(100)
        player = Framework.Functions.GetPlayerData()
      end
    elseif Config.Framework == 'ProjectStarboy' then
      while not CORE.PlayerData.loaded do
        Wait(100)
        main:LogInfo("Waiting for player loaded")
      end
    end
    while not NuiReady and Config.Nui do
      Wait(100)
    end
  end
  main:InitImplAfterPlayerLoaded()
end)
