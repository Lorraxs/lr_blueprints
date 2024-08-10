Exports = setmetatable({}, {
  __call = function(t, exportName, func)
    t[exportName] = func
  end,
  __index = function(t, exportName)
    return t[exportName]
  end
})

exports("callExport", function(exportName, input)
  local func = Exports[exportName]
  if func then
    return func(input)
  end
  return nil
end)
