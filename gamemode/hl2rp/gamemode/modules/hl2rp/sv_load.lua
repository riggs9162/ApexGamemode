local function CreateEnt(ent, pos, ang )
	local ent = ents.Create(ent)
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function CreateLocker( pos, ang )
	local ent = ents.Create( "locker" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadLockers()
	for k, v in pairs( ents.FindByClass( "locker" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_lockers.txt", "DATA" ) ) then
		local lockers = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_lockers.txt" ) )
		for id, tab in pairs( lockers ) do
			CreateLocker( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP Locker Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

local function CreateTrash( pos, ang )
	local ent2 = ents.Create( "trash_logic" )
	ent2:SetPos( pos )
	ent2:SetAngles( ang )
	ent2:Spawn()
	ent2:Activate()
	ent2:SetNoDraw( true )
end 

local function LoadTrash()
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_trash_logic.txt", "DATA" ) ) then
		local trash_logic = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_trash_logic.txt" ) )
		for id, tab in pairs( trash_logic ) do
			CreateTrash( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP TRASH Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_trash_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do v:Remove() end
	LoadTrash()
end )

concommand.Add( "rp_trash_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "trash_logic" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_trash_logic.txt", util.TableToJSON( tableOfatms ) )
end )

concommand.Add( "rp_locker_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "locker" ) ) do v:Remove() end
	LoadLockers()
end )

concommand.Add( "rp_locker_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "locker" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_lockers.txt", util.TableToJSON( tableOfatms ) )
end )

local function CreateCPNpc( pos, ang )
	local ent = ents.Create( "cp_npc" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadCPNpcs()
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_cpnpc.txt", "DATA" ) ) then
		local CPNpcs = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_cpnpc.txt" ) )
		for id, tab in pairs( CPNpcs ) do
			CreateCPNpc( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP CPNpc's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_cpnpc_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do v:Remove() end
	LoadCPNpcs()
end )

concommand.Add( "rp_cpnpc_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "cp_npc" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_cpnpc.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )

local function CreateAmmoCrate( pos, ang )
	local ent = ents.Create( "ammo" )
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

local function LoadAmmoCrates()
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do v:Remove() end
	if ( file.Exists( "hl2rp/"..string.lower( game.GetMap() ).."_ammocrate.txt", "DATA" ) ) then
		local AmmoCrates = util.JSONToTable( file.Read( "hl2rp/" .. string.lower( game.GetMap() ) .. "_ammocrate.txt" ) )
		for id, tab in pairs( AmmoCrates ) do
			CreateAmmoCrate( tab.pos, tab.ang )
		end
	else
		MsgN("HL2RP AmmoCrate's Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_ammocrate_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do v:Remove() end
	LoadAmmoCrates()
end )

concommand.Add( "rp_ammocrate_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "ammo" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "hl2rp", "DATA" ) ) then file.CreateDir( "hl2rp" ) end
	file.Write( "hl2rp/"..string.lower( game.GetMap() ) .. "_ammocrate.txt", util.TableToJSON( tableOfatms ) )
--	MsgN("Saved CPNPC spawns")
end )





local function LoadVending()
	for k, v in pairs( ents.FindByClass( "prop_dynamic" ) ) do

		if v:GetModel() == "models/props_interiors/vendingmachinesoda01a.mdl" then
			local pos = v:GetPos();
			local ang = v:GetAngles();
			CreateEnt("hl2rp_vendingm", pos, ang )
			SafeRemoveEntity(v)
		end

	end


end

timer.Simple( 2, function()
	LoadAmmoCrates()
	LoadLockers()
	LoadCPNpcs()
                LoadTrash()
end )

timer.Simple( 4, function()
	LoadVending()
end )



