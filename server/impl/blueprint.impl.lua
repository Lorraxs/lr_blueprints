---@class SVBlueprintImpl : Impl
local Impl = NewSyncImpl("Blueprint")

function Impl:Init()
  self:LogInfo("%s initialized", self:GetName())
  ---@type table<string, Blueprint>
  self.blueprints = {}
  self:GetData()
  self:EventHandlers()
end

function Impl:GetData()
  local data = Supabase.Database.Query("SELECT * FROM blueprints ORDER BY created_at")
  self:LogInfo("blueprints %s", json.encode(data))
  for _, v in pairs(data) do
    local blueprint = self:AddBlueprint(v)
    if blueprint.start then
      blueprint:Execute()
    end
  end
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

function Impl:AddBlueprint(data)
  print(json.encode(data))
  self.blueprints[data.name] = Blueprint(data)
  return self.blueprints[data.name]
end

function Impl:EventHandlers()
  lib.callback.register('blueprints:add', function(source, data)
    local name = data.name
    local side = data.side
    if not name or not side then
      return {
        status = "ERROR",
        message = "Invalid data"
      }
    end
    if self.blueprints[name] then
      return {
        status = "ERROR",
        message = "Blueprint already exists"
      }
    end
    local response = Supabase.Database.Query(
      "INSERT INTO blueprints (name, data, side, start) VALUES ($1, $2, $3, false) RETURNING *",
      { name, {}, side })
    self:LogInfo("blueprints:add %s", json.encode(response))
    if not response then
      return {
        status = "ERROR",
        message = "Failed to add blueprint"
      }
    end
    if response[1] then
      local blueprint = self:AddBlueprint(response[1])
      TriggerClientEvent('blueprints:add', -1, blueprint:serialize())
      return {
        status = "SUCCESS",
        data = blueprint:serialize()
      }
    end
    local blueprint = self:AddBlueprint(data)
    return {
      status = "SUCCESS",
      data = blueprint:serialize()
    }
  end)
  lib.callback.register('blueprints:update', function(source, data)
    self:LogInfo("blueprints:update %s", json.encode(data))
    Supabase.Database.Query(
      "INSERT INTO blueprints (name, data) VALUES ($1, $2) ON CONFLICT (name) DO UPDATE SET data = $2",
      { data.name, data.data })
    local blueprint = self.blueprints[data.name]
    if blueprint then
      blueprint:Update(data.data)
      TriggerClientEvent('blueprints:update', -1, blueprint.name, data.data)
      return {
        status = "SUCCESS",
        data = blueprint:serialize()
      }
    end
    return {
      status = "ERROR",
      message = "Blueprint not found"
    }
  end)
  lib.callback.register('blueprints:delete', function(source, name)
    self:LogInfo("Deleting blueprint %s", name)
    if self.blueprints[name] then
      self.blueprints[name]:Clear()
      self.blueprints[name] = nil
      Supabase.Database.Query("DELETE FROM blueprints WHERE name = $1", { name })
      TriggerClientEvent("blueprints:delete", -1, name)
      return true
    end
    return false
  end)
  lib.callback.register('blueprints:toggle', function(source, name)
    self:LogInfo("Toggling blueprint %s", name)
    local blueprint = self.blueprints[name]
    if blueprint then
      blueprint:Toggle(not blueprint.start)
      self:LogInfo("Toggled blueprint %s %s", name, blueprint.start)
      Supabase.Database.Query("UPDATE blueprints SET start = $1 WHERE name = $2", { blueprint.start, name })
      TriggerClientEvent("blueprints:toggle", -1, name, blueprint.start)
      return {
        status = "SUCCESS",
        data = blueprint.start
      }
    end
    return false
  end)
  lib.callback.register('blueprints:getAll', function(source)
    return self:NuiData()
  end)
  RegisterNetEvent("blueprints:test", function(data)
    local blueprint = self.blueprints[data.name]
    if blueprint then
      self:LogInfo("Testing blueprint %s %s", data.name, json.encode(data.data))
      blueprint:Update(data.data)
      if not blueprint.start then
        blueprint:Execute()
      end
    end
  end)
end

Impl.start()
