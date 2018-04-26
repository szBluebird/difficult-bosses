-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

require('libraries/timers')
require('libraries/physics')
require('libraries/projectiles')
require('libraries/notifications')
require('libraries/animations')
require('libraries/attachments')
require('libraries/playertables')
require('libraries/containers')
require('libraries/modmaker')
require('libraries/pathgraph')
require('libraries/selection')
require('internal/gamemode')
require('internal/events')
require('settings')
require('events')

-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map
if GetMapName() == "playground" then
  require("examples/playground")
end

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability#
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()

end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()

end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)

  hero:AddItem(CreateItem("item_heart", hero, hero))
  hero:AddItem(CreateItem("item_travel_boots_2", hero, hero))
  hero:AddItem(CreateItem("item_assault", hero, hero))
  hero:AddItem(CreateItem("item_blink", hero, hero))
  hero:AddItem(CreateItem("item_hurricane_pike", hero, hero))

  -- PlayerResource:SetCameraTarget(hero:GetPlayerID(), hero)

end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()

    -- Create Enigma boss
    local hEnigmaBossSpawner = Entities:FindByName(nil, "enigma_boss_spawner")
    if hEnigmaBossSpawner ~= nil then
        local vEnigmaBossSpawnOrigin = hEnigmaBossSpawner:GetAbsOrigin()
        self.hEnigmaBoss = CreateUnitByName("npc_enigma_boss", vEnigmaBossSpawnOrigin, true, nil, nil, DOTA_TEAM_BADGUYS)
        self.hEnigmaBoss:SetForwardVector(Vector(0,-1,0))
    end

end



--[[
    This function initializes the game mode and is called before anyone loads into the game
    It can be used to pre-initialize any values/tables that will be needed later
]]
function GameMode:InitGameMode()

    GameMode = self

    -- Enigma
    self.hEnigmaBoss = nil
    self.bEnigmaExitThinking = false
    self.bEnigmaBossInProgress = false
    self.bEnigmaBossLeftPillarActive = false
    self.bEnigmaBossRightPillarActive = false
    self.bEnigmaBossShowNotification = true


end
