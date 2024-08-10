---@type NodeData
local data = {
  name = "fivem/shared/export/create",
  inputs = {
  },
  properties = {
    { name = "exportName", type = "string", default_value = "" },
  },
  widgets = {
    { type = "string", name = "exportName", value = "", extra_info = { property = "exportName" } },
  },
  outputs = {
    { name = "value",   type = 0 },
    { name = "promise", type = "promise" },
    { name = "trigger", type = -1 }
  },
  title = "Create export"
}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called when the blueprint is executed.
function Node:onStart()
  local exportName = self:getProperty("exportName")
  Exports(exportName, function(value)
    self:setOutputData("value", value)
    local p = promise.new()
    self:setOutputData("promise", p)
    self:setOutputData("trigger", true)
    self.blueprint:NextNode(self)
    return Citizen.Await(p)
  end)
end

Nodes:Create("fivem/shared/export/create", Node)

---@type NodeData
local data = {
  name = "fivem/shared/export/end",
  inputs = {
    { name = "value",   type = 0 },
    { name = "promise", type = "promise" },
  },
  properties = {
  },
  widgets = {
  },
  outputs = {},
  title = "End export"
}

local Node = NodeFactory:extend({
  data = data
})



-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local value = self:getInputData("value")
  local promise = self:getInputData("promise")
  promise:resolve(value)
end

Nodes:Create("fivem/shared/export/end", Node)

---@type NodeData
local data = {
  name = "fivem/shared/export/call",
  inputs = {
    { name = "value",   type = 0 },
    { name = "trigger", type = -1 }
  },
  properties = {
    { name = "exportName", type = "string", default_value = "" },
  },
  widgets = {
    { type = "string", name = "exportName", value = "", extra_info = { property = "exportName" } },
  },
  outputs = { {
    name = "value",
    type = 0
  } },

}

local Node = NodeFactory:extend({
  data = data
})

local callExport = function(exportName, input)
  local res = Exports[exportName](input)
  return res
end

-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local exportName = self:getProperty("exportName")
  local value = self:getInputData("value")
  local status, response = pcall(callExport, exportName, value)
  if not status then
    --[[ self:LogError("Export call failed", response) ]]
    return
  end
  self:setOutputData("value", response)
  self.blueprint:NextNode(self)
end

Nodes:Create("fivem/shared/export/call", Node)
