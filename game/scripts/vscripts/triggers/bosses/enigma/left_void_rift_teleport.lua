
--------------------------------------------------------------------------------
-- Inner
--------------------------------------------------------------------------------

function OnStartTouchInner(trigger)

    -- print("OnStartTouch")

    local activator = trigger.activator
    local caller = trigger.caller

    local hOuterExit = Entities:FindByName(nil, "enigma_boss_left_void_rift_outer_exit")
    if hOuterExit ~= nil then
        local vOuterExitOrigin = hOuterExit:GetAbsOrigin()
        FindClearSpaceForUnit(activator, vOuterExitOrigin, true)
        activator:Stop()
        if activator:IsRealHero() then
            local playerID = activator:GetPlayerID()
            PlayerResource:SetCameraTarget(playerID, activator)
            Timers:CreateTimer(0.1, function()
                PlayerResource:SetCameraTarget(playerID, nil)
            end)
        end
    end

    if activator.szVoidlingType == "left" then
        local hNextWaypoint = Entities:FindByName(nil, "enigma_boss_voidling_left_waypoint")
        if hNextWaypoint ~= nil then
            local order = {
                UnitIndex = activator:entindex(),
                OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                Position = hNextWaypoint:GetAbsOrigin(),
                Queue = true
            }
            ExecuteOrderFromTable(order)
        end
    end

end

function OnEndTouchInner(trigger)
    -- print("OnEndTouch")
end

--------------------------------------------------------------------------------
-- Outer
--------------------------------------------------------------------------------

function OnStartTouchOuter(trigger)

    local activator = trigger.activator
    local caller = trigger.caller

    local hInnerExit = Entities:FindByName(nil, "enigma_boss_left_void_rift_inner_exit")
    if hInnerExit ~= nil then
        local vInnerExitOrigin = hInnerExit:GetAbsOrigin()
        FindClearSpaceForUnit(activator, vInnerExitOrigin, true)
        activator:Stop()
        if activator:IsRealHero() then
            local playerID = activator:GetPlayerID()
            PlayerResource:SetCameraTarget(playerID, activator)
            Timers:CreateTimer(0.1, function()
                PlayerResource:SetCameraTarget(playerID, nil)
            end)
        end
    end

end

function OnEndTouchOuter(trigger)
    -- print("OnEndTouch")
end
