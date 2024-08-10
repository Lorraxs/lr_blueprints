---@class Nodes
_Nodes = class()

function _Nodes:Init()
  self.nodes = {}
end

function _Nodes:CheckNodeSide(name)
  if string.find(name, "fivem/shared") then
    return true
  end
  if string.find(name, "fivem/server") then
    return IsDuplicityVersion()
  else
    return not IsDuplicityVersion()
  end
end

function _Nodes:Create(name, impl)
  self.nodes[name] = impl
end

---@param name string
---@return NodeFactory | nil
function _Nodes:Get(name)
  if self:CheckNodeSide(name) then
    return self.nodes[name]
  end
end

function _Nodes:GetNUIData()
  local arr = {}
  for k, v in pairs(self.nodes) do
    table.insert(arr, v.data)
  end
  return arr
end

---@type Nodes
Nodes = _Nodes()
