---@class CLMainImpl : Impl
---@class CLImpl : Impl
local Impl = NewSyncImpl("Main")


function Impl:Init()
  self.showUI = false
  main:LogInfo("%s initialized", self:GetName())
  self:RegisterCommands()
  self:NuiHandlers()
end

function Impl:OnReady()
  main:LogInfo("%s ready", self:GetName())
end

function Impl:Open()
  if self.showUI then return end
  self.showUI = true
  SendNUIMessage({
    event = "main:setShow",
    data = true
  })
  SetNuiFocus(true, true)
end

function Impl:Close()
  if not self.showUI then return end
  self.showUI = false
  SendNUIMessage({
    event = "main:setShow",
    data = false
  })
  SetNuiFocus(false, false)
end

function Impl:RegisterCommands()
  RegisterCommand("blueprint", function(source, args, raw)
    self:Open()
  end, false)
end

function Impl:NuiHandlers()
  RegisterNUICallback("close", function(body, resultCallback)
    resultCallback("ok")
    self:Close()
  end)
  RegisterNUICallback("loadNodes", function(body, resultCallback)
    local nodes = Nodes:GetNUIData()
    print(json.encode(nodes))
    resultCallback(nodes)
  end)
end

Impl.start()
