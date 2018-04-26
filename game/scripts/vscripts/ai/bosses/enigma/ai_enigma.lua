function Spawn( entityKeyValues )

	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

    SummonVoidlingsAbility = thisEntity:FindAbilityByName( "enigma_boss_summon_voidlings" )

	thisEntity:SetContextThink( "EnigmaBossThink", EnigmaBossThink, 1 )

end

function EnigmaBossThink()

    if (not thisEntity:IsAlive()) then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	if thisEntity:IsChanneling() == true then
		return 0.1
	end

    if SummonVoidlingsAbility ~= nil and SummonVoidlingsAbility:IsCooldownReady() and thisEntity:GetHealthPercent() < 90 then
        if (not GameMode.bEnigmaBossRightPillarActive) or (not GameMode.bEnigmaBossLeftPillarActive) then
    		return SummonVoidlings()
        end
	end

	return 0.5

end

function SummonVoidlings()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = SummonVoidlingsAbility:entindex(),
		Queue = false,
	})
	return 1
end
