local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/logic/AND",
    inputs = {
      { name = "value_1", type = 0 },
      { name = "value_2", type = 0 },
    },
    properties = {
    },
    widgets = {
    },
    outputs = { {
      name = "boolean",
      type = "boolean"
    } },
    title = "AND"
  }
})


function Node:Execute()
  local value_1 = self:getInputData("value_1")
  local value_2 = self:getInputData("value_2")
  local boolean = value_1 and value_2
  self:setOutputData("boolean", boolean)
  self.blueprint:NextNode(self)
end

Nodes:Create('fivem/shared/logic/AND', Node)
