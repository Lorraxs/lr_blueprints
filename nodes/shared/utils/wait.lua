---@class NodeFactory
local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/wait",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "ms", type = "number", default_value = 0.0 },
    },
    widgets = {
      { type = "number", name = "ms", value = 0.0, extra_info = { property = "ms" } },
    },
    outputs = {
      { name = 'action', type = -1 }
    },
    title = "WAIT"

  }
})


function Node:Execute()
  local ms = self:getProperty("ms")
  Citizen.Wait(ms)
  self:setOutputData("action", true)
  self.blueprint:NextNode(self)
end

Nodes:Create('fivem/shared/utils/wait', Node)
