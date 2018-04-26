enigma_boss_summon_voidlings = class({})

--------------------------------------------------------------------------------

function enigma_boss_summon_voidlings:OnSpellStart()

    local hCaster = self:GetCaster()

	if hCaster == nil then
		return
	end

    local bRightVoidlingSpawned = false
    local bLeftVoidlingSpawned = false

    -- Stop if both pillars are active
    if GameMode.bEnigmaBossRightPillarActive and GameMode.bEnigmaBossLeftPillarActive then
        return
    end


    if not GameMode.bEnigmaBossLeftPillarActive then
        local hLeftVoidlingSpawner = Entities:FindByName(nil, "enigma_boss_voidling_left_spawner")
        local vLeftVoidlingSpawner = hLeftVoidlingSpawner:GetAbsOrigin()
        local leftVoidling = CreateUnitByName("npc_enigma_boss_voidlings", vLeftVoidlingSpawner, true, hCaster, hCaster, DOTA_TEAM_BADGUYS )
        leftVoidling.szVoidlingType = "left"
        bLeftVoidlingSpawned = true
    end


    if not GameMode.bEnigmaBossRightPillarActive then
        local hRightVoidlingSpawner = Entities:FindByName(nil, "enigma_boss_voidling_right_spawner")
        local vRightVoidlingSpawner = hRightVoidlingSpawner:GetAbsOrigin()
        local rightVoidling = CreateUnitByName("npc_enigma_boss_voidlings", vRightVoidlingSpawner, true, hCaster, hCaster, DOTA_TEAM_BADGUYS )
        rightVoidling.szVoidlingType = "right"
        bRightVoidlingSpawned = true
    end

    local szNotificationText = "Voidlings summoned"
    if bRightVoidlingSpawned and not bLeftVoidlingSpawned then
        szNotificationText = "Right voidling spawned"
    elseif bLeftVoidlingSpawned and not bRightVoidlingSpawned then
        szNotificationText = "Left voidling spawned"
    end

    -- Notification
    Notifications:BottomToTeam(DOTA_TEAM_GOODGUYS, {
            text = szNotificationText,
            duration = 4,
            class = "NotificationMessage",
            style = {
                color = "orange",
                ["font-size"] = "25px",
            }
        })

end

--------------------------------------------------------------------------------

function enigma_boss_summon_voidlings:GetIntrinsicModifierName()
	return "modifier_void_infusion"
end
