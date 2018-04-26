function OnStartTouch (trigger)

    local activator = trigger.activator
    local caller = trigger.caller

    local hNextWaypoint  = nil
    local vNextWaypointOrigin = nil
    local szCallerName = caller:GetName()

    if activator.szVoidlingType == "right" and szCallerName == "enigma_boss_voidling_right_waypoint" then
        hNextWaypoint = Entities:FindByName(nil, "enigma_boss_right_pillar_trigger")
        vNextWaypointOrigin = hNextWaypoint:GetAbsOrigin() + Vector(0, -50, 0)
    elseif activator.szVoidlingType == "left" and szCallerName == "enigma_boss_voidling_left_waypoint" then
        hNextWaypoint = Entities:FindByName(nil, "enigma_boss_left_pillar_trigger")
        vNextWaypointOrigin = hNextWaypoint:GetAbsOrigin() + Vector(0, -50, 0)
    end

    if vNextWaypointOrigin then
        local order = {
            UnitIndex = activator:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Position = vNextWaypointOrigin,
            Queue = true
        }
        ExecuteOrderFromTable(order)
    end

end
