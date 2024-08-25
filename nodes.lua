---@class Nodes
_Nodes = class()

function _Nodes:Init()
  self.nodes = {}
end

function _Nodes:CheckNodeSide(name)
  if string.find(name, "fivem/shared") then
    return true
  end
  if string.find(name, "fivem/server") then
    return IsDuplicityVersion()
  else
    return not IsDuplicityVersion()
  end
end

function _Nodes:Create(name, impl)
  self.nodes[name] = impl
end

---@param name string
---@return NodeFactory | nil
function _Nodes:Get(name)
  if self:CheckNodeSide(name) then
    return self.nodes[name]
  end
end

function _Nodes:GetNUIData()
  local arr = {}
  for k, v in pairs(self.nodes) do
    table.insert(arr, v.data)
  end
  return arr
end

---@type Nodes
Nodes = _Nodes()

local validTypes = {
  ['number'] = true,
  ['string'] = true,
  ['boolean'] = true,
  ['vec3'] = true,
}

local parseType = function(type)
  if validTypes[type] then
    return type
  end
  return 0
end

for k, v in ipairs(clientNatives) do
  v.hash = GetHashKey(v.name)
  print(v.name, v.hash)
  ---@type NodeData
  local data = {
    name = "fivem/client/natives/" .. v.name,
    inputs = {
    },
    properties = {
    },
    widgets = {
    },
    outputs = {},
    title = v.name
  }
  for k2, param in ipairs(v.params) do
    table.insert(data.inputs, { name = param.name, type = parseType(param.type) })
  end
  for _, ret in ipairs(v.ret) do
    table.insert(data.outputs, { name = "r" .. _, type = parseType(ret) })
  end

  local Node = NodeFactory:extend({
    data = data
  })

  -- Node will be called in the blueprint execution loop.
  function Node:Execute()
    --[[ local coords = self:getInputData("coords")
    if not self.cache.offset then
      self.cache.offset = vector3(self:getPropertieData("offsetX"), self:getPropertieData("offsetY"),
        self:getPropertieData("offsetZ"))
    end
    local newCoords = coords - self.cache.offset
    self:setOutputData("coords", newCoords) ]]
    local args = {}
    for k, v in ipairs(v.params) do
      table.insert(args, self:getInputData(v.name))
    end
    local ret = table.pack(_G[v.name](table.unpack(args)))
    for k, v in ipairs(v.ret) do
      self:setOutputData("r" .. k, ret[k])
    end
    self:Next()
  end

  Nodes:Create("fivem/client/natives/" .. v.name, Node)
end

for k, v in ipairs(serverNatives) do
  v.hash = GetHashKey(v.name)
  print(v.name, v.hash)
  ---@type NodeData
  local data = {
    name = "fivem/server/natives/" .. v.name,
    inputs = {
    },
    properties = {
    },
    widgets = {
    },
    outputs = {},
    title = v.name
  }
  for k2, param in ipairs(v.params) do
    table.insert(data.inputs, { name = param.name, type = parseType(param.type) })
  end
  for _, ret in ipairs(v.ret) do
    table.insert(data.outputs, { name = "r" .. _, type = parseType(ret) })
  end

  local Node = NodeFactory:extend({
    data = data
  })

  -- Node will be called in the blueprint execution loop.
  function Node:Execute()
    --[[ local coords = self:getInputData("coords")
    if not self.cache.offset then
      self.cache.offset = vector3(self:getPropertieData("offsetX"), self:getPropertieData("offsetY"),
        self:getPropertieData("offsetZ"))
    end
    local newCoords = coords - self.cache.offset
    self:setOutputData("coords", newCoords) ]]
    local args = {}
    for k, v in ipairs(v.params) do
      table.insert(args, self:getInputData(v.name))
    end
    local ret = table.pack(_G[v.name](table.unpack(args)))
    for k, v in ipairs(v.ret) do
      self:setOutputData("r" .. k, ret[k])
    end
    self:Next()
  end

  Nodes:Create("fivem/server/natives/" .. v.name, Node)
end
