local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/logic/not_equal",
    inputs = {
      { name = "a", type = 0 },
      { name = "b", type = 0 },
    },
    properties = {
    },
    widgets = {
    },
    outputs = { {
      name = "value",
      type = "boolean"
    } },
    title = "NOT EQUAL"

  }
})


function Node:Execute()
  local a = self:getInputData("a")
  local b = self:getInputData("b")
  local value = a ~= b
  self:setOutputData("value", value)
  self:Next()
end

Nodes:Create('fivem/shared/logic/not_equal', Node)
