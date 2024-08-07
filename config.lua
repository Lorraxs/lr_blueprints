Config = {}

Config.Dependencies = {} -- Reqired resources loaded to start
Config.Locale = 'vi'

Config.Settings = {
  locale = Locales[Config.Locale] or Locales['default']
}

--Dont touch this
Config.EnableModules = {
  ["Newbie"] = {
    enabled = true,
    client = true, -- enable client side
    priority = 1,  -- 1 : init on start | 2 : init on player loaded
  },
  ["Test"] = {
    enabled = true,
    priority = 2, -- 1 : init on start | 2 : init on player loaded
  },
}
Config.Debug = true
Config.Nui = false
Config.Dev = false
---@type "qb" | "esx" | "ProjectStarboy" | "standalone"
Config.Framework = "standalone" -- "qb" | "esx" | "custom"
Config.ClientLazyLoad = false

function L(key, ...)
  if Config.Settings.locale[key] then
    return string.format(Config.Settings.locale[key], ...)
  else
    return key
  end
end
