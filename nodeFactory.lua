---@class NodeFactory
---@field data NodeData
NodeFactory = class()

---@param blueprint Blueprint
function NodeFactory:Init(blueprint)
  ---@type NodeData
  self.rawData = self.data
  self.cache = {}
  ---@type Blueprint
  self.blueprint = blueprint
  self.destroyed = false
  self.triggers = {}
  self.needTrigger = false
  self.inputStore = {}
  self.order = 0
end

---@param data NodeData
function NodeFactory:SetData(data)
  self.data = data
  self.data.name = data.type
  self.order = data.order
  self.ouputStore = self.blueprint.cacheOutputs[data.id]
  self:ParseLinkedNodes()
  self:CheckTriggers()
end

function NodeFactory:ParseLinkedNodes()
  self:LogInfo("ParseLinkedNodes")
  local predefinedObject = {}
  for k, v in ipairs(self.data.inputs) do
    if v.type ~= -1 then
      local link = v.link
      if not link then
        if not self.rawData.properties then return end
        for k2, v2 in ipairs(self.rawData.properties) do
          if v2.ref == v.name then
            self:LogInfo("predefined", v.name, v2.name, v2.ref, self:getProperty(v2.name))
            predefinedObject[v.name] = self:getProperty(v2.name)
          end
        end
      end
    end
  end
  local blueprintOutputCache = self.blueprint.cacheOutputs
  local selfCache = {}
  self.inputStore = setmetatable(predefinedObject, {
    __index = function(t, k)
      local position = selfCache[k]
      if position then
        return blueprintOutputCache[position.nodeId][position.slot]
      end
      local input = self:getInput(k)
      if not input then return end
      local link = input.link
      if not link then return end
      local linkData = self.blueprint:GetLink(link)
      if not linkData then return end
      selfCache[k] = { nodeId = linkData[2], slot = linkData[3] + 1 }
      return blueprintOutputCache[linkData[2]][linkData[3] + 1]
    end
  })
end

function NodeFactory:CheckTriggers()
  local triggers = {}
  for k, v in ipairs(self.data.inputs) do
    if v.type == -1 and v.link then
      table.insert(triggers, v)
    end
  end
  self.triggers = triggers
  self.needTrigger = #triggers > 0
  return triggers
end

function NodeFactory:ShouldRun()
  if string.find(self.data.name, "fivem/shared") then
    return true
  end
  if string.find(self.data.name, "fivem/server") then
    return IsDuplicityVersion()
  else
    return not IsDuplicityVersion()
  end
end

function NodeFactory:CanExecute()
  for k, v in pairs(self.data.inputs) do
    if self:getInputData(v.name) == nil then
      return false
    end
  end
  return true
end

function NodeFactory:LogError(...)
  print(
    "[^1ERROR^0] " .. ("[%s] [%s] [%s] [%s]"):format(self.blueprint.name, GetGameTimer(), self.data.name, self.order),
    ...)
end

function NodeFactory:LogWarning(...)
  print(
    "[^3WARNING^0] " .. ("[%s] [%s] [%s] [%s]"):format(self.blueprint.name, GetGameTimer(), self.data.name, self.order),
    ...)
end

function NodeFactory:LogSuccess(...)
  if not Config.Debug then return end
  print("[^2INFO^0] " .. ("[%s] [%s] [%s] [%s]"):format(self.blueprint.name, GetGameTimer(), self.data.name, self.order),
    ...)
end

function NodeFactory:LogInfo(...)
  if not Config.Debug then return end
  print("[^5INFO^0] " .. ("[%s] [%s] [%s] [%s]"):format(self.blueprint.name, GetGameTimer(), self.data.name, self.order),
    ...)
end

function NodeFactory:OnCreated()
end

function NodeFactory:Execute()
end

function NodeFactory:AfterExecute()
  for k, v in ipairs(self.data.inputs) do
    if v.type == -1 then
      v.data = nil
    end
  end
end

function NodeFactory:Destroy()
  self.destroyed = true
  self.cache = {}
end

function NodeFactory:getOutput(name)
  for k, v in ipairs(self.data.outputs) do
    if v.name == name then
      return v
    end
  end
end

function NodeFactory:getOutputData(name)
  --[[ local output = self:getOutput(name)
  if output then
    return output.data
  end ]]
  local output = self:getOutput(name)
  if not output then return end
  return self.ouputStore[output.slot_index + 1]
end

function NodeFactory:setOutputData(name, data)
  --[[ local output = self:getOutput(name)
  if output then
    if output.type == -1 then
      local links = output.links
      if not links then return end
      for k, v in ipairs(links) do
        local targetNode = self.blueprint:GetTargetLink(v)
        if targetNode then
          if targetNode:CanExecute() then
            targetNode:Execute()
          end
        end
      end
      return
    end
    output.data = data
  end ]]
  local output = self:getOutput(name)
  if not output then return end
  if output.slot_index == nil then
    return
  end
  self.ouputStore[output.slot_index + 1] = data
end

function NodeFactory:getInput(name)
  for k, v in ipairs(self.data.inputs) do
    if v.name == name then
      return v
    end
  end
end

function NodeFactory:getInputData(name)
  --[[ for k, v in ipairs(self.data.inputs) do
    if v.name == name then
      return v.data
    end
  end ]]
  --[[ if self.inputNodes[name] then
    return self.inputNodes[name].data
  end ]]
  return self.inputStore[name]
end

function NodeFactory:getProperty(name)
  if self.data.properties then
    return self.data.properties[name]
  end
end

function NodeFactory:clearOutput()
  for k, v in ipairs(self.data.outputs) do
    v.data = nil
  end
end

---@return boolean
function NodeFactory:hasOutputTrigger()
  for k, v in ipairs(self.data.outputs) do
    if v.type == -1 then
      return true
    end
  end
  return false
end

---comment 0: invalid, 1: valid, 2: no connections
---@return 0 | 1 | 2
function NodeFactory:validConnect()
  local inputs = self:hasInput()
  local outputs = self:hasOutput()
  if not inputs and not outputs then
    return 0
  end
  --[[ local valid = true
  for k, v in ipairs(self.data.inputs) do
    if v.type ~= -1 then
      if v.link == nil then
        valid = false
        break
      end
    end
  end
  if not valid then
    if not self.data.outputs then return true end
    for k, v in ipairs(self.data.outputs) do
      if v.links and #v.links > 0 then
        return false
      end
    end
  end
  return true ]]
  local inputLinks = self:getAllInputLinks()
  local outputLinks = self:getAllOutputLinks()
  if #inputLinks == 0 and #outputLinks == 0 then
    return 2
  end
  return 1
end

function NodeFactory:hasInput()
  if self.data.inputs == nil then return end
  if #self.data.inputs == 0 then return end
  local trigger = 0
  local input = 0
  for k, v in ipairs(self.data.inputs) do
    if v.type == -1 then
      trigger = trigger + 1
    else
      input = input + 1
    end
  end
  return { trigger = trigger, input = input }
end

function NodeFactory:hasOutput()
  if self.data.outputs == nil then return end
  if #self.data.outputs == 0 then return end
  local trigger = 0
  local output = 0
  for k, v in ipairs(self.data.outputs) do
    if v.type == -1 then
      trigger = trigger + 1
    else
      output = output + 1
    end
  end
  return { trigger = trigger, output = output }
end

function NodeFactory:getAllInputLinks()
  local links = {}
  for k, v in ipairs(self.data.inputs) do
    if v.link then
      table.insert(links, { name = v.name, link = v.link })
    end
  end
  return links
end

function NodeFactory:getAllOutputLinks()
  local links = {}
  if self.data.outputs then
    for k, v in ipairs(self.data.outputs) do
      if v.links and #v.links > 0 then
        table.insert(links, { name = v.name, links = v.links })
      end
    end
  end
  return links
end

---@return 'pre_execute' | 'entry' | 'flow' | 'exit' | 'invalid_node' | nil
function NodeFactory:getNodePosition()
  local inputs = self:hasInput()
  local outputs = self:hasOutput()
  -- if not have any input

  if not inputs then
    if not outputs then
      return 'invalid_node'
    end
    if outputs.trigger > 0 then
      return "entry"
    else
      return "flow"
    end
  else
    if inputs.input == 0 then
      if inputs.trigger > 0 then
        local links = self:getAllInputLinks()
        if #links > 0 then
          if not outputs then
            return "exit"
          else
            local links = self:getAllOutputLinks()
            if #links == 0 then
              return "exit"
            end
          end
          return "flow"
        else
          return "pre_execute"
        end
      else
        return "invalid_node"
      end
    else
      if not outputs then
        return "exit"
      else
        local links = self:getAllOutputLinks()
        if #links > 0 then
          return "flow"
        end
        return "exit"
      end
    end
  end
end

function NodeFactory:Next()
  self.blueprint:NextStep(self.order + 1)
end
