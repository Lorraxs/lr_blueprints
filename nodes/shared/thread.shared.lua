local ThreadNode = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/thread",
    properties = {
      { name = "interval", type = "number", default_value = 1000 }
    },
    inputs = {},
    outputs = {
      { name = 'action', type = -1 }
    },
    widgets = {
      { type = "number", name = "interval", value = 1000, extra_info = { property = "interval" } }
    },
    title = "CITIZEN THREAD"
  }
})

function ThreadNode:onStart()
  local interval = self:getProperty("interval")
  self:LogInfo('ThreadNode:onStart %s', interval)
  Citizen.CreateThread(function()
    while not self.destroyed do
      Wait(interval)
      self:setOutputData("action", true)
    end
  end)
end

Nodes:Create('fivem/shared/utils/thread', ThreadNode)
