function Spawn( entityKeyValues )

	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

    thisEntity:AddNewModifier(thisEntity, nil, "modifier_void_pillar_constant_damage", {})
	thisEntity:AddNewModifier(thisEntity, nil, "modifier_inactive", {})

end
