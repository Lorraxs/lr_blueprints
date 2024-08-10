---@type NodeData
local data = {
  name = "fivem/shared/utils/script",
  inputs = {
    { name = "value",   type = 0 },
    { name = "trigger", type = -1 }
  },
  properties = {
    { name = "onExecute", default_value = "" },
    { name = "onStart",   default_value = "" },
  },
  widgets = {
  },
  outputs = { {
    name = "value",
    type = 0
  } },
  widgets_info = {
    onExecute = { type = "code" },
    onStart = { type = "code" }
  },
  title = "Script"
}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called when the blueprint is executed.
function Node:onStart()
  local script = self:getProperty("onStart")
  if script ~= "" then
    local f = load(script)
    if not f then return end
    local ok, func = pcall(f)
    if not ok then
      self:LogInfo("Execution error", func)
      return
    end
    local this = self
    local input = self:getInputData("value")
    local res = func(this, input)
    self:setOutputData("value", res)
    self.blueprint:NextNode(self)
  end
end

-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local input = self:getInputData("value")
  if self.cache.onExecute then
    local res = self.cache.onExecute(self, input)
    self:setOutputData("value", res)
    self.blueprint:NextNode(self)
    return
  end
  local script = self:getProperty("onExecute")
  if script ~= "" then
    local f, err = load(script)
    print(f, err, script)
    if not f then return end
    local ok, func = pcall(f)
    if not ok then
      self:LogInfo("Execution error", func)
      return
    end
    self.cache.onExecute = func
    local this = self
    local res = func(this, input)
    self:setOutputData("value", res)
    self.blueprint:NextNode(self)
  end
end

Nodes:Create("fivem/shared/utils/script", Node)