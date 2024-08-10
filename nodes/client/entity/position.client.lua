if IsDuplicityVersion() then return end
local PositionNode = NodeFactory:extend({
  data = {
    name = "fivem/client/entity/position",
    inputs = {
      { name = "ped", type = "number" },
    },
    outputs = { {
      name = "position",
      type = "vec3"
    } },
    properties = {
      {
        name = "position",
        type = "vec3",
        default = {
          x = main.playerCoords.x,
          y = main.playerCoords.y,
          z = main.playerCoords.z
        }
      }
    },
    title = "Entity Position"
  }
})

function PositionNode:Execute()
  local ped = self:getInputData("ped")
  local coords = GetEntityCoords(ped)
  self:setOutputData("position", coords)
  self.blueprint:NextNode(self)
end

Nodes:Create('fivem/client/entity/position', PositionNode)
