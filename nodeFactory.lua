---@class NodeFactory
NodeFactory = class()

---@param blueprint Blueprint
function NodeFactory:Init(blueprint)
  self.rawData = {}
  self.cache = {}
  self.blueprint = blueprint
  self.destroyed = false
  if self:ShouldRun() then
    self:OnCreated()
  end
  self.triggers = {}
  self.needTrigger = false
  self.inputNodes = {}
end

function NodeFactory:ParseLinkedNodes()
  for k, v in ipairs(self.data.inputs) do
    if v.type ~= -1 then
      local link = v.link
      if not link then
        if not self.rawData.properties then return end
        for k2, v2 in ipairs(self.rawData.properties) do
          if v2.ref == v.name then
            self.inputNodes[v.name] = {}
            self.inputNodes[v.name].data = self:getProperty(v2.name)
          end
        end
        return
      end
      local sourceOutput = self.blueprint:GetSourceLinkOutput(link)
      if sourceOutput then
        self.inputNodes[v.name] = sourceOutput
        local sourceNode = self.blueprint:GetSourceLink(link)
      end
    end
  end
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
  for k, v in ipairs(self.data.inputs) do
    if v.type == -1 then
      goto next
    end
    if not self.inputNodes[v.name] then
      return false
    end
    if self.inputNodes[v.name].data == nil then
      return false
    end
    ::next::
  end
  return true
end

function NodeFactory:LogError(...)
  print("[^1ERROR^0] " .. ("[%s] [%s] %s"):format(self.blueprint.name, GetGameTimer(), self.data.name), ...)
end

function NodeFactory:LogWarning(...)
  print("[^3WARNING^0] " .. ("[%s] [%s] %s"):format(self.blueprint.name, GetGameTimer(), self.data.name), ...)
end

function NodeFactory:LogSuccess(...)
  if not Config.Debug then return end
  print("[^2INFO^0] " .. ("[%s] [%s] %s"):format(self.blueprint.name, GetGameTimer(), self.data.name), ...)
end

function NodeFactory:LogInfo(...)
  if not Config.Debug then return end
  print("[^5INFO^0] " .. ("[%s] [%s] %s"):format(self.blueprint.name, GetGameTimer(), self.data.name), ...)
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

function NodeFactory:setOutputData(name, data)
  local output = self:getOutput(name)
  if output then
    if output.type == -1 then
      local links = output.links
      if not links then return end
      for k, v in ipairs(links) do
        local targetNode = self.blueprint:GetTargetLink(v)
        if targetNode then
          if targetNode:CanExecute() then
            targetNode:Execute()
            --self:clearOutput()
          end
        end
      end
      return
    end
    output.data = data
  end
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
  if self.inputNodes[name] then
    return self.inputNodes[name].data
  end
end

function NodeFactory:setInputData(name, data)
  local input = self:getInput(name)
  if input then
    if input.type == -1 then
      return
    else
      input.data = data
    end
  end
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
