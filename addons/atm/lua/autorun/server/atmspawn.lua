

local function Createatmmachine( pos, ang )
	local atm = ents.Create( "atm_machine" )
	atm:SetPos( pos )
	atm:SetAngles( ang )
	atm:Spawn()
	atm:Activate()
end 

local function Loadatms()
	if ( file.Exists( "atm/"..string.lower( game.GetMap() )..".txt", "DATA" ) ) then
		local atms = util.JSONToTable( file.Read( "atm/" .. string.lower( game.GetMap() ) .. ".txt" ) )
		for id, tab in pairs( atms ) do
			Createatmmachine( tab.pos, tab.ang )
		end
	else
		MsgN("atm Spawn file is missing for map " .. string.lower( game.GetMap() ) )
	end
end

concommand.Add( "rp_atm_removespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	file.Delete( "atm/"..string.lower( game.GetMap() )..".txt" )
end )

concommand.Add( "rp_atm_savespawns", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	local tableOfatms = {}
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do
		table.insert( tableOfatms, { ang = v:GetAngles(), pos = v:GetPos() } )
	end
	if ( !file.IsDir( "atm", "DATA" ) ) then file.CreateDir( "atm" ) end
	file.Write( "atm/"..string.lower( game.GetMap() ) .. ".txt", util.TableToJSON( tableOfatms ) )
end )

concommand.Add( "rp_atm_respawnall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do v:Remove() end
	Loadatms()
end )

concommand.Add( "rp_atm_removeall", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do v:Remove() end
end )

timer.Simple( 2, function()
	for k, v in pairs( ents.FindByClass( "atm_machine" ) ) do v:Remove() end
	Loadatms()
end )