local PrintNode = NodeFactory:extend({
  data = {
    name = "fivem/shared/utils/print",
    inputs = {
      { name = "msg", type = 0, extra_info = { label = "Message" } },
    },
    outputs = {
    },
    widgets = {
    },
    title = "PRINT"
  }
})

function PrintNode:Execute()
  local msg = self:getInputData("msg")
  if type(msg) == "table" then
    self:LogInfo(json.encode(msg))
  else
    self:LogInfo(msg)
  end
end

Nodes:Create('fivem/shared/utils/print', PrintNode)
