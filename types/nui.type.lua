---@alias INuiEvents "BoilerPlateService:var:constructor"|"BoilerPlateService:var:setValue"|"BoilerPlateService:var:getValue"|"main:setShow"

---@param event INuiEvents
---@param data any
function NuiDispatch(event, data)
  SendNUIMessage({ type = event, data = data })
end
