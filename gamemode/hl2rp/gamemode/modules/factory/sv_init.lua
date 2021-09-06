--Factory Init

local function CreateEnt(ent, pos, ang )
	local ent = ents.Create(ent)
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadFactory()
	for k, v in pairs( ents.FindByClass( "hl2rp_ration_maker" ) ) do v:Remove() end
	for k, v in pairs( ents.FindByClass( "hl2rp_rationoven" ) ) do v:Remove() end
	for k, v in pairs( ents.FindByClass( "hl2rp_rationoven_exit" ) ) do v:Remove() end

	CreateEnt("hl2rp_ration_maker", Vector(2949.250000, 5939.062500, 354.343750), Angle(0, 180, 0))

	CreateEnt("hl2rp_rationoven", Vector(3181.656250, 5793.531250, 341.937500), Angle(0, -135, 0))

	CreateEnt("hl2rp_rationoven_exit", Vector(3228.6, 5463.343750, 341.937500), Angle(0, 0, 0))

end


timer.Simple( 1, function()
	LoadFactory()
end )
