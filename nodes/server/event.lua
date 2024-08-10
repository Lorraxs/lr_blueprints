local EventNode = NodeFactory:extend({
  data = {
    name = "fivem/server/event/handler",
    properties = {
      { name = "name",  type = "string",  default_value = "" },
      { name = "isNet", type = "boolean", default_value = true },
    },
    widgets = {
      { type = "string", name = "name",  value = "",   extra_info = { property = "name" } },
      { type = "toggle", name = "isNet", value = true, extra_info = { property = "isNet" } },
    },
    outputs = {
      {
        name = "source",
        type = "number"
      },
      {
        name = "data",
        type = "object"
      },
    },
    title = "Server Event Handler"

  }
})

function EventNode:onStart()
  local isNet = self:getProperty("isNet")
  local eventName = self:getProperty("name")
  if isNet then
    self.cache.eventHandler = RegisterNetEvent(eventName, function(data)
      self:setOutputData("source", source)
      self:setOutputData("data", data)
      self.blueprint:NextNode(self)
    end)
  else
    self.cache.eventHandler = AddEventHandler(eventName, function(data)
      self:setOutputData("data", data)
      self.blueprint:NextNode(self)
    end)
  end
end

function EventNode:Destroy()
  self.destroyed = true
  if self.cache.eventHandler then
    RemoveEventHandler(self.cache.eventHandler)
  end
end

Nodes:Create('fivem/server/event/handler', EventNode)
