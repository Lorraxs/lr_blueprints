---@type NodeData
local data = {
  name = "fivem/shared/math/vec3/unpack",
  inputs = {
    { name = "value", type = "vec3" },
  },
  properties = {
  },
  widgets = {
  },
  outputs = {
    { name = "x", type = "number" },
    { name = "y", type = "number" },
    { name = "z", type = "number" },
  },
  title = "Unpack vec3"
}

local Node = NodeFactory:extend({
  data = data
})


-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local value = self:getInputData("value")
  self:setOutputData("x", value.x)
  self:setOutputData("y", value.y)
  self:setOutputData("z", value.z)
  self:Next()
end

Nodes:Create("fivem/shared/math/vec3/unpack", Node)
