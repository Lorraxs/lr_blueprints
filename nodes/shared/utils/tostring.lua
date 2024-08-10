---@type NodeData
local data = {
  name = "fivem/shared/utils/tostring",
  inputs = {
    { name = "value", type = 0 },
  },
  properties = {
  },
  widgets = {
  },
  outputs = { {
    name = "value",
    type = "string"
  } },
  title = "To String",
}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local value = self:getInputData("value")
  local output = ""
  if type(value) == "table" then
    output = json.encode(value)
  else
    output = tostring(value)
  end
  self:setOutputData("value", output)
  self.blueprint:NextNode(self)
end

Nodes:Create("fivem/shared/utils/tostring", Node)
