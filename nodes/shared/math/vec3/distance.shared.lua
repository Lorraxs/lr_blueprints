local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/math/vec3/distance",
    inputs = {
      { name = "from", type = 'vec3' },
      { name = "to",   type = 'vec3' },
    },
    outputs = { {
      name = "distance",
      type = "number"
    } },
    title = "VEC3 DISTANCE"

  }
})

function Node:Execute()
  local from = self:getInputData("from")
  local to = self:getInputData("to")
  local distance = #(from - to)
  self:setOutputData("distance", distance)
  self:Next()
end

Nodes:Create('fivem/shared/math/vec3/distance', Node)
