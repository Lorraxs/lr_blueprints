---@type NodeData
local data = {
  name = "fivem/shared/utils/object_index",
  inputs = {
    { name = "object", type = 0 },
    { name = "index",  type = 0 },
  },
  properties = {
  },
  widgets = {
  },
  outputs = { {
    name = "value",
    type = 0
  } },
  title = "Index object"
}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local object = self:getInputData("object")
  local index = self:getInputData("index")
  local value = object[index]
  self:setOutputData("value", value)
  self.blueprint:NextNode(self)
end

Nodes:Create("fivem/shared/utils/object_index", Node)
