function OnStartTouchAll(trigger)

    local notificationDuration = 3.0
    local vCenterOrigin = (Entities:FindByName(nil, "enigma_boss_vision_dummy_spawner")):GetAbsOrigin()
    local vRightVoidRiftOrigin = (Entities:FindByName(nil, "enigma_boss_vision_dummy_spawner_right_void_rift")):GetAbsOrigin()
    local vLeftVoidRiftOrigin = (Entities:FindByName(nil, "enigma_boss_vision_dummy_spawner_left_void_rift")):GetAbsOrigin()

    -- Center Vision
    if not thisEntity.visionUnitGoodGuys then thisEntity.visionUnitGoodGuys = CreateUnitByName("dummy_vision2500", vCenterOrigin, false, nil, nil, DOTA_TEAM_GOODGUYS) end
	if not thisEntity.visionUnitBadGuys then thisEntity.visionUnitBadGuys = CreateUnitByName("dummy_vision2500", vCenterOrigin, false, nil, nil, DOTA_TEAM_BADGUYS) end

    -- Left Void Rift Vision
    if not thisEntity.visionUnitLeftVoidRiftGoodguys then thisEntity.visionUnitLeftVoidRiftGoodguys = CreateUnitByName("dummy_vision500", vLeftVoidRiftOrigin, false, nil, nil, DOTA_TEAM_GOODGUYS) end
    if not thisEntity.visionUnitLeftVoidRiftBadguys then thisEntity.visionUnitLeftVoidRiftBadguys = CreateUnitByName("dummy_vision500", vLeftVoidRiftOrigin, false, nil, nil, DOTA_TEAM_BADGUYS) end

    -- Right Void Rift Vision
    if not thisEntity.visionUnitRightVoidRiftGoodguys then thisEntity.visionUnitRightVoidRiftGoodguys = CreateUnitByName("dummy_vision500", vRightVoidRiftOrigin, false, nil, nil, DOTA_TEAM_GOODGUYS) end
    if not thisEntity.visionUnitRightVoidRiftBadguys then thisEntity.visionUnitRightVoidRiftBadguys = CreateUnitByName("dummy_vision500", vRightVoidRiftOrigin, false, nil, nil, DOTA_TEAM_BADGUYS) end

    -- Notifications
    if GameMode.bEnigmaBossShowNotification then
        Notifications:TopToAll({hero="npc_dota_hero_enigma", duration = notification_duration})
        Notifications:TopToAll({text=" Enigma", duration = notification_duration, style={color="red"}, continue=true})
        GameMode.bEnigmaBossShowNotification = false
    end

end

function OnEndTouchAll(trigger)

    -- Check if unit is no longer touching the trigger
    local bIsTouching = trigger.caller:IsTouching(trigger.activator)
    if bIsTouching then
        return
    end

    -- Center Vision
    if thisEntity.visionUnitGoodGuys then
        UTIL_Remove(thisEntity.visionUnitGoodGuys)
        thisEntity.visionUnitGoodGuys = nil
    end
	if thisEntity.visionUnitBadGuys then
        UTIL_Remove(thisEntity.visionUnitBadGuys)
        thisEntity.visionUnitBadGuys = nil
    end

    -- Left Void Rift Vision
    if thisEntity.visionUnitLeftVoidRiftGoodguys then
        UTIL_Remove(thisEntity.visionUnitLeftVoidRiftGoodguys)
        thisEntity.visionUnitLeftVoidRiftGoodguys = nil
    end
    if thisEntity.visionUnitLeftVoidRiftBadguys then
        UTIL_Remove(thisEntity.visionUnitLeftVoidRiftBadguys)
        thisEntity.visionUnitLeftVoidRiftBadguys = nil
    end

    -- Right Void Rift Vision
    if thisEntity.visionUnitRightVoidRiftGoodguys then
        UTIL_Remove(thisEntity.visionUnitRightVoidRiftGoodguys)
        thisEntity.visionUnitRightVoidRiftGoodguys = nil
    end
    if thisEntity.visionUnitRightVoidRiftBadguys then
        UTIL_Remove(thisEntity.visionUnitRightVoidRiftBadguys)
        thisEntity.visionUnitRightVoidRiftBadguys = nil
    end

    -- Left Pillar
    if GameMode.bEnigmaBossLeftPillarActive then
        local hLeftPillarRelay = Entities:FindByName( nil, "enigma_boss_outer_left_pillar_relay_end" )
        if hLeftPillarRelay ~= nil then
            hLeftPillarRelay:Trigger()
            GameMode.bEnigmaBossLeftPillarActive = false
        end
        if GameMode.hEnigmaBoss then
            GameMode.hEnigmaBoss:CreatureLevelUp(-1)
        end
    end

    -- Right Pillar
    if GameMode.bEnigmaBossRightPillarActive then
        local hRightPillarRelay = Entities:FindByName( nil, "enigma_boss_outer_right_pillar_relay_end" )
        if hRightPillarRelay ~= nil then
            hRightPillarRelay:Trigger()
            GameMode.bEnigmaBossRightPillarActive = false
        end
        if GameMode.hEnigmaBoss then
            GameMode.hEnigmaBoss:CreatureLevelUp(-1)
        end
    end

    -- Barrier
    local hExitRelay = Entities:FindByName( nil, "enigma_boss_area_exit_relay")
    if hExitRelay ~= nil then
        hExitRelay:Trigger()
    end

    GameMode.bEnigmaBossInProgress = false
    GameMode.bEnigmaBossShowNotification = true

end
