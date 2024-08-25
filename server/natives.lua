serverNatives = {
  {
    name = "AddBlipForArea",
    params = {
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "width",
        type = "number",
      },
      {
        name = "height",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "N_0xce5d0e5e315db238",
    params = {
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "width",
        type = "number",
      },
      {
        name = "height",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "AddBlipForCoord",
    params = {
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "AddBlipForEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "AddBlipForRadius",
    params = {
      {
        name = "posX",
        type = "number",
      },
      {
        name = "posY",
        type = "number",
      },
      {
        name = "posZ",
        type = "number",
      },
      {
        name = "radius",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "AddPedDecorationFromHashes",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "collection",
        type = "string|number",
      },
      {
        name = "overlay",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "ApplyPedOverlay",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "collection",
        type = "string|number",
      },
      {
        name = "overlay",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedDecoration",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "collection",
        type = "string|number",
      },
      {
        name = "overlay",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "AddStateBagChangeHandler",
    params = {
      {
        name = "keyFilter",
        type = "string",
      },
      {
        name = "bagFilter",
        type = "string",
      },
      {
        name = "handler",
        type = "Function",
      },
    },
    ret = { "number" }
  },
  {
    name = "ApplyForceToEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "forceType",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "offX",
        type = "number",
      },
      {
        name = "offY",
        type = "number",
      },
      {
        name = "offZ",
        type = "number",
      },
      {
        name = "boneIndex",
        type = "number",
      },
      {
        name = "isDirectionRel",
        type = "boolean",
      },
      {
        name = "ignoreUpVec",
        type = "boolean",
      },
      {
        name = "isForceRel",
        type = "boolean",
      },
      {
        name = "p12",
        type = "boolean",
      },
      {
        name = "p13",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "CanPlayerStartCommerceSession",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "ClearPedProp",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "propId",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "ClearPedSecondaryTask",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "ClearPedTasks",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "ClearPedTasksImmediately",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "ClearPlayerWantedLevel",
    params = {
      {
        name = "player",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "CreateObject",
    params = {
      {
        name = "modelHash",
        type = "string|number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "isNetwork",
        type = "boolean",
      },
      {
        name = "netMissionEntity",
        type = "boolean",
      },
      {
        name = "doorFlag",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "CreateObjectNoOffset",
    params = {
      {
        name = "modelHash",
        type = "string|number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "isNetwork",
        type = "boolean",
      },
      {
        name = "netMissionEntity",
        type = "boolean",
      },
      {
        name = "doorFlag",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "CreatePed",
    params = {
      {
        name = "pedType",
        type = "number",
      },
      {
        name = "modelHash",
        type = "string|number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "heading",
        type = "number",
      },
      {
        name = "isNetwork",
        type = "boolean",
      },
      {
        name = "bScriptHostPed",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "CreatePedInsideVehicle",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "pedType",
        type = "number",
      },
      {
        name = "modelHash",
        type = "string|number",
      },
      {
        name = "seat",
        type = "number",
      },
      {
        name = "isNetwork",
        type = "boolean",
      },
      {
        name = "bScriptHostPed",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "CreateVehicle",
    params = {
      {
        name = "modelHash",
        type = "string|number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "heading",
        type = "number",
      },
      {
        name = "isNetwork",
        type = "boolean",
      },
      {
        name = "netMissionEntity",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "DeleteEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "DeleteFunctionReference",
    params = {
      {
        name = "referenceIdentity",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "DeleteResourceKvp",
    params = {
      {
        name = "key",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "DeleteResourceKvpNoSync",
    params = {
      {
        name = "key",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "DoesBoatSinkWhenWrecked",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "DoesEntityExist",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "DoesPlayerExist",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "DoesPlayerOwnSku",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "skuId",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "DoesPlayerOwnSkuExt",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "skuId",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "DropPlayer",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "reason",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "DuplicateFunctionReference",
    params = {
      {
        name = "referenceIdentity",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "EnableEnhancedHostSupport",
    params = {
      {
        name = "enabled",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "EndFindKvp",
    params = {
      {
        name = "handle",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "EnsureEntityStateBag",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "ExecuteCommand",
    params = {
      {
        name = "commandString",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "FindKvp",
    params = {
      {
        name = "handle",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "FreezeEntityPosition",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "toggle",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "GetAirDragMultiplierForPlayersVehicle",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetBlipSprite",
    params = {
      {
        name = "self",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetCurrentPedWeapon",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityAttachedTo",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityCollisionDisabled",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetEntityCoords",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetEntityFromStateBagName",
    params = {
      {
        name = "bagName",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityHeading",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityHealth",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityMaxHealth",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityModel",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityPopulationType",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityRotation",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetEntityRotationVelocity",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetEntityRoutingBucket",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityScript",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetEntitySpeed",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityType",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetEntityVelocity",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetHashKey",
    params = {
      {
        name = "model",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetHeliMainRotorHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetHeliTailRotorHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetIsVehicleEngineRunning",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetIsVehiclePrimaryColourCustom",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetIsVehicleSecondaryColourCustom",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetLandingGearState",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetLastPedInVehicleSeat",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "seatIndex",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetNumPlayerIdentifiers",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetNumPlayerTokens",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetNumResourceMetadata",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
      {
        name = "metadataKey",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPasswordHash",
    params = {
      {
        name = "password",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPedArmour",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedCauseOfDeath",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedDesiredHeading",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedInVehicleSeat",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "seatIndex",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedMaxHealth",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedScriptTaskCommand",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedScriptTaskStage",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedSourceOfDamage",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedSourceOfDeath",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedSpecificTaskType",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "index",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPedStealthMovement",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetPlayerCameraRotation",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetPlayerEndpoint",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerFakeWantedLevel",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerFromIndex",
    params = {
      {
        name = "index",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerFromStateBagName",
    params = {
      {
        name = "bagName",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerGuid",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerIdentifier",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "identifier",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerIdentifierByType",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "identifierType",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerInvincible",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetPlayerLastMsg",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerMaxArmour",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerMaxHealth",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerMeleeWeaponDamageModifier",
    params = {
      {
        name = "playerId",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerName",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerPed",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerPing",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerRoutingBucket",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerTeam",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerTimeInPursuit",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "lastPursuit",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerToken",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "index",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetPlayerWantedCentrePosition",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "GetPlayerWantedLevel",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerWeaponDamageModifier",
    params = {
      {
        name = "playerId",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerWeaponDefenseModifier",
    params = {
      {
        name = "playerId",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetPlayerWeaponDefenseModifier_2",
    params = {
      {
        name = "playerId",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetResourceByFindIndex",
    params = {
      {
        name = "findIndex",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetResourceKvpFloat",
    params = {
      {
        name = "key",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetResourceKvpInt",
    params = {
      {
        name = "key",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetResourceKvpString",
    params = {
      {
        name = "key",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetResourceMetadata",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
      {
        name = "metadataKey",
        type = "string",
      },
      {
        name = "index",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetResourcePath",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetResourceState",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetSelectedPedWeapon",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetStateBagValue",
    params = {
      {
        name = "bagName",
        type = "string",
      },
      {
        name = "key",
        type = "string",
      },
    },
    ret = { "any" }
  },
  {
    name = "GetTrainCarriageEngine",
    params = {
      {
        name = "train",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetTrainCarriageIndex",
    params = {
      {
        name = "train",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleBodyHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleColours",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number", "number" }
  },
  {
    name = "GetVehicleCustomPrimaryColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number", "number", "number" }
  },
  {
    name = "GetVehicleCustomSecondaryColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number", "number", "number" }
  },
  {
    name = "GetVehicleDashboardColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "color?",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleDirtLevel",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleDoorLockStatus",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleDoorStatus",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleDoorsLockedForPlayer",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleEngineHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleExtraColours",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number", "number" }
  },
  {
    name = "GetVehicleFlightNozzlePosition",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleHandbrake",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "GetVehicleHeadlightsColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleHomingLockonState",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleInteriorColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "color?",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleLightsState",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean", "any", "any" }
  },
  {
    name = "GetVehicleLivery",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleLockOnTarget",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleNumberPlateText",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetVehicleNumberPlateTextIndex",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehiclePedIsIn",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "lastVehicle",
        type = "boolean",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehiclePetrolTankHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleRadioStationIndex",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleRoofLivery",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleSteeringAngle",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleType",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "string" }
  },
  {
    name = "GetVehicleTyreSmokeColor",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number", "number", "number" }
  },
  {
    name = "GetVehicleWheelType",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GetVehicleWindowTint",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "GiveWeaponComponentToPed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
      {
        name = "componentHash",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "GiveWeaponToPed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
      {
        name = "ammoCount",
        type = "number",
      },
      {
        name = "isHidden",
        type = "boolean",
      },
      {
        name = "bForceInHand",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "HasEntityBeenMarkedAsNoLongerNeeded",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "HasVehicleBeenDamagedByBullets",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "HasVehicleBeenOwnedByPlayer",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsAceAllowed",
    params = {
      {
        name = "object",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsBoatAnchoredAndFrozen",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsBoatWrecked",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsEntityPositionFrozen",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsEntityVisible",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsFlashLightOn",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPedAPlayer",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPedHandcuffed",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPedRagdoll",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPedStrafing",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPedUsingActionMode",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPlayerAceAllowed",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "object",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPlayerCommerceInfoLoaded",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPlayerCommerceInfoLoadedExt",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPlayerEvadingWantedLevel",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPlayerUsingSuperJump",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsPrincipalAceAllowed",
    params = {
      {
        name = "principal",
        type = "string",
      },
      {
        name = "object",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsVehicleEngineStarting",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsVehicleExtraTurnedOn",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "extraId",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsVehicleSirenOn",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsVehicleTyreBurst",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "wheelID",
        type = "number",
      },
      {
        name = "completely",
        type = "boolean",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "IsVehicleWindowIntact",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "windowIndex",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "LoadPlayerCommerceData",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "LoadPlayerCommerceDataExt",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "LoadResourceFile",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
      {
        name = "fileName",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "MumbleCreateChannel",
    params = {
      {
        name = "id",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "MumbleIsPlayerMuted",
    params = {
      {
        name = "playerSrc",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "MumbleSetPlayerMuted",
    params = {
      {
        name = "playerSrc",
        type = "number",
      },
      {
        name = "toggle",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "NetworkGetEntityFromNetworkId",
    params = {
      {
        name = "netId",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "NetworkGetEntityOwner",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "NetworkGetFirstEntityOwner",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "NetworkGetNetworkIdFromEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "NetworkGetVoiceProximityOverrideForPlayer",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
    },
    ret = { "vec3" }
  },
  {
    name = "PerformHttpRequestInternal",
    params = {
      {
        name = "requestData",
        type = "string",
      },
      {
        name = "requestDataLength",
        type = "number",
      },
    },
    ret = { "number" }
  },
  {
    name = "PerformHttpRequestInternalEx",
    params = {
      {
        name = "requestData",
        type = "any",
      },
    },
    ret = { "number" }
  },
  {
    name = "PrintStructuredTrace",
    params = {
      {
        name = "jsonString",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "ProfilerEnterScope",
    params = {
      {
        name = "scopeName",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "RegisterCommand",
    params = {
      {
        name = "commandName",
        type = "string",
      },
      {
        name = "handler",
        type = "Function",
      },
      {
        name = "restricted",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "RegisterConsoleListener",
    params = {
      {
        name = "listener",
        type = "Function",
      },
    },
    ret = {}
  },
  {
    name = "RegisterResourceAsEventHandler",
    params = {
      {
        name = "eventName",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "RegisterResourceAsset",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
      {
        name = "fileName",
        type = "string",
      },
    },
    ret = { "string" }
  },
  {
    name = "RegisterResourceBuildTaskFactory",
    params = {
      {
        name = "factoryId",
        type = "string",
      },
      {
        name = "factoryFn",
        type = "Function",
      },
    },
    ret = {}
  },
  {
    name = "RemoveAllPedWeapons",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "p1",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "RemoveBlip",
    params = {
      {
        name = "blip",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "RemoveStateBagChangeHandler",
    params = {
      {
        name = "cookie",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "RemoveWeaponComponentFromPed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
      {
        name = "componentHash",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "RemoveWeaponFromPed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "RequestPlayerCommerceSession",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "skuId",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SaveResourceFile",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
      {
        name = "fileName",
        type = "string",
      },
      {
        name = "data",
        type = "string",
      },
      {
        name = "dataLength",
        type = "number",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "ScanResourceRoot",
    params = {
      {
        name = "rootPath",
        type = "string",
      },
      {
        name = "callback",
        type = "Function",
      },
    },
    ret = {}
  },
  {
    name = "ScheduleResourceTick",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetBlipSprite",
    params = {
      {
        name = "blip",
        type = "number",
      },
      {
        name = "spriteId",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetConvar",
    params = {
      {
        name = "varName",
        type = "string",
      },
      {
        name = "value",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetConvarReplicated",
    params = {
      {
        name = "varName",
        type = "string",
      },
      {
        name = "value",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetConvarServerInfo",
    params = {
      {
        name = "varName",
        type = "string",
      },
      {
        name = "value",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetCurrentPedWeapon",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
      {
        name = "bForceInHand",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityCoords",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "xPos",
        type = "number",
      },
      {
        name = "yPos",
        type = "number",
      },
      {
        name = "zPos",
        type = "number",
      },
      {
        name = "alive",
        type = "boolean",
      },
      {
        name = "deadFlag",
        type = "boolean",
      },
      {
        name = "ragdollFlag",
        type = "boolean",
      },
      {
        name = "clearArea",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityDistanceCullingRadius",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "radius",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityHeading",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "heading",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityIgnoreRequestControlFilter",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "ignore",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityRotation",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "pitch",
        type = "number",
      },
      {
        name = "roll",
        type = "number",
      },
      {
        name = "yaw",
        type = "number",
      },
      {
        name = "rotationOrder",
        type = "number",
      },
      {
        name = "bDeadCheck",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityRoutingBucket",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "bucket",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetEntityVelocity",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetGameType",
    params = {
      {
        name = "gametypeName",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetHttpHandler",
    params = {
      {
        name = "handler",
        type = "Function",
      },
    },
    ret = {}
  },
  {
    name = "SetMapName",
    params = {
      {
        name = "mapName",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetPedAmmo",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "weaponHash",
        type = "string|number",
      },
      {
        name = "ammo",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedArmour",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "amount",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedCanRagdoll",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "toggle",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedComponentVariation",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "componentId",
        type = "number",
      },
      {
        name = "drawableId",
        type = "number",
      },
      {
        name = "textureId",
        type = "number",
      },
      {
        name = "paletteId",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedConfigFlag",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "flagId",
        type = "number",
      },
      {
        name = "value",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedDefaultComponentVariation",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedEyeColor",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "index",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedFaceFeature",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "index",
        type = "number",
      },
      {
        name = "scale",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedHairTint",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "colorID",
        type = "number",
      },
      {
        name = "highlightColorID",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedHairColor",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "colorID",
        type = "number",
      },
      {
        name = "highlightColorID",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedHeadBlendData",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "shapeFirstID",
        type = "number",
      },
      {
        name = "shapeSecondID",
        type = "number",
      },
      {
        name = "shapeThirdID",
        type = "number",
      },
      {
        name = "skinFirstID",
        type = "number",
      },
      {
        name = "skinSecondID",
        type = "number",
      },
      {
        name = "skinThirdID",
        type = "number",
      },
      {
        name = "shapeMix",
        type = "number",
      },
      {
        name = "skinMix",
        type = "number",
      },
      {
        name = "thirdMix",
        type = "number",
      },
      {
        name = "isParent",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedHeadOverlay",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "overlayID",
        type = "number",
      },
      {
        name = "index",
        type = "number",
      },
      {
        name = "opacity",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedHeadOverlayColor",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "overlayID",
        type = "number",
      },
      {
        name = "colorType",
        type = "number",
      },
      {
        name = "colorID",
        type = "number",
      },
      {
        name = "secondColorID",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedIntoVehicle",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "seatIndex",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedPropIndex",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "componentId",
        type = "number",
      },
      {
        name = "drawableId",
        type = "number",
      },
      {
        name = "textureId",
        type = "number",
      },
      {
        name = "attach",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedRandomComponentVariation",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "p1",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedRandomProps",
    params = {
      {
        name = "ped",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPedResetFlag",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "flagId",
        type = "number",
      },
      {
        name = "doReset",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedToRagdoll",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "time1",
        type = "number",
      },
      {
        name = "time2",
        type = "number",
      },
      {
        name = "ragdollType",
        type = "number",
      },
      {
        name = "p4",
        type = "boolean",
      },
      {
        name = "p5",
        type = "boolean",
      },
      {
        name = "p6",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPedToRagdollWithFall",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "time",
        type = "number",
      },
      {
        name = "p2",
        type = "number",
      },
      {
        name = "ragdollType",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "p7",
        type = "number",
      },
      {
        name = "p8",
        type = "number",
      },
      {
        name = "p9",
        type = "number",
      },
      {
        name = "p10",
        type = "number",
      },
      {
        name = "p11",
        type = "number",
      },
      {
        name = "p12",
        type = "number",
      },
      {
        name = "p13",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerControl",
    params = {
      {
        name = "player",
        type = "string",
      },
      {
        name = "bHasControl",
        type = "boolean",
      },
      {
        name = "flags",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerCullingRadius",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "radius",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerInvincible",
    params = {
      {
        name = "player",
        type = "string",
      },
      {
        name = "bInvincible",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerModel",
    params = {
      {
        name = "player",
        type = "string",
      },
      {
        name = "model",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerRoutingBucket",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "bucket",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetPlayerWantedLevel",
    params = {
      {
        name = "player",
        type = "string",
      },
      {
        name = "wantedLevel",
        type = "number",
      },
      {
        name = "delayedResponse",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvp",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvpFloat",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvpFloatNoSync",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvpInt",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvpIntNoSync",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetResourceKvpNoSync",
    params = {
      {
        name = "key",
        type = "string",
      },
      {
        name = "value",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetRoutingBucketEntityLockdownMode",
    params = {
      {
        name = "bucketId",
        type = "number",
      },
      {
        name = "mode",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "SetRoutingBucketPopulationEnabled",
    params = {
      {
        name = "bucketId",
        type = "number",
      },
      {
        name = "mode",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetStateBagValue",
    params = {
      {
        name = "bagName",
        type = "string",
      },
      {
        name = "keyName",
        type = "string",
      },
      {
        name = "valueData",
        type = "string",
      },
      {
        name = "valueLength",
        type = "number",
      },
      {
        name = "replicated",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleAlarm",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "state",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleBodyHealth",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "value",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleColourCombination",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "colorCombination",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleColours",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "colorPrimary",
        type = "number",
      },
      {
        name = "colorSecondary",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleCustomPrimaryColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "r",
        type = "number",
      },
      {
        name = "g",
        type = "number",
      },
      {
        name = "b",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleCustomSecondaryColour",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "r",
        type = "number",
      },
      {
        name = "g",
        type = "number",
      },
      {
        name = "b",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleDirtLevel",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "dirtLevel",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleDoorBroken",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "doorIndex",
        type = "number",
      },
      {
        name = "deleteDoor",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleDoorsLocked",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "doorLockStatus",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "SetVehicleNumberPlateText",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "plateText",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "StartFindKvp",
    params = {
      {
        name = "prefix",
        type = "string",
      },
    },
    ret = { "number" }
  },
  {
    name = "StartResource",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "StopResource",
    params = {
      {
        name = "resourceName",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
  {
    name = "TaskCombatPed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "targetPed",
        type = "number",
      },
      {
        name = "p2",
        type = "number",
      },
      {
        name = "p3",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskDriveBy",
    params = {
      {
        name = "driverPed",
        type = "number",
      },
      {
        name = "targetPed",
        type = "number",
      },
      {
        name = "targetVehicle",
        type = "number",
      },
      {
        name = "targetX",
        type = "number",
      },
      {
        name = "targetY",
        type = "number",
      },
      {
        name = "targetZ",
        type = "number",
      },
      {
        name = "distanceToShoot",
        type = "number",
      },
      {
        name = "pedAccuracy",
        type = "number",
      },
      {
        name = "p8",
        type = "boolean",
      },
      {
        name = "firingPattern",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "TaskEnterVehicle",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "timeout",
        type = "number",
      },
      {
        name = "seatIndex",
        type = "number",
      },
      {
        name = "speed",
        type = "number",
      },
      {
        name = "flag",
        type = "number",
      },
      {
        name = "p6",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskEveryoneLeaveVehicle",
    params = {
      {
        name = "vehicle",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskGoStraightToCoord",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "speed",
        type = "number",
      },
      {
        name = "timeout",
        type = "number",
      },
      {
        name = "targetHeading",
        type = "number",
      },
      {
        name = "distanceToSlide",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskGoToCoordAnyMeans",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "fMoveBlendRatio",
        type = "number",
      },
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "bUseLongRangeVehiclePathing",
        type = "boolean",
      },
      {
        name = "drivingFlags",
        type = "number",
      },
      {
        name = "fMaxRangeToShootTargets",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskGoToEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "target",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "distance",
        type = "number",
      },
      {
        name = "speed",
        type = "number",
      },
      {
        name = "p5",
        type = "number",
      },
      {
        name = "p6",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskHandsUp",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "facingPed",
        type = "number",
      },
      {
        name = "p3",
        type = "number",
      },
      {
        name = "p4",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "TaskLeaveAnyVehicle",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "p1",
        type = "number",
      },
      {
        name = "flags",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskLeaveVehicle",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "flags",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskPlayAnim",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "animDictionary",
        type = "string",
      },
      {
        name = "animationName",
        type = "string",
      },
      {
        name = "blendInSpeed",
        type = "number",
      },
      {
        name = "blendOutSpeed",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "flag",
        type = "number",
      },
      {
        name = "playbackRate",
        type = "number",
      },
      {
        name = "lockX",
        type = "boolean",
      },
      {
        name = "lockY",
        type = "boolean",
      },
      {
        name = "lockZ",
        type = "boolean",
      },
    },
    ret = {}
  },
  {
    name = "TaskPlayAnimAdvanced",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "animDict",
        type = "string",
      },
      {
        name = "animName",
        type = "string",
      },
      {
        name = "posX",
        type = "number",
      },
      {
        name = "posY",
        type = "number",
      },
      {
        name = "posZ",
        type = "number",
      },
      {
        name = "rotX",
        type = "number",
      },
      {
        name = "rotY",
        type = "number",
      },
      {
        name = "rotZ",
        type = "number",
      },
      {
        name = "animEnterSpeed",
        type = "number",
      },
      {
        name = "animExitSpeed",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "flag",
        type = "number",
      },
      {
        name = "animTime",
        type = "number",
      },
      {
        name = "p14",
        type = "number",
      },
      {
        name = "p15",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskReactAndFleePed",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "fleeTarget",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TaskShootAtCoord",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "x",
        type = "number",
      },
      {
        name = "y",
        type = "number",
      },
      {
        name = "z",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "firingPattern",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "TaskShootAtEntity",
    params = {
      {
        name = "entity",
        type = "number",
      },
      {
        name = "target",
        type = "number",
      },
      {
        name = "duration",
        type = "number",
      },
      {
        name = "firingPattern",
        type = "string|number",
      },
    },
    ret = {}
  },
  {
    name = "TaskWarpPedIntoVehicle",
    params = {
      {
        name = "ped",
        type = "number",
      },
      {
        name = "vehicle",
        type = "number",
      },
      {
        name = "seatIndex",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TempBanPlayer",
    params = {
      {
        name = "playerSrc",
        type = "string",
      },
      {
        name = "reason",
        type = "string",
      },
    },
    ret = {}
  },
  {
    name = "TriggerClientEventInternal",
    params = {
      {
        name = "eventName",
        type = "string",
      },
      {
        name = "eventTarget",
        type = "string",
      },
      {
        name = "eventPayload",
        type = "string",
      },
      {
        name = "payloadLength",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TriggerEventInternal",
    params = {
      {
        name = "eventName",
        type = "string",
      },
      {
        name = "eventPayload",
        type = "string",
      },
      {
        name = "payloadLength",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "TriggerLatentClientEventInternal",
    params = {
      {
        name = "eventName",
        type = "string",
      },
      {
        name = "eventTarget",
        type = "string",
      },
      {
        name = "eventPayload",
        type = "string",
      },
      {
        name = "payloadLength",
        type = "number",
      },
      {
        name = "bps",
        type = "number",
      },
    },
    ret = {}
  },
  {
    name = "VerifyPasswordHash",
    params = {
      {
        name = "password",
        type = "string",
      },
      {
        name = "hash",
        type = "string",
      },
    },
    ret = { "boolean" }
  },
}
