modifier_void_infusion = class({})

--------------------------------------------------------------------------------

function modifier_void_infusion:OnCreated( kv )
	if IsServer() then
		self:SetStackCount(0)
	end
end

--------------------------------------------------------------------------------

function modifier_void_infusion:OnStackCountChanged(nOldStackCount)
    if IsServer() then
		if self:GetStackCount() > nOldStackCount then
			if self.nCasterFX then
				ParticleManager:DestroyParticle(self.nCasterFX, true)
			end
			self.nCasterFX = ParticleManager:CreateParticle( "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
			ParticleManager:SetParticleControlEnt(self.nCasterFX , 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetParent():GetOrigin(), false )
			ParticleManager:ReleaseParticleIndex(self.nCasterFX)
			EmitSoundOn("Hero_OgreMagi.Bloodlust.Target", self:GetParent())
		end
    end
end

--------------------------------------------------------------------------------

function modifier_void_infusion:OnRefresh( kv )
	if IsServer() then

	end
end


--------------------------------------------------------------------------------

function modifier_void_infusion:DeclareFunctions()
    local funcs = {
		MODIFIER_PROPERTY_MODEL_SCALE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
    return funcs
end

--------------------------------------------------------------------------------

function modifier_void_infusion:GetModifierPreAttack_BonusDamage()
  return self:GetStackCount() * 50
end

--------------------------------------------------------------------------------

function modifier_void_infusion:GetModifierModelScale()
  	return 30 * self:GetStackCount()
end

--------------------------------------------------------------------------------

function modifier_void_infusion:IsHidden()
	return false
end

--------------------------------------------------------------------------------

function modifier_void_infusion:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_void_infusion:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_void_infusion:IsPermanent()
	return true
end

--------------------------------------------------------------------------------

function modifier_void_infusion:RemoveOnDeath()
	return true
end

--------------------------------------------------------------------------------

function modifier_void_infusion:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

function modifier_void_infusion:GetTexture()
	return "enigma_demonic_conversion"
end
