---@type NodeFactory
local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/const/number",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "value", type = "number", default_value = 0.0 },
    },
    widgets = {
      { type = "number", name = "value", value = 0.0, extra_info = { property = "value" } },
    },
    outputs = { {
      name = "value",
      type = "number"
    } },
    title = "NUMBER CONST"

  }
})

function Node:Execute()
  local value = self:getProperty("value")
  self:setOutputData("value", value)
  self:Next()
end

Nodes:Create('fivem/shared/utils/const/number', Node)


local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/const/string",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "value", type = "string", default_value = 0.0 },
    },
    widgets = {
      { type = "string", name = "value", value = 0.0, extra_info = { property = "value" } },
    },
    outputs = { {
      name = "value",
      type = "string"
    } },
    title = "STRING CONST"

  }
})

function Node:Execute()
  local value = self:getProperty("value")
  self:setOutputData("value", value)
  self:Next()
end

Nodes:Create('fivem/shared/utils/const/string', Node)

local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/const/boolean",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "value", type = "boolean", default_value = 0.0 },
    },
    widgets = {
      { type = "toggle", name = "value", value = 0.0, extra_info = { property = "value" } },
    },
    outputs = { {
      name = "value",
      type = "boolean"
    } },
    title = "BOOLEAN CONST"

  }
})

function Node:Execute()
  local value = self:getProperty("value")
  self:setOutputData("value", value)
  self:Next()
end

Nodes:Create('fivem/shared/utils/const/boolean', Node)

local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/const/object",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "value", type = "string", default_value = 0.0 },
    },
    widgets = {
      { type = "string", name = "value", value = 0.0, extra_info = { property = "value" } },
    },
    outputs = { {
      name = "value",
      type = "object"
    } },
    title = "OBJECT CONST"

  }
})

function Node:Execute()
  local value = self:getProperty("value")
  self:setOutputData("value", json.decode(value))
end

Nodes:Create('fivem/shared/utils/const/object', Node)

local Node = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/const/vec3",
    inputs = {
      { name = "trigger", type = -1 }
    },
    properties = {
      { name = "x", type = "number", default_value = 0.0 },
      { name = "y", type = "number", default_value = 0.0 },
      { name = "z", type = "number", default_value = 0.0 },
    },
    widgets = {
      { type = "number", name = "x", value = 0.0, extra_info = { property = "x" } },
      { type = "number", name = "y", value = 0.0, extra_info = { property = "y" } },
      { type = "number", name = "z", value = 0.0, extra_info = { property = "z" } },
    },
    outputs = { {
      name = "value",
      type = "vec3"
    } },
    title = "VEC3 CONST"

  }
})

function Node:Execute()
  local x = self:getProperty("x")
  local y = self:getProperty("y")
  local z = self:getProperty("z")
  self:setOutputData("value", vector3(x, y, z))
  self:Next()
end

Nodes:Create('fivem/shared/utils/const/vec3', Node)
