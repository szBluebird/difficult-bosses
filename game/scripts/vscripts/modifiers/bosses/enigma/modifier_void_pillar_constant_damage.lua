modifier_void_pillar_constant_damage = class({})

--------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:DeclareFunctions()
	local funcs = {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

--------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:OnAttackLanded( params )

	local hTarget = params.target
	local hAttacker = params.attacker

	if hTarget ~= self:GetParent() then
		return
	end

	if hTarget:GetHealth() > 1 then

		local iTargetNewHealth = hTarget:GetHealth() - 1
		hTarget:SetHealth(iTargetNewHealth)

	else

		Notifications:BottomToTeam(DOTA_TEAM_GOODGUYS, { text = "Void pillar destroyed", duration = 4, class = "NotificationMessage", style = {color = "orange", ["font-size"] = "25px"}})
		hTarget:AddNewModifier(hTarget, nil, "modifier_inactive", {})

		if GameMode.hEnigmaBoss then
			local hVoidInfusion = GameMode.hEnigmaBoss:FindModifierByName("modifier_void_infusion")
			hVoidInfusion:DecrementStackCount()
			EmitSoundOn("enigma_enig_death_01", GameMode.hEnigmaBoss)
		end


		if self:GetParent():GetName() == "enigma_boss_inner_void_pillar_right" then

			local hRightOuterPillarEndRelay = Entities:FindByName( nil, "enigma_boss_outer_right_pillar_relay_end")
			if hRightOuterPillarEndRelay ~= nil then
				hRightOuterPillarEndRelay:Trigger()
				GameMode.bEnigmaBossRightPillarActive = false
			end

			local hRightInnerPillarEndRelay = Entities:FindByName( nil, "enigma_boss_inner_right_pillar_relay_end")
			if hRightInnerPillarEndRelay ~= nil then
				hRightInnerPillarEndRelay:Trigger()
			end

		elseif self:GetParent():GetName() == "enigma_boss_inner_void_pillar_left" then

			local hLeftOuterPillarEndRelay = Entities:FindByName( nil, "enigma_boss_outer_left_pillar_relay_end")
			if hLeftOuterPillarEndRelay ~= nil then
				hLeftOuterPillarEndRelay:Trigger()
				GameMode.bEnigmaBossLeftPillarActive = false
			end

			local hLeftInnerPillarEndRelay = Entities:FindByName( nil, "enigma_boss_inner_left_pillar_relay_end")
			if hLeftInnerPillarEndRelay ~= nil then
				hLeftInnerPillarEndRelay:Trigger()
			end

		end

	end

end

--------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:GetAbsoluteNoDamagePhysical( params )
	return 1
end

--------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:GetAbsoluteNoDamageMagical( params )
	return 1
end

--------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:GetAbsoluteNoDamagePure( params )
	return 1
end

-----------------------------------------------------------------------------------------

function modifier_void_pillar_constant_damage:IsHidden()
	return true
end
