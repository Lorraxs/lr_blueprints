local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/logic/NOT",
    inputs = {
      { name = "value", type = 0 },
    },
    properties = {
    },
    widgets = {
    },
    outputs = { {
      name = "boolean",
      type = "boolean"
    } },
    title = "NOT"

  }
})


function Node:Execute()
  local value = self:getInputData("value")
  local boolean = not value
  self:setOutputData("boolean", boolean)
  self:Next()
end

Nodes:Create('fivem/shared/logic/NOT', Node)
