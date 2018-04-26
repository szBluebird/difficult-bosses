function Spawn( entityKeyValues )

	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	thisEntity:SetContextThink( "EnigmaBossVoidlingThink", EnigmaBossVoidlingThink, 1 )

end

function EnigmaBossVoidlingThink()

    if (not thisEntity:IsAlive()) then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	if thisEntity:IsChanneling() == true then
		return 0.1
	end

	local hNextWaypoint = nil
	if thisEntity.szVoidlingType == "right" then
		hNextWaypoint = Entities:FindByName(nil, "enigma_boss_right_void_rift_inner_entrance")
	elseif thisEntity.szVoidlingType == "left" then
		hNextWaypoint = Entities:FindByName(nil, "enigma_boss_left_void_rift_inner_entrance")
	end

	if hNextWaypoint then
		local order = {
			UnitIndex = thisEntity:entindex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = hNextWaypoint:GetAbsOrigin(),
			Queue = true
		}
		ExecuteOrderFromTable(order)
		return -1 
	end

    -- No goal entity found, so just kill the entity for safety
    thisEntity:ForceKill(false)

	return -1
end
