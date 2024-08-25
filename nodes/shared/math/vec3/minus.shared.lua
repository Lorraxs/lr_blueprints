local MathVectorMinusNode = NodeFactory:extend({
  data = {
    name = "fivem/shared/math/vec3/minus",
    inputs = {
      { name = "coords", type = 'vec3' }
    },
    properties = {
      { name = "offsetX", type = "number", default_value = 0.0 },
      { name = "offsetY", type = "number", default_value = 0.0 },
      { name = "offsetZ", type = "number", default_value = 0.0 },
    },
    widgets = {
      { type = "number", name = "offsetX", value = 0.0, extra_info = { property = "offsetX" } },
      { type = "number", name = "offsetY", value = 0.0, extra_info = { property = "offsetY" } },
      { type = "number", name = "offsetZ", value = 0.0, extra_info = { property = "offsetZ" } },
    },
    outputs = { {
      name = "coords",
      type = "vec3"
    } },
    title = "VEC3 SUBTRACT"

  }
})

function MathVectorMinusNode:Execute()
  local coords = self:getInputData("coords")
  if not self.cache.offset then
    self.cache.offset = vector3(self:getProperty("offsetX"), self:getProperty("offsetY"),
      self:getProperty("offsetZ"))
  end
  local newCoords = coords - self.cache.offset
  self:setOutputData("coords", newCoords)
  self:Next()
end

Nodes:Create('fivem/shared/math/vec3/minus', MathVectorMinusNode)
