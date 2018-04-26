trigger_teleport_modifier = class({})

--------------------------------------------------------------------------------

function trigger_teleport_modifier:OnCreated( kv )
	-- print("OnCreated")
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:IsStunDebuff()
	return false
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:RemoveOnDeath()
	return true
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:GetTexture()
	return "trigger_teleport_modifier"
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:GetEffectName()
	return "particles/base_teleport/teleport_entity_effect.vpcf"
end

--------------------------------------------------------------------------------

function trigger_teleport_modifier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
