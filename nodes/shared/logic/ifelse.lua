local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/logic/IF",
    inputs = {
      { name = "value", type = 0 },
    },
    properties = {
    },
    widgets = {
    },
    outputs = {
      {
        name = "true",
        type = -1
      },
      {
        name = "false",
        type = -1
      },
    },
    title = "IF"

  }
})


function Node:Execute()
  local value = self:getInputData("value")
  if value then
    self:setOutputData('true', true)
  else
    self:setOutputData('false', true)
  end
  self:Next()
end

Nodes:Create('fivem/shared/logic/IF', Node)
