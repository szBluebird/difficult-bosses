
--------------------------------------------------------------------------------
-- Inner
--------------------------------------------------------------------------------

function OnStartTouchInner(trigger)

    -- print("OnStartTouch")

    local activator = trigger.activator
    local caller = trigger.caller

    local hOuterExit = Entities:FindByName(nil, "enigma_boss_right_void_rift_outer_exit")
    if hOuterExit ~= nil then
        activator:Stop()
        local vOuterExitOrigin = hOuterExit:GetAbsOrigin()
        FindClearSpaceForUnit(activator, vOuterExitOrigin, true)
        if activator:IsRealHero() then
            local playerID = activator:GetPlayerID()
            PlayerResource:SetCameraTarget(playerID, activator)
            Timers:CreateTimer(0.1, function()
                PlayerResource:SetCameraTarget(playerID, nil)
            end)
        end
        print("Forward vector", activator:GetForwardVector())
    end

    if activator.szVoidlingType == "right" then
        local hNextWaypoint = Entities:FindByName(nil, "enigma_boss_voidling_right_waypoint")
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

    local hInnerExit = Entities:FindByName(nil, "enigma_boss_right_void_rift_inner_exit")
    if hInnerExit ~= nil then
        activator:Stop()
        local vInnerExitOrigin = hInnerExit:GetAbsOrigin()
        FindClearSpaceForUnit(activator, vInnerExitOrigin, true)
        if activator:IsRealHero() then
            local playerID = activator:GetPlayerID()
            PlayerResource:SetCameraTarget(playerID, activator)
            Timers:CreateTimer(0.1, function()
                PlayerResource:SetCameraTarget(playerID, nil)
            end)
        end
        print("Forward vector", activator:GetForwardVector())
    end

end

function OnEndTouchOuter(trigger)
    -- print("OnEndTouch")
end
