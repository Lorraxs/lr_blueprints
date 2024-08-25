---@class Blueprint
Blueprint = class({
  data = {},
})

function Blueprint:Init(data)
  ---@type NodeFactory[]
  self.nodes = {}
  self.running = false
  self.name = data.name
  self.side = data.side
  self.data = data.data
  self.rawData = data.data
  self.start = data.start
  self.cacheOutputs = {}
  ---@type NodeFactory[]
  self.nodesByStep = {}
  self.excludeNodes = {}
  self.blockNextNodes = {}
  self.constantNodes = {}
  self.endNodeOrder = 0
  self:Parse()
end

function Blueprint:LogError(...)
  print("[^1ERROR^0] " .. ("[%s] [%s]"):format(self.name, GetGameTimer()), ...)
end

function Blueprint:LogWarning(...)
  print("[^3WARNING^0] " .. ("[%s] [%s]"):format(self.name, GetGameTimer()), ...)
end

function Blueprint:LogSuccess(...)
  if not Config.Debug then return end
  print("[^2INFO^0] " .. ("[%s] [%s]"):format(self.name, GetGameTimer()), ...)
end

function Blueprint:LogInfo(...)
  if not Config.Debug then return end
  print("[^5INFO^0] " .. ("[%s] [%s]"):format(self.name, GetGameTimer()), ...)
end

function Blueprint:serialize()
  return {
    name = self.name,
    data = self.rawData,
    side = self.side,
    start = self.start,
  }
end

function Blueprint:Parse()
  if self.side == "client" then
    if IsDuplicityVersion() then
      return
    end
  elseif self.side == "server" then
    if not IsDuplicityVersion() then
      return
    end
  end
  self:LogInfo("Blueprint:Parse")
  self:Clear()
  if self.data.nodes == nil then return end
  for k, v in pairs(self.data.nodes) do
    local node = Nodes:Get(v.type)
    local data = self:GuardNodeData(v)
    if node then
      self.cacheOutputs[data.id] = {}
      if data.order >= self.endNodeOrder then
        self.endNodeOrder = data.order
      end
      ---@type NodeFactory
      local impl = node(self)
      impl:SetData(data)
      table.insert(self.nodes, impl)
      self.nodesByStep[impl.order] = impl
    end
  end
end

function Blueprint:GuardNodeData(data)
  if not data.inputs then
    data.inputs = {}
  end
  if not data.outputs then
    data.outputs = {}
  end
  if not data.properties then
    data.properties = {}
  end
  if not data.widgets then
    data.widgets = {}
  end
  return data
end

function Blueprint:Compile()
  self:LogInfo("Checking nodes valid")
  for k, v in ipairs(self.nodes) do
    if v:validConnect() == 0 then
      self:LogError(("Node %s is not valid"):format(v.data.name))
      return
    elseif v:validConnect() == 2 then
      self:LogWarning(("Node %s [$s] is not have connections"):format(v.data.name))
      self.excludeNodes[v.order] = true
    end
  end
  self:LogSuccess("All nodes are valid")
  self:LogInfo("Clear output cache")
  self:ClearOutputCache()
  self:LogInfo(json.encode(self.cacheOutputs))
  self:LogInfo("Compiling")
  self.preStack = {
    ['pre_execute'] = {},
    ['entry'] = {},
    ['flow'] = {},
    ['exit'] = {},
    ['invalid_node'] = {},
  }

  for k, v in ipairs(self.nodes) do
    v.destroyed = false
    local nodePosition = v:getNodePosition()
    if nodePosition then
      table.insert(self.preStack[nodePosition], v)
      self:LogInfo(("Node %s - %s - %s stack at position %s"):format(v.data.name, v.data.id, v.data.order, nodePosition))
    end
  end
  for k, v in ipairs(self.preStack['pre_execute']) do
    self.blockNextNodes[v.order] = true
    self.constantNodes[v.data.id] = true
    v:Execute()
  end
  self:LogInfo("Pre execute done", json.encode(self.cacheOutputs))
  self.running = true
  for k, v in ipairs(self.preStack['entry']) do
    self:LogInfo("Entry node executing", v.data.name, v.data.order)
    v:Execute()
  end
end

function Blueprint:Execute()
  if self.side == "client" then
    if IsDuplicityVersion() then
      return
    end
  elseif self.side == "server" then
    if not IsDuplicityVersion() then
      return
    end
  end
  self:Compile()

  --[[ self.running = true
  Citizen.CreateThread(function()
    for k, v in ipairs(self.nodes) do
      v.destroyed = false
      self:LogInfo(("Node %s is running %s %s"):format(v.data.name, v.onStart, v:ShouldRun()))
      if v.onStart and v:ShouldRun() then
        v:onStart()
      end
    end
  end) ]]
end

function Blueprint:GetNode(type)
  for k, v in ipairs(self.nodes) do
    if v.data.type == type then
      return v
    end
  end
end

function Blueprint:GetNodeById(nodeId)
  for k, v in ipairs(self.nodes) do
    if v.data.id == nodeId then
      return v
    end
  end
end

function Blueprint:ClearOutputCache()
  for k, v in pairs(self.cacheOutputs) do
    if not self.constantNodes[k] then
      for k2, v2 in pairs(v) do
        self.cacheOutputs[k][k2] = nil
      end
    end
  end
end

---@param from NodeFactory
function Blueprint:NextStep(step)
  --[[ self:LogInfo("Next step", step) ]]
  --[[ local links = self:GetNodeLinks(from.data.id)
  for k, v in ipairs(links) do
    local targetNode = self:GetNodeById(v[4])
    if targetNode and not targetNode.needTrigger then
      if targetNode:CanExecute() then
        targetNode:Execute()
      end
    end
  end ]]
  if not self.running then return end
  if self.blockNextNodes[step] then
    step = step + 1
    self:NextStep(step)
    return
  end
  if self.excludeNodes[step] then
    step = step + 1
    self:NextStep(step)
    return
  end
  local node = self.nodesByStep[step]
  if node then
    --[[ self:LogInfo("Node executing", node.data.name) ]]
    if node:CanExecute() then
      node:Execute()
    else
      self:NextStep(step + 1)
    end
  else
    if step > self.endNodeOrder then
      self:ClearOutputCache()
    else
      step = step + 1
      self:NextStep(step)
    end
  end
end

function Blueprint:GetNodeLinks(nodeId)
  local links = {}
  for k, v in ipairs(self.data.links) do
    if v[2] == nodeId then
      table.insert(links, v)
    end
  end
  return links
end

function Blueprint:GetLink(linkId)
  for k, v in ipairs(self.data.links) do
    if v[1] == linkId then
      return v
    end
  end
end

---@param linkId number
---@return NodeFactory | nil
function Blueprint:GetTargetLink(linkId)
  local link = self:GetLink(linkId)
  if not link then return end
  local targetNode = self:GetNodeById(link[4])
  return targetNode
end

function Blueprint:GetSourceLink(linkId)
  local link = self:GetLink(linkId)
  if not link then return end
  local sourceNode = self:GetNodeById(link[2])
  return sourceNode
end

function Blueprint:GetSourceLinkOutput(linkId)
  local link = self:GetLink(linkId)
  if not link then return end
  local sourceNode = self:GetNodeById(link[2])
  if not sourceNode then return end
  local output = sourceNode.data.outputs[link[3] + 1]
  return output
end

function Blueprint:Stop()

end

function Blueprint:Clear()
  for k, v in pairs(self.nodes) do
    v:Destroy()
  end
  self.nodes = {}
  self.running = false
  self.cacheOutputs = {}
  self.excludeNodes = {}
  self.preStack = {}
end

function Blueprint:Toggle(state)
  self.start = state
  if self.start then
    if not self.running then
      self:Execute()
    end
  else
    if self.running then
      for k, v in pairs(self.nodes) do
        v:Destroy()
      end
      self.running = false
    end
  end
end

function Blueprint:Update(data)
  for k, v in ipairs(data.nodes) do
    if v.nodes then
      for _, node in ipairs(v.nodes) do
        if node.outputs then
          for _, output in ipairs(node.outputs) do
            output.data = nil
          end
        end
      end
    end
  end
  self.data = data
  self.rawData = data
  self:Parse()
  if self.start then
    self:Execute()
  end
end
