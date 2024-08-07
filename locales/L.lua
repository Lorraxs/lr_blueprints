Locales = {}

function L(key, args)
  if not args then args = {} end
  if type(args) ~= "table" then args = {} end
  if Config.Settings.locale[key] then
    local pattern = Config.Settings.locale[key]
    for k, v in pairs(args) do
      pattern = pattern:gsub(":{" .. k .. "}", v)
    end
    return pattern
  else
    return key
  end
end
