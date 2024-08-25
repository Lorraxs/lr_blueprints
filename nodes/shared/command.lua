---@type NodeData
local data = {
  name = "fivem/shared/register-command",
  inputs = {
  },
  properties = {
    { name = "commandName", type = "string",  default_value = "" },
    { name = "restricted",  type = "boolean", default_value = false },
  },
  widgets = {
    { type = "text",   name = "commandName", value = "",    extra_info = { property = "commandName" } },
    { type = "toggle", name = "restricted",  value = false, extra_info = { property = "restricted" } },
  },
  outputs = {
    { name = "source",     type = "number" },
    { name = "args",       type = "table" },
    { name = "rawCommand", type = "string" }
  },
  title = "Register command"
}

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
  self:setOutputData("coords", newCoords)
  self:Next() ]]
  local commandName = self:getProperty("commandName")
  local restricted = self:getProperty("restricted")
  RegisterCommand(commandName, function(source, args, rawCommand)
    self:setOutputData("value", source)
    self:Next()
  end, restricted)
end

Nodes:Create("fivem/shared/register-command", Node)
