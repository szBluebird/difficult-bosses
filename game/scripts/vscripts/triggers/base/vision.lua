
function OnStartTouch(trigger)

    if not trigger.caller.heroCounter then
        trigger.caller.heroCounter = 0
    end
    trigger.caller.heroCounter = trigger.caller.heroCounter + 1

    local origin = (Entities:FindByName(nil, "base_vision_dummy_spawner")):GetAbsOrigin()
    if not trigger.caller.visionUnit then
        trigger.caller.visionUnit = CreateUnitByName("dummy_vision2500", origin, false, nil, nil, DOTA_TEAM_GOODGUYS)
    end

    Notifications:Top(trigger.activator:GetPlayerID(), {text=" Home", duration = notification_duration, style={color="green"}})

end

function OnEndTouch(trigger)

    if not trigger.caller.heroCounter then
        trigger.caller.heroCounter = 0
    else
        trigger.caller.heroCounter = trigger.caller.heroCounter - 1
    end

    if (trigger.caller.heroCounter <= 0) then
        if trigger.caller.visionUnit then
            UTIL_Remove(trigger.caller.visionUnit)
            trigger.caller.visionUnit = nil
        end
    end


end
