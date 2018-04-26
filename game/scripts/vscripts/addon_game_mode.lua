require('internal/util')
require('gamemode')

-- Modifiers not associated to an ability
LinkLuaModifier("trigger_teleport_modifier", "abilities/triggers/trigger_teleport_modifier", LUA_MODIFIER_MOTION_NONE )

-- Enigma
LinkLuaModifier("modifier_void_pillar_constant_damage", "modifiers/bosses/enigma/modifier_void_pillar_constant_damage", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_void_infusion", "modifiers/bosses/enigma/modifier_void_infusion", LUA_MODIFIER_MOTION_NONE )

-- Common
LinkLuaModifier("modifier_inactive", "modifiers/modifier_inactive", LUA_MODIFIER_MOTION_NONE )



function Precache( context )

  DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed
  PrecacheResource("particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf", context)
  PrecacheResource("particle", "particles/units/heroes/hero_pugna/pugna_life_drain.vpcf", context)
  PrecacheResource("particle_folder", "particles/test_particle", context)
  PrecacheResource("particle_folder", "particles/test_particle", context)
  PrecacheResource("particle_folder", "particles/base_teleport", context)
  PrecacheResource("particle_folder", "particles/base_teleport/green", context)
  PrecacheResource("particle_folder", "particles/base_teleport/blue", context)
  PrecacheResource("particle_folder", "particles/base_teleport/purple", context)
  PrecacheResource("particle_folder", "particles/base_teleport/orange", context)
  PrecacheResource("particle_folder", "particles/base_teleport/red", context)

  -- Models can also be precached by folder or individually
  -- PrecacheModel should generally used over PrecacheResource for individual models
  PrecacheResource("model_folder", "particles/heroes/antimage", context)
  PrecacheResource("model", "particles/heroes/viper/viper.vmdl", context)
  PrecacheModel("models/heroes/viper/viper.vmdl", context)

  -- Sounds can precached here like anything else
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_chen.vsndevts", context)

  -- Enigma
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_enigma.vsndevts", context)
  PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  PrecacheItemByNameSync("example_ability", context)

  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  PrecacheUnitByNameSync("npc_enigma_boss", context)
  PrecacheUnitByNameSync("npc_dota_hero_custom_phantom_assassin", context)


end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end
