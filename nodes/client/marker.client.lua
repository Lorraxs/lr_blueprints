local MarkerNode = NodeFactory:extend({
  data = {
    name = "fivem/client/graphics/marker",
    inputs = {
      { name = "coords",  type = "vec3" },
      { name = "trigger", type = -1 }
    },
    outputs = {},
    properties = {
      { name = "type",         type = "number",  default_value = 1 },
      { name = "dirX",         type = "number",  default_value = 0.0 },
      { name = "dirY",         type = "number",  default_value = 0.0 },
      { name = "dirZ",         type = "number",  default_value = 0.0 },
      { name = "rotX",         type = "number",  default_value = 0.0 },
      { name = "rotY",         type = "number",  default_value = 0.0 },
      { name = "rotZ",         type = "number",  default_value = 0.0 },
      { name = "scaleX",       type = "number",  default_value = 1.0 },
      { name = "scaleY",       type = "number",  default_value = 1.0 },
      { name = "scaleZ",       type = "number",  default_value = 1.0 },
      { name = "red",          type = "number",  default_value = 255 },
      { name = "green",        type = "number",  default_value = 255 },
      { name = "blue",         type = "number",  default_value = 255 },
      { name = "alpha",        type = "number",  default_value = 255 },
      { name = "bobUpAndDown", type = "boolean", default_value = false },
      { name = "faceCamera",   type = "boolean", default_value = false },
      { name = "textureDict",  type = "string",  default_value = nil },
      { name = "textureName",  type = "string",  default_value = nil },
      { name = "drawOnEnts",   type = "boolean", default_value = false },
    },
    widgets = {
      { type = "number", name = "type",   value = 1,   extra_info = { property = "type" } },
      { type = "number", name = "dirX",   value = 0.0, extra_info = { property = "dirX" } },
      { type = "number", name = "dirY",   value = 0.0, extra_info = { property = "dirY" } },
      { type = "number", name = "dirZ",   value = 0.0, extra_info = { property = "dirZ" } },
      { type = "number", name = "rotX",   value = 0.0, extra_info = { property = "rotX" } },
      { type = "number", name = "rotY",   value = 0.0, extra_info = { property = "rotY" } },
      { type = "number", name = "rotZ",   value = 0.0, extra_info = { property = "rotZ" } },
      { type = "number", name = "scaleX", value = 1.0, extra_info = { property = "scaleX" } },
      { type = "number", name = "scaleY", value = 1.0, extra_info = { property = "scaleY" } },
      { type = "number", name = "scaleZ", value = 1.0, extra_info = { property = "scaleZ" } },
      { type = "number", name = "red",    value = 255, extra_info = { property = "red" } },
      { type = "number", name = "green",  value = 255, extra_info = { property = "green" } },
      { type = "number", name = "blue",   value = 255, extra_info = { property = "blue" } },
      { type = "number", name = "alpha",  value = 255, extra_info = { property = "alpha" } },
    },
    title = "DrawMarker"
  }
})

function MarkerNode:Execute()
  local coords = self:getInputData("coords")
  self.blueprint:NextNode(self)
  DrawMarker(
    self:getProperty("type"),
    coords.x, coords.y, coords.z,
    self:getProperty("dirX") + 0.0,
    self:getProperty("dirY") + 0.0,
    self:getProperty("dirZ") + 0.0,
    self:getProperty("rotX") + 0.0,
    self:getProperty("rotY") + 0.0,
    self:getProperty("rotZ") + 0.0,
    self:getProperty("scaleX") + 0.0,
    self:getProperty("scaleY") + 0.0,
    self:getProperty("scaleZ") + 0.0,
    self:getProperty("red"),
    self:getProperty("green"),
    self:getProperty("blue"),
    self:getProperty("alpha"),
    self:getProperty("bobUpAndDown"),
    self:getProperty("faceCamera"),
    2,
    self:getProperty("drawOnEnts"),
    self:getProperty("textureDict"),
    self:getProperty("textureName"),
    self:getProperty("drawOnEnts")
  )
end

Nodes:Create('fivem/client/graphics/marker', MarkerNode)
