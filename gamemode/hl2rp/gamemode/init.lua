GM.Version = "2.4.3"

GM.Name = "Half-Life 2 Roleplay"

GM.Author = "Inspired by Aerolite, Remade from scratch for Cortex-Community!"



DeriveGamemode("sandbox")



hl2rp = hl2rp or {}



if (SERVER) then



maxtrash = 0



	resource.AddFile("materials/hl2rp/DermaSkin.png")

	resource.AddFile( "materials/aerolite/burgericon.vmt" )

	resource.AddFile( "materials/aerolite/burgericon.vtf" )

	resource.AddFile( "materials/aerolite/strawberryicon.vmt" )

	resource.AddFile( "materials/aerolite/strawberryicon.vtf" )

	resource.AddFile( "materials/fadmin/back.vmt" )

	resource.AddFile( "materials/fadmin/back.vtf" )

	resource.AddFile( "materials/fadmin/icons/access.vmt" )

	resource.AddFile( "materials/fadmin/icons/access.vtf" )

	resource.AddFile( "materials/fadmin/icons/ban.vmt" )

	resource.AddFile( "materials/fadmin/icons/ban.vtf" )

	resource.AddFile( "materials/fadmin/icons/changeteam.vmt" )

	resource.AddFile( "materials/fadmin/icons/changeteam.vtf" )

	resource.AddFile( "materials/fadmin/icons/chatmute.vmt" )

	resource.AddFile( "materials/fadmin/icons/chatmute.vtf" )

	resource.AddFile( "materials/fadmin/icons/cleanup.vmt" )

	resource.AddFile( "materials/fadmin/icons/cleanup.vtf" )

	resource.AddFile( "materials/fadmin/icons/cloak.vmt" )

	resource.AddFile( "materials/fadmin/icons/cloak.vtf" )

	resource.AddFile( "materials/fadmin/icons/disable.vmt" )

	resource.AddFile( "materials/fadmin/icons/disable.vtf" )

	resource.AddFile( "materials/fadmin/icons/freeze.vmt" )

	resource.AddFile( "materials/fadmin/icons/freeze.vtf" )

	resource.AddFile( "materials/fadmin/icons/god.vmt" )

	resource.AddFile( "materials/fadmin/icons/god.vtf" )

	resource.AddFile( "materials/fadmin/icons/ignite.vmt" )

	resource.AddFile( "materials/fadmin/icons/ignite.vtf" )

	resource.AddFile( "materials/fadmin/icons/jail.vmt" )

	resource.AddFile( "materials/fadmin/icons/jail.vtf" )

	resource.AddFile( "materials/fadmin/icons/kick.vmt" )

	resource.AddFile( "materials/fadmin/icons/kick.vtf" )

	resource.AddFile( "materials/fadmin/icons/Message.vmt" )

	resource.AddFile( "materials/fadmin/icons/Message.vtf" )

	resource.AddFile( "materials/fadmin/icons/MOTD.vmt" )

	resource.AddFile( "materials/fadmin/icons/MOTD.vtf" )

	resource.AddFile( "materials/fadmin/icons/noclip.vmt" )

	resource.AddFile( "materials/fadmin/icons/noclip.vtf" )

	resource.AddFile( "materials/fadmin/icons/PickUp.vmt" )

	resource.AddFile( "materials/fadmin/icons/PickUp.vtf" )

	resource.AddFile( "materials/fadmin/icons/ragdoll.vmt" )

	resource.AddFile( "materials/fadmin/icons/ragdoll.vtf" )

	resource.AddFile( "materials/fadmin/icons/RCON.vmt" )

	resource.AddFile( "materials/fadmin/icons/RCON.vtf" )

	resource.AddFile( "materials/fadmin/icons/ServerSetting.vmt" )

	resource.AddFile( "materials/fadmin/icons/ServerSetting.vtf" )

	resource.AddFile( "materials/fadmin/icons/slap.vmt" )

	resource.AddFile( "materials/fadmin/icons/slap.vtf" )

	resource.AddFile( "materials/fadmin/icons/slay.vmt" )

	resource.AddFile( "materials/fadmin/icons/slay.vtf" )

	resource.AddFile( "materials/fadmin/icons/spectate.vmt" )

	resource.AddFile( "materials/fadmin/icons/spectate.vtf" )

	resource.AddFile( "materials/fadmin/icons/teleport.vmt" )

	resource.AddFile( "materials/fadmin/icons/teleport.vtf" )

	resource.AddFile( "materials/fadmin/icons/voicemute.vmt" )

	resource.AddFile( "materials/fadmin/icons/voicemute.vtf" )

	resource.AddFile( "materials/fadmin/icons/weapon.vmt" )

	resource.AddFile( "materials/fadmin/icons/weapon.vtf" )

	resource.AddFile( "materials/fadmin/IconView.vmt" )

	resource.AddFile( "materials/fadmin/IconView.vtf" )

	resource.AddFile( "materials/fadmin/ListView.vmt" )

	resource.AddFile( "materials/fadmin/ListView.vtf" )

	resource.AddFile("models/warz/consumables/medicine.mdl")

	resource.AddFile("models/warz/consumables/painkillers.mdl")

	resource.AddFile("models/warz/items/bandage.mdl")

	resource.AddFile("models/warz/items/medkit.mdl")

	resource.AddFile("materials/models/warz/consumables/consumables_01.vmt")

	resource.AddFile("materials/models/warz/consumables/consumables_02.vmt")

	resource.AddFile("materials/models/warz/consumables/consumables_01_norm.vtf")

	resource.AddFile("materials/models/warz/consumables/consumables_02_norm.vtf")

	resource.AddFile("materials/models/warz/items/bandage1.vmt")

	resource.AddFile("materials/models/warz/items/bandage2.vmt")

	resource.AddFile("materials/models/warz/items/medkit.vmt")

	resource.AddFile("materials/models/warz/items/medkit_norm.vtf")

	resource.AddFile("materials/models/warz/items/bandage_norm.vtf")

	resource.AddFile( "sound/death03.mp3" )

	resource.AddFile( "sound/Drink.mp3" )

	resource.AddFile( "sound/earthquake.mp3" )

	resource.AddWorkshop("104491619") -- Metropolice Pack

	-- resource.AddWorkshop("118759412") -- map city 45?

	resource.AddWorkshop("173482196") -- SProps Workshop Edition
	resource.AddWorkshop("128967611") -- [Swep] Combine Sniper
	resource.AddWorkshop("105841291") -- More Materials!
	resource.AddWorkshop("104548572") -- Playable Piano
	resource.AddWorkshop("1118211492") -- CrowCommunity Content
    resource.AddWorkshop("728638542") -- Vingard crow 2.o
    resource.AddWorkshop("175272156") -- Metrocop Beta Sounds
    resource.AddWorkshop("732711970") -- Portal
    resource.AddWorkshop("733021825") -- vins stuff
    resource.AddWorkshop("761228248") -- cuffs
    resource.AddWorkshop("593929594") -- food mdl
    resource.AddWorkshop("619791481") -- Hl2 beta PLayermodels
    resource.AddWorkshop("774902402") -- http://steamcommunity.com/sharedfiles/filedetails/?id=774902402 guns
    resource.AddWorkshop("798205573") -- lockplymodel
    resource.AddWorkshop("543527096") -- sheild
    resource.AddWorkshop("741788352") -- Airwatch
    resource.AddWorkshop("822075881") -- groundwatch
    -- resource.AddWorkshop("736405289") -- rp_nc_city8_v2b
    -- resource.AddWorkshop("1078089175") --JW Sounds
	-- resource.AddWorkshop("1086274975") -- Apex Anniversary Content
	resource.AddWorkshop("105042805") -- Combine Admin models	
   	-- resource.AddWorkshop("505686775") -- District 47
   	resource.AddWorkshop("131410709") -- Smoke_Grenade
	resource.AddWorkshop("844787757") -- Broadcast thing
	resource.AddWorkshop("1185975101") -- Apex i17 Build 8	
	--resource.AddWorkshop("1132466603") -- Stormfox	
	--resource.AddWorkshop("334195486") -- Halloween Props
	resource.AddWorkshop("206166550") -- Sabrean's Headcrab Zombie Mod
	resource.AddWorkshop("618272585") -- Industrial Uniforms
	resource.AddWorkshop("676638642") -- BMRP Scientist Models
	resource.AddWorkshop("122969743") -- Resistance Turrets
	resource.AddWorkshop("1366149792") -- RT Combine Screens
	resource.AddWorkshop("266180263") -- Cityruins
end



-- RP Name Overrides



local meta = FindMetaTable("Player")

meta.SteamName = meta.SteamName or meta.Name

function meta:Name()

	return GAMEMODE.Config.allowrpnames and self.DarkRPVars and self:getDarkRPVar("rpname")

		or self:SteamName()

end

meta.Nick = meta.Name

meta.GetName = meta.Name

-- End





util.AddNetworkString("DarkRP_InitializeVars")

util.AddNetworkString("DarkRP_DoorData")

util.AddNetworkString("DarkRP_keypadData")



AddCSLuaFile("sh_interfaceloader.lua")



-- Falco's prop protection

local BlockedModelsExist = sql.QueryValue("SELECT COUNT(*) FROM FPP_BLOCKEDMODELS1;") ~= false

if not BlockedModelsExist then

	sql.Query("CREATE TABLE IF NOT EXISTS FPP_BLOCKEDMODELS1(model VARCHAR(140) NOT NULL PRIMARY KEY);")

	include("fpp/FPP_DefaultBlockedModels.lua") -- Load the default blocked models

end

AddCSLuaFile("fpp/sh_CPPI.lua")

AddCSLuaFile("fpp/sh_settings.lua")

AddCSLuaFile("fpp/client/FPP_Menu.lua")

AddCSLuaFile("fpp/client/FPP_HUD.lua")

AddCSLuaFile("fpp/client/FPP_Buddies.lua")

AddCSLuaFile("shared/fadmin_darkrp.lua")



AddCSLuaFile("shared/sh_utf8.lua")

AddCSLuaFile("shared/sh_pon.lua")

AddCSLuaFile("shared/sh_netstream2.lua")

AddCSLuaFile("shared/sh_anims.lua")



include("fpp/sh_settings.lua")

include("fpp/sh_CPPI.lua")

include("fpp/server/FPP_Settings.lua")

include("fpp/server/FPP_Core.lua")

include("fpp/server/FPP_Antispam.lua")



AddCSLuaFile("addentities.lua")

AddCSLuaFile("shared.lua")

AddCSLuaFile("ammotypes.lua")

AddCSLuaFile("cl_init.lua")

AddCSLuaFile("config.lua")



AddCSLuaFile("client/cl_chatlisteners.lua")

AddCSLuaFile("client/DRPDermaSkin.lua")

AddCSLuaFile("client/help.lua")

AddCSLuaFile("client/helpvgui.lua")

AddCSLuaFile("client/hud.lua")

AddCSLuaFile("client/showteamtabs.lua")

AddCSLuaFile("client/vgui.lua")

AddCSLuaFile("modules/hl2rp/cl_event.lua")

AddCSLuaFile("client/3d2dimgui.lua")

AddCSLuaFile("client/cl_networking.lua")





AddCSLuaFile("shared/player_class.lua")

AddCSLuaFile("shared/animations.lua")

AddCSLuaFile("shared/commands.lua")

AddCSLuaFile("shared/entity.lua")

AddCSLuaFile("shared/MakeThings.lua")

AddCSLuaFile("shared/Workarounds.lua")



-- Earthquake Mod addon

resource.AddFile("sound/earthquake.mp3")

util.PrecacheSound("earthquake.mp3")



resource.AddFile("materials/darkrp/DarkRPSkin.png")



DB = DB or {}

GM.Config = GM.Config or {}

GM.NoLicense = GM.NoLicense or {}



-- sv_alltalk must be 0

-- Note, everyone will STILL hear everyone UNLESS rp_voiceradius is 1!!!

-- This will fix the rp_voiceradius not working

game.ConsoleCommand("sv_alltalk 0\n")



include("shared/sh_utf8.lua")

include("shared/sh_pon.lua")

include("shared/sh_netstream2.lua")

include("shared/sh_anims.lua")



include("_MySQL.lua")

include("config.lua")

include("licenseweapons.lua")



include("sh_interfaceloader.lua")



include("server/chat.lua")

include("server/admincc.lua")



include("shared/player_class.lua")

include("shared/animations.lua")

include("shared/commands.lua")

include("shared/entity.lua")



include("shared/MakeThings.lua")

include("shared/Workarounds.lua")



include("shared.lua")

include("addentities.lua")

include("ammotypes.lua")



include("server/database.lua")

MySQLite.initialize()

include("server/mysql.lua")

MySQL.initialize()

include("server/data.lua")

include("server/gamemode_functions.lua")

include("server/main.lua")

include("server/player.lua")

include("server/questions.lua")

include("server/util.lua")

include("server/votes.lua")

include("server/sv_networking.lua")



include("shared/fadmin_darkrp.lua")



/*---------------------------------------------------------------------------

Loading modules

---------------------------------------------------------------------------*/

local fol = GM.FolderName.."/gamemode/modules/"

local files, folders = file.Find(fol .. "*", "LUA")

for k,v in pairs(files) do

	if GM.Config.DisabledModules[k] then continue end



	include(fol .. v)

end



for _, folder in SortedPairs(folders, true) do

	if folder ~= "." and folder ~= ".." and not GM.Config.DisabledModules[folder] then

		for _, File in SortedPairs(file.Find(fol .. folder .."/sh_*.lua", "LUA"), true) do

			if File == "sh_interface.lua" then continue end



			AddCSLuaFile(fol..folder .. "/" ..File)

			include(fol.. folder .. "/" ..File)

		end



		for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do

			if File == "sv_interface.lua" then continue end

			include(fol.. folder .. "/" ..File)

		end



		for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do

			if File == "cl_interface.lua" then continue end

			AddCSLuaFile(fol.. folder .. "/" ..File)

		end

	end

end



DarkRP.finish()



local function GetAvailableVehicles(ply)

	if IsValid(ply) and not ply:IsAdmin() then return end

	ServerLog("Available vehicles for custom vehicles:" .. "\n")

	print("Available vehicles for custom vehicles:")

	for k,v in pairs(DarkRP.getAvailableVehicles()) do

		ServerLog("\""..k.."\"" .. "\n")

		print("\""..k.."\"")

	end

end

concommand.Add("rp_getvehicles_sv", GetAvailableVehicles)



function PlayerDeath(ply, weapon, killer)



	if ply:getDarkRPVar("money") and ply:getDarkRPVar("money") ~= 0 then



	local money = ply:getDarkRPVar("money")

	DarkRPCreateMoneyBag(ply:GetPos() + Vector(0,0,16), money)

	ply:AddMoney(-money)

	ply:ChangeTeam( TEAM_CITIZEN, true )



	end



			if ply:isArrested() then

				ply:unArrest()

			end



	ply:SendLua("surface.PlaySound('death03.mp3')")







	if killer:IsPlayer() then

	killedby = killer:Nick()

	end



	if not killer:IsPlayer() or killer == ply then

	killedby = tostring(killer)

		if string.find(string.lower(killedby), "trigger_hurt") then

		killedby = "the world"

		end



		if string.find(string.lower(killedby), "worldspawn") then

		killedby = "the world"

		end



		if string.find(string.lower(killedby), "npc") then

		killedby = "an NPC"

		end



		if string.find(string.lower(killedby), "vehicle") then

		killedby = "a vehicle"

		end



	end





	if killer == ply then

	killedby = "yourself"

	end



	umsg.Start( "KilledBy", ply )

    	umsg.String( killedby )

	umsg.End()



	ply:ConCommand( "SpawnTimer" )



	if ply:IsVIP() then

		ply:SendLua("spawntime = 10")

	end



end

hook.Add("PlayerDeath", "Player Dies", PlayerDeath)



/*function SendSTime()



	local shour = tonumber(os.date("%H"));

	local sminute = tonumber(os.date("%M"));



	if sminute < 10 then sminute = "0" .. sminute end

	if shour < 10 then shour = "0" .. shour end

	stime = shour .. ":" .. sminute





	umsg.Start( "STime", ply )

    umsg.String( stime )

	umsg.End()



end	*/

--hook.Add( "Think", "Send Server Time", SendSTime )



hook.Add( "PlayerSpray", "DisablePlayerSpray", function( ply )

	return true

end )



function DonateCommand( ply, text)

if (text == "!rules") then

ply:SendLua([[gui.OpenURL("http://www.apex-roleplay.com/index.php?threads/half-life-2-rp-server-rules.2/")]])

end

end

hook.Add( "PlayerSay", "Donate Page Command", DonateCommand )





/*---------------------------------------------------------------------------

DarkRP blocked entities

---------------------------------------------------------------------------*/

local blockTypes = {"Physgun1", "Spawning1", "Toolgun1"}

FPP.AddDefaultBlocked(blockTypes, "chatindicator")

FPP.AddDefaultBlocked(blockTypes, "darkrp_cheque")

FPP.AddDefaultBlocked(blockTypes, "darkp_console")

FPP.AddDefaultBlocked(blockTypes, "drug")

FPP.AddDefaultBlocked(blockTypes, "drug_lab")

FPP.AddDefaultBlocked(blockTypes, "fadmin_jail")

FPP.AddDefaultBlocked(blockTypes, "food")

FPP.AddDefaultBlocked(blockTypes, "gunlab")

FPP.AddDefaultBlocked(blockTypes, "letter")

FPP.AddDefaultBlocked(blockTypes, "meteor")

FPP.AddDefaultBlocked(blockTypes, "spawned_food")

FPP.AddDefaultBlocked(blockTypes, "spawned_money")

FPP.AddDefaultBlocked(blockTypes, "spawned_shipment")

FPP.AddDefaultBlocked(blockTypes, "spawned_weapon")



FPP.AddDefaultBlocked("Spawning1", "darkrp_laws")



concommand.Add("gmod_admin_cleanup", function()

	return false

end)



function GM:InitPostEntity( )


for v,k in pairs(ents.GetAll())do
if k:GetName()=="Diesel_timer" or k:GetName()=="train_timer" then
k:Remove()
end
end



for v,k in pairs(GetConfig().RemoveObjByPos)do

for x,c in pairs(ents.GetAll())do

if c:GetPos()==k then

c:Remove()

end

end



end



end





concommand.Add( "entity_pos", function( ply )

	local tr = ply:GetEyeTrace()

	if ( IsValid( tr.Entity ) ) then

		print( "Entity position:", tr.Entity:GetPos() )

	else

		print( "Crosshair position:", tr.HitPos )

	end

end )



concommand.Add( "entity_ang", function( ply )

	local tr = ply:GetEyeTrace()

	if ( IsValid( tr.Entity ) ) then

		print( "Entity angle:", tr.Entity:GetAngles() )

	else

		print( "Crosshair position:", tr.HitPos )

	end

end )





if GetConfig().RemoveArmor==true then

        timer.Create("cleanshit", 15, 1, function()

	        for k, v in pairs(ents.FindByClass("item_suitcharger")) do v:Remove() end

        end)

end





if GetConfig().RemovePhysProps==true then

        timer.Create("cleanshit", 15, 1, function()

	        for k, v in pairs(ents.FindByClass("prop_physics")) do v:Remove() end

        end)

end