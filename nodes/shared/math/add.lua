---@type NodeData
local data = {
  name = "fivem/shared/math/+",
  inputs = {
    { name = "A", type = "number" },
    { name = "B", type = "number" },
  },
  properties = {
    { name = "value", type = "number", default_value = 0.0, ref = "B" },
  },
  widgets = {
    { type = "number", name = "value", value = 0.0, extra_info = { property = "value" } },
  },
  outputs = { {
    name = "A+B",
    type = "number"
  } },

}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called when the blueprint is executed.
-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local a = self:getInputData("A")
  local b = self:getInputData("B")
  if b == nil then
    b = self:getProperty("value")
  end
  local value = a + b
  self:setOutputData("A+B", value)
  self:Next()
end

Nodes:Create("fivem/shared/math/+", Node)
