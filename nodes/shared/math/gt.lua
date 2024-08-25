local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/math/>",
    inputs = {
      { name = "a", type = "number" },
      { name = "b", type = "number" },
    },
    properties = {
    },
    widgets = {
    },
    outputs = { {
      name = "value",
      type = "boolean"
    } },
    title = ">"

  }
})


function Node:Execute()
  local a = self:getInputData("a")
  local b = self:getInputData("b")
  local value = a > b
  self:setOutputData("value", value)
  self:Next()
end

Nodes:Create('fivem/shared/math/>', Node)
