---@class CLBlueprintImpl : Impl
local Impl = NewSyncImpl("Blueprint")

function Impl:Init()
  self:LogInfo("%s initialized", self:GetName())
  ---@type table<string, Blueprint>
  self.blueprints = {}
  self:NuiHandlers()
  self:EventHandlers()
  self:GetData()
  --[[ self:TestBlueprint() ]]
end

function Impl:GetData()
  Wait(1000)
  local data = lib.callback.await("blueprints:getAll", 400)
  self:LogInfo("blueprints %s", json.encode(data))
  for _, v in pairs(data) do
    local blueprint = self:AddBlueprint(v)
    if v.start then
      blueprint:Execute()
    end
  end
end

function Impl:TestBlueprint()
  self:AddBlueprint(json.decode(
    '{"data":{"version":0.4,"last_node_id":4,"groups":[],"links":[[2,3,0,1,0,-1],[3,1,0,4,0,"vec3"]],"config":[],"extra":[],"nodes":[{"properties":{"interval":0},"type":"shared/thread","outputs":[{"slot_index":0,"name":"action","type":-1,"links":[2]}],"size":{"1":58,"0":210},"id":3,"pos":[44,164],"order":0,"flags":[],"mode":0},{"inputs":[{"name":"coords","type":"vec3","link":3}],"type":"client/graphics/marker","size":{"1":370,"0":210},"id":4,"pos":[506,309],"order":2,"flags":[],"properties":{"faceCamera":false,"rotX":0,"drawOnEnts":false,"red":255,"scaleZ":0,"alpha":255,"bobUpAndDown":false,"scaleX":0,"dirY":0,"dirX":0,"rotZ":0,"type":1,"green":255,"blue":255,"rotY":0,"dirZ":0,"scaleY":0},"mode":0},{"inputs":[{"name":"trigger","type":-1,"link":2}],"type":"client/position","outputs":[{"slot_index":0,"name":"position","type":"vec3","links":[3]}],"size":{"1":26,"0":140},"mode":0,"pos":[279,139],"order":1,"flags":[],"id":1,"properties":{"position":{"y":-644.36279296875,"z":39.97521209716797,"x":254.6207275390625}}}],"last_link_id":3},"name":"tt2"}'))
end

function Impl:OnReady()
  self:LogInfo("%s ready", self:GetName())
end

function Impl:NuiData()
  local o = {}
  for k, v in pairs(self.blueprints) do
    table.insert(o, v:serialize())
  end
  return o
end

function Impl:GuardBody(body)
  for k, node in ipairs(body.data.nodes) do
    if node.outputs then
      for _, output in ipairs(node.outputs) do
        output.data = nil
      end
    end
  end
  return body
end

function Impl:NuiHandlers()
  RegisterNUICallback("addBlueprint", function(body, resultCallback)
    local response = lib.callback.await("blueprints:add", 400, body)
    self:LogInfo("blueprints:add %s", json.encode(response))
    resultCallback(response)
  end)
  RegisterNUICallback("test", function(body, resultCallback)
    self:LogInfo("testtt %s", json.encode(body))
    local blueprint = self.blueprints[body.name]
    if blueprint then
      if blueprint.side == "client" or blueprint.side == "shared" then
        blueprint:Update(body.data)
        if not blueprint.start then
          blueprint:Execute()
        end
      end
      if blueprint.side == "server" or blueprint.side == "shared" then
        TriggerServerEvent("blueprints:test", body)
      end
    end
  end)
  RegisterNUICallback("loadData", function(body, resultCallback)
    resultCallback(self:NuiData())
  end)
  RegisterNUICallback("save", function(body, resultCallback)
    body = self:GuardBody(body)
    self:LogInfo("blueprints:save %s", json.encode(body))
    local response = lib.callback.await("blueprints:update", 400, body)
    self:LogInfo("blueprints:update %s", json.encode(response))
    resultCallback(response)
  end)
  RegisterNUICallback("delete", function(body, resultCallback)
    local response = lib.callback.await("blueprints:delete", 400, body)
    if response then
      resultCallback({
        status = "SUCCESS"
      })
    else
      resultCallback({
        status = "ERROR"
      })
    end
  end)
  RegisterNUICallback("toggle", function(body, resultCallback)
    local response = lib.callback.await("blueprints:toggle", 400, body)
    resultCallback(response)
  end)
end

function Impl:AddBlueprint(data)
  self.blueprints[data.name] = Blueprint(data)
  return self.blueprints[data.name]
end

function Impl:EventHandlers()
  RegisterNetEvent("blueprints:update", function(name, data)
    self:LogInfo("blueprints:update %s - %s", name, json.encode(data))
    local blueprint = self.blueprints[name]
    if blueprint then
      blueprint:Update(data)
    end
  end)
  RegisterNetEvent("blueprints:delete", function(name)
    self:LogInfo("Deleting blueprint %s", name)
    if self.blueprints[name] then
      self.blueprints[name]:Clear()
      self.blueprints[name] = nil
    end
  end)
  RegisterNetEvent("blueprints:toggle", function(name, state)
    local blueprint = self.blueprints[name]
    if blueprint then
      self:LogInfo("Toggling blueprint %s %s", name, state)
      blueprint:Toggle(state)
    end
  end)
  RegisterNetEvent("blueprints:add", function(data)
    self:LogInfo("blueprints:add %s", json.encode(data))
    self:AddBlueprint(data)
  end)
end

Impl.start()
