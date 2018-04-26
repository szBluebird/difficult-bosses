
function OnStartTouch(trigger)

	--print("OnStartTouch")

	local teleportDelay = 3
	trigger.activator.teleportEntity = true
	trigger.activator.teleportCounter = 0.0
	trigger.activator:AddNewModifier(trigger.activator, nil, "trigger_teleport_modifier", { duration = teleportDelay })

	EmitSoundOn("Hero_Chen.TestOfFaith.Cast", trigger.activator)

	-- Create unique timer name for each entity
	local teleportTimerName = "teleportTimer" .. tostring(trigger.activator:entindex())
	Timers:CreateTimer(teleportTimerName, {
    	useGameTime = true,
    	endTime = 0,
    	callback = function()
     		trigger.activator.teleportCounter = trigger.activator.teleportCounter + 0.1
	   		if (trigger.activator.teleportCounter >= teleportDelay) then

	   			local landing_position = nil
				if trigger.caller:GetName() == "teleport_base_trigger" then
					landing_position = (Entities:FindByName(nil, "teleport_boss1_trigger_exit")):GetAbsOrigin()
				elseif trigger.caller:GetName() == "teleport_boss1_trigger" then
					landing_position = (Entities:FindByName(nil, "teleport_base_trigger_exit")):GetAbsOrigin()
				else
					return nil
				end
				--print("landing_position: " .. tostring(landing_position))
				if landing_position ~= nil then
					FindClearSpaceForUnit(trigger.activator, landing_position, true)
					EmitSoundOn("Hero_Chen.TestOfFaith.Target", trigger.activator)
					--[[
					PlayerResource:SetCameraTarget(trigger.activator:GetPlayerID(), trigger.activator)
					Timers:CreateTimer(0.1, function()
						PlayerResource:SetCameraTarget(trigger.activator:GetPlayerID(), nil)
					end)
					]]
				end
	   		end

	    	if not trigger.activator.teleportEntity then
				return nil
			else
				return 0.1
			end

    	end
  	})

end

function OnEndTouch(trigger)
	--print("OnEndTouch")
 	-- Reset variables
	trigger.activator.teleportEntity = false
	trigger.activator.teleportCounter = 0.0
	trigger.activator:RemoveModifierByName("trigger_teleport_modifier")
end
