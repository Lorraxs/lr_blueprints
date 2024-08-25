local Node = NodeFactory:extend({
  data = {
    name = "fivem/client/entity/PlayerPedId",
    inputs = {
      { name = "ontick", type = -1 },
    },
    outputs = { {
      name = "ped",
      type = "number"
    } },
    title = "PlayerPedId"
  }
})


function Node:Execute()
  self:setOutputData("ped", main.playerPed)
  self:Next()
end

Nodes:Create('fivem/client/entity/PlayerPedId', Node)
