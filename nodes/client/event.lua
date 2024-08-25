if IsDuplicityVersion() then return end

local EventNode = NodeFactory:extend({
  data = {
    name = "fivem/client/event/handler",
    properties = {
      { name = "name",  type = "string",  default_value = "" },
      { name = "isNet", type = "boolean", default_value = true },
    },
    widgets = {
      { type = "string", name = "name",  value = "",   extra_info = { property = "name" } },
      { type = "toggle", name = "isNet", value = true, extra_info = { property = "isNet" } },
    },
    outputs = { {
      name = "data",
      type = "object"
    } },
    title = "Client Event Handler"
  }
})

function EventNode:Execute()
  local isNet = self:getProperty("isNet")
  local eventName = self:getProperty("name")
  if isNet then
    self.cache.eventHandler = RegisterNetEvent(eventName, function(data)
      self:setOutputData("data", data)
      self:Next()
    end)
  else
    self.cache.eventHandler = AddEventHandler(eventName, function(data)
      self:setOutputData("data", data)
      self:Next()
    end)
  end
end

function EventNode:Destroy()
  self.destroyed = true
  if self.cache.eventHandler then
    RemoveEventHandler(self.cache.eventHandler)
  end
end

Nodes:Create('fivem/client/event/handler', EventNode)

local TriggerEventNode = NodeFactory:extend({
  data = {
    name = "fivem/client/event/trigger",
    inputs = {
      { name = "data", type = 0 }
    },
    properties = {
      { name = "name",  type = "string",  default_value = "" },
      { name = "isNet", type = "boolean", default_value = true },
    },
    widgets = {
      { type = "string", name = "name",  value = "",   extra_info = { property = "name" } },
      { type = "toggle", name = "isNet", value = true, extra_info = { property = "isNet" } },
    },
    outputs = { {
      name = "data",
      type = 0
    } },
    title = "Client Trigger Event"

  }
})

function TriggerEventNode:Execute()
  local isNet = self:getProperty("isNet")
  local eventName = self:getProperty("name")
  local data = self:getInputData("data")
  if isNet then
    TriggerServerEvent(eventName, data)
    self:setOutputData("data", data)
    self:Next()
  else
    TriggerEvent(eventName, data)
    self:setOutputData("data", data)
    self:Next()
  end
end

Nodes:Create('fivem/client/event/trigger', TriggerEventNode)
