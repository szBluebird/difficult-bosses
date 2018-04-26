function OnStartTouch(trigger)

    thisEntity.hActivatorUnit = trigger.activator

    if thisEntity.hActivatorUnit == nil then
        return
    end

    -- Trigger particles
    if GameMode.bEnigmaBossInProgress and (not GameMode.bEnigmaBossLeftPillarActive) then

        -- Trigger the particles on the outer piller
        local hOuterStartRelay = Entities:FindByName( nil, "enigma_boss_outer_left_pillar_relay_start")
        if hOuterStartRelay ~= nil then
            hOuterStartRelay:Trigger()
        end
        GameMode.bEnigmaBossLeftPillarActive = true

        -- Trigger the particles on the inner piller
        local hInnerStartRelay = Entities:FindByName( nil, "enigma_boss_inner_left_pillar_relay_start")
        if hInnerStartRelay ~= nil then
            hInnerStartRelay:Trigger()
        end

        -- Activate the inner pillar
        local hInnerPillar = Entities:FindByName(nil, "enigma_boss_inner_void_pillar_left")
        if hInnerPillar ~= nil then
            hInnerPillar:SetHealth(hInnerPillar:GetMaxHealth())
            hInnerPillar:SetMana(hInnerPillar:GetMaxMana())
            hInnerPillar:RemoveModifierByName("modifier_inactive")
        end

        -- Increase boss power
        if GameMode.hEnigmaBoss then
            local hVoidInfusion = GameMode.hEnigmaBoss:FindModifierByName("modifier_void_infusion")
    		hVoidInfusion:IncrementStackCount()
            -- Sound
            if GameMode.bEnigmaBossLeftPillarActive and GameMode.bEnigmaBossRightPillarActive then
                EmitSoundOn("enigma_enig_ally_15", GameMode.hEnigmaBoss)
            else
                EmitSoundOn("enigma_enig_level_03", GameMode.hEnigmaBoss)
            end
        end

    end

    -- Kill unit
    if (thisEntity.hActivatorUnit:IsAlive()) then
        EmitSoundOn("Hero_Enigma.Demonic_Conversion", thisEntity.hActivatorUnit)
        thisEntity.hActivatorUnit:ForceKill(false)
    end

end

function OnEndTouch(trigger)

end
