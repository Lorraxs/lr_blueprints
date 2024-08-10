---@class SVMainImpl : Impl
local Impl = NewSyncImpl("Main")

function Impl:Init()
  self.blueprintData = {}
  self:LogInfo("%s initialized", self:GetName())
  self:EventHandlers()
end

function Impl:OnReady()
  self:LogInfo("%s ready", self:GetName())
end

function Impl:EventHandlers()

end

Impl.start()
