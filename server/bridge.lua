function HasItem(player, itemName, amount)
  if Config.Framework == 'ProjectStarboy' then
    return player.hasItem({
      itemName = itemName,
      amount = amount
    })
  elseif Config.Framework == 'esx' then
    local xItem = player.hasItem(itemName)
    if not xItem then return false end
    return xItem.count >= amount
  end
end

function RemoveItem(player, itemName, amount)
  if Config.Framework == 'ProjectStarboy' then
    return player.removeInventoryItem({
      itemName = itemName,
      amount = amount
    })
  elseif Config.Framework == 'esx' then
    return player.removeInventoryItem(itemName, amount)
  end
end

function AddMoney(player, type, amount)
  if Config.Framework == 'ProjectStarboy' then
    return player.addAccountMoney(type, amount)
  elseif Config.Framework == 'esx' then
    return player.addMoney(amount)
  end
end

function HasMoney(player, type, amount)
  if Config.Framework == 'ProjectStarboy' then
    return player.getAccountMoney(type) >= amount
  elseif Config.Framework == 'esx' then
    return player.getAccountMoney(type).money >= amount
  end
end

function RemoveMoney(player, type, amount)
  if Config.Framework == 'ProjectStarboy' then
    return player.removeAccountMoney(type, amount)
  elseif Config.Framework == 'esx' then
    return player.addMoney(amount)
  end
end

function GetPlayerFromId(playerSrc)
  if Config.Framework == 'ProjectStarboy' then
    return Framework.GetPlayerFromSource(playerSrc)
  elseif Config.Framework == 'esx' then
    return Framework.GetPlayerFromId(playerSrc)
  end
end

function ShowNotification(playerSrc, message, type)
  if Config.Framework == "ProjectStarboy" then
    return TriggerClientEvent("Player:ShowNotification", playerSrc, {
      message = message,
      type = type
    })
  end
end

function AddExp(playerSrc, amount)
  if Config.Framework == "ProjectStarboy" then
    return exports.ProjectStarboy:addExp(playerSrc, amount)
  end
end

function AddSkillExp(playerSrc, skill, amount)
  if Config.Framework == "ProjectStarboy" then
    return exports.ProjectStarboy:addSkillExp(playerSrc, skill, amount)
  end
end
