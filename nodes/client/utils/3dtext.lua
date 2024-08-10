---@type NodeData
local data = {
  name = "fivem/client/utils/3dtext",
  inputs = {
    { name = "value",   type = "string" },
    { name = "coords",  type = "vec3" },
    { name = "trigger", type = -1 }
  },
  properties = {
  },
  widgets = {
  },
  outputs = {},
  title = "3D Text",
}

local Node = NodeFactory:extend({
  data = data
})

local function Draw3DText(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoords())

  if onScreen then
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropShadow(0, 0, 0, 55)
    SetTextEdge(0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
  end
end


-- Node will be called in the blueprint execution loop.
function Node:Execute()
  local value = self:getInputData("value")
  local coords = self:getInputData("coords")
  Draw3DText(coords.x, coords.y, coords.z, value)
end

Nodes:Create("fivem/client/utils/3dtext", Node)
