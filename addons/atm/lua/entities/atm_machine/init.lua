
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_intwallunit.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType(SOLID_VPHYSICS)
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
--	self:DropToFloor()
end

function ENT:OnTakeDamage( dmg ) 
	return false
end

function ENT:AcceptInput( name, activator, caller )
	if ( name == "Use" && IsValid( activator ) && activator:IsPlayer() ) then
		if ( activator:GetPData( "pin" ) == "100500" ) then
			activator:ConCommand( "rp_atm_nopin" )
		else
			activator:ConCommand( "rp_atm_open" )
		end
	end
end

local function CommaTheCash( num )
	if ( !num ) then return end

	for i = string.len( num ) - 3, 1, -3 do 
		num = string.sub( num, 1, i ) .. "," .. string.sub( num, i + 1 )
	end 
	return num
end

local function AreWeNearATM( ply )
	for id, ent in pairs( ents.FindInSphere( ply:GetPos(), 84) ) do
		if ( ent:GetClass() == "atm_machine" ) then
			return true
		end
	end
	return false
end

hook.Add( "PlayerInitialSpawn", "rp_atm_PSMoney", function( ply )
	if ply:GetPData( "bankmoney2" ) == nil then ply:SetPData( "bankmoney2", 0 ) end
	if ply:GetPData( "pin" ) == nil then ply:SetPData( "pin", 100500 ) end
end )

concommand.Add( "rp_atm_setpin", function( pl, cmd, args )
	if ( !AreWeNearATM( pl ) ) then pl:ChatPrint( "You must be near an ATM to use it!" ) return end
	if ( isnumber( tonumber( args[1] ) ) && string.len( args[1] ) == 4 ) then
		pl:SetPData( "pin", tostring( args[1] ) )
		pl:ChatPrint( "PIN Code set to: " .. tostring( args[1] )  )
		pl:ConCommand( "rp_atm_open" )
	else
		pl:ChatPrint( "Entered incorrect PIN!" )
	end
end )

concommand.Add( "rp_atm_login", function( pl, cmd, args )

if pl.CMDCD and pl.CMDCD > CurTime() then return end
pl.CMDCD = CurTime() + 3
	if ( !AreWeNearATM( pl ) ) then pl:ChatPrint( "You must be near an ATM to use it!" ) return end
	for k, v in pairs( player.GetAll() ) do
		if tostring( args[2] ) == tostring( v:UniqueID() ) || v:UniqueID() == "1" then /* In SP on Server, UniqueID is 1 */
			if args[1] == util.CRC( v:GetPData( "pin" ) ) && tostring( v:GetPData( "pin" ) ) != "100500" then 
				pl:ConCommand("rp_atm_account " .. args[1] .. " " .. args[2] .. " " .. v:GetPData( "bankmoney2" ) )
			else
				pl:ChatPrint( "Entered incorrect PIN!" )
			end
		end
	end
end )

concommand.Add( "rp_atm_deposit", function( pl, cmd, args )

if pl.CMDCD and pl.CMDCD > CurTime() then return end
pl.CMDCD = CurTime() + 4
	if ( !AreWeNearATM( pl ) ) then pl:ChatPrint( "You must be near an ATM to use it!" ) return end
	if ( !tonumber( args[3] ) ) then pl:ChatPrint( "Entered incorrect amount!" ) return end

	local target = pl
	for k, v in pairs( player.GetAll() ) do
		if tostring( args[2] ) == tostring( v:UniqueID() ) || v:UniqueID() == "1" then target = v end
	end

	if ( IsValid( target ) && math.floor( args[3] ) >= 0 and target.DarkRPVars.money - math.floor( args[3] ) >= 0 and args[1] == util.CRC( target:GetPData( "pin" ) ) ) then
		pl:AddMoney( -args[3] )
		target:SetPData( "bankmoney2", target:GetPData( "bankmoney2" ) + math.floor( args[3] ) )
		pl:ConCommand( "rp_atm_account " .. args[1] .. " "  .. args[2] .. " " .. target:GetPData( "bankmoney2" ) )
	else
		pl:ChatPrint( "Error occured!" )
	end
end )

concommand.Add( "rp_atm_withdraw", function( pl, cmd, args )

if pl.CMDCD and pl.CMDCD > CurTime() then return end
pl.CMDCD = CurTime() + 4
	if ( !AreWeNearATM( pl ) ) then pl:ChatPrint( "You must be near an ATM to use it!" ) return end
	if ( !tonumber( args[3] ) ) then pl:ChatPrint( "Entered incorrect amount!" ) return end

	local target = pl
	for k, v in pairs( player.GetAll() ) do
		if tostring( args[2] ) == tostring( v:UniqueID() ) || v:UniqueID() == "1" then target = v end
	end

	if ( IsValid( target ) && tonumber( target:GetPData( "bankmoney2" ) ) >= tonumber( args[3] ) && tonumber( args[3] ) > 0 && args[1] == util.CRC( target:GetPData( "pin" ) ) ) then
		pl:AddMoney( args[3] )
		target:SetPData( "bankmoney2", target:GetPData( "bankmoney2" ) - math.floor( args[3] ) )
		pl:ConCommand( "rp_atm_account " .. args[1] .. " "  .. args[2] .. " " .. target:GetPData( "bankmoney2" ) )
	else
		pl:ChatPrint( "Error occured!" )
	end
end )


/* Interest System */

local Interest = 0 // CHANGE RATE HERE ( In Percent )
local Interval = 9999999999999999 // CHANGE INTERVAL HERE ( In Seconds )


/* ADMIN HACKS AND STUFF */

concommand.Add( "rp_atm_money_send", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
	ply:ChatPrint( "---ATM Banked Money---" )
	for k, v in pairs( player.GetAll() ) do
		print( v:Nick() .. "'s account has $" .. CommaTheCash( tonumber( v:GetPData( "bankmoney2" ) ) ) .. "." )
		ply:ChatPrint( v:Nick() .. "'s account has $" .. CommaTheCash( tonumber( v:GetPData( "bankmoney2" ) ) ) .. "." )
	end
end )

concommand.Add( "rp_atm_pincodes_send", function( ply )
	if ( !ply:IsSuperAdmin() ) then return end
--	ply:ChatPrint( "---ATM PIN Codes---" )
	for k, v in pairs( player.GetAll() ) do
		if tostring( v:GetPData( "pin" ) ) == "100500" then
--			print( v:Nick() .. " has the PIN Code: -NONE-." )
--			ply:ChatPrint( v:Nick() .. " has the PIN Code: -NONE-." )
		else
--			print( v:Nick() .. " has the PIN Code: " .. v:GetPData( "pin" ) .. "." )
--			ply:ChatPrint( v:Nick() .. " has the PIN Code: " .. v:GetPData( "pin" ) .. "." )
		end
	end
	ply:ChatPrint( "Disabled because of safety :)" )
end )

concommand.Add( "rp_atm_admin_account", function( ply, cmd, args )
	if ( !AreWeNearATM( ply ) ) then ply:ChatPrint( "You must be near an ATM to use it!" ) return end
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( player.GetAll() ) do
		if ( tostring( v:UniqueID() ) == tostring( args[1] ) || v:UniqueID() == "1" ) then
			ply:ConCommand("rp_atm_account " .. util.CRC( v:GetPData( "pin" ) ) .. " " .. args[1] .. " " .. v:GetPData( "bankmoney2" ) )
		end
	end
end )

concommand.Add( "rp_atm_admin_resetmoney", function( ply, cmd, args )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( player.GetAll() ) do
		if ( tostring( v:UniqueID() ) == tostring( args[1] ) || v:UniqueID() == "1" ) then
	--		v:SetPData( "bankmoney2", 0 )
	--		ply:ChatPrint( v:Nick() .. "'s bank has been set to: " .. v:GetPData( "pin" ) )
		end
	end
	ply:ChatPrint( "Disabled because of safety :)" )
end )

concommand.Add( "rp_atm_admin_resetpin", function( ply, cmd, args )
	if ( !ply:IsSuperAdmin() ) then return end
	for k, v in pairs( player.GetAll() ) do
		if ( tostring( v:UniqueID() ) == tostring( args[1] ) || v:UniqueID() == "1" ) then
			v:SetPData( "pin", "100500" )
			ply:ChatPrint( v:Nick() .. "'s PIN has been reset." )
		end
	end
end )

concommand.Add( "rp_atm_admin_setpin", function( pl, cmd, args )
	if ( !pl:IsSuperAdmin() ) then return end
	if ( !isnumber( tonumber( args[2] ) ) || string.len( args[2] ) != 4 ) then pl:ChatPrint( "Entered incorrect PIN!" ) return end

	for k, v in pairs( player.GetAll() ) do
		if ( tostring( v:UniqueID() ) == tostring( args[1] ) || v:UniqueID() == "1" ) then
			v:SetPData( "pin", tostring( args[ 2 ] ) )
			pl:ChatPrint( v:Nick() .. "'s PIN has been set to: " .. v:GetPData( "pin" ) )
		end
	end
end )

concommand.Add( "rp_atm_resetallaccounts", function( pl )
	if ( !pl:IsSuperAdmin() ) then return end
--	for k, v in pairs( player.GetAll() ) do
--		v:SetPData( "pin", 100500 )
--		v:SetPData( "bankmoney2", 0 )
--	end
	ply:ChatPrint( "Disabled because of safety :)" )
end )
