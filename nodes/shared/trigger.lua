---@type NodeData
local data = {
  name = "fivem/shared/utils/trigger",
  inputs = {
  },
  properties = {
  },
  widgets = {
  },
  outputs = { {
    name = "trigger",
    type = -1
  } },

}

local Node = NodeFactory:extend({
  data = data
})

-- Node will be called when the blueprint is executed.
function Node:Execute()
  self:setOutputData("trigger", true)
  self:Next()
end

Nodes:Create("fivem/shared/utils/trigger", Node)
