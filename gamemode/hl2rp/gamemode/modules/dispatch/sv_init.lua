local function DispatchMenu (ply)
if ply:Team() == TEAM_DISPATCH then
ply:notify "Checking database whitelists..."
if ply:SteamID() == "STEAM_0:1:95921723" or ply:SteamID() == "STEAM_0:1:65486663" or ply:SteamID() == "STEAM_0:1:28816846" or ply:SteamID() == "STEAM_0:1:43410350" or ply:SteamID() == "STEAM_0:0:39628381" or ply:SteamID() == "STEAM_0:1:109245624" or ply:IsSuperAdmin() then
ply:notify "You are whitelisted."
ply:SetPos( Vector(-5033.580078, 3227.948486, 448.031250))
ply:SetRPName( "Dispatch", true )
else
ply:notify "You are not whitelisted for dispatch apply at apex-roleplay.com"
ply:ChangeTeam( TEAM_CITIZEN, true )
ply:SetModel("models/player/Group01/male_08.mdl") 
end
end
end
concommand.Add("dispatchmenu", DispatchMenu)

local function DispatchBodycam(ply, cmd, args)


	 if not ply:Team() == TEAM_DISPATCH then return end


	--if ply:EntIndex() ~= 0 then
--		victim = ply:SteamID()
--ply:ChatPrint("Error, if this continues contact TheVingard.")
--ply:ChatPrint("Use the site www.apex-roleplay.com")
--print ( "VINERROR ON:", victim )
--		return
	--end

	local target = GAMEMODE:FindPlayer(args[1])
	--local targetname = "placeholder"
	--local targethp = target:Health()
	--local targetarmor = target:Armor()

	if target then
	if not target:IsCP() then return end

	ply:notify ("<:: You are now watching unit ::>")
	ply:ChatPrint ( "<:: DATABASE START ::>" )
	ply:ChatPrint ( "Unit Status:")
	ply:ChatPrint ( "Name: ", targetname )
	ply:ChatPrint ( "Vital Signs:")
	ply:ChatPrint ( "Armor: ", targetarmor )
	ply:ChatPrint ( "Health: ", targethp )
	ply:ChatPrint ( "<:: DATABASE END ::>" )

	ply:Spectate( OBS_MODE_IN_EYE )
	ply:SpectateEntity ( target )
                ply:ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
	ply:StripWeapons()
	end







end
concommand.Add("dispatch_bodycam_on", DispatchBodycam)

local function DispatchWaypnt(ply, cmd, args)



	 if not ply:Team() == TEAM_DISPATCH then return end

	if not ply:IsCP() then return end

	for k, v in pairs ( player.GetAll( ) ) do

	if args[1] == "1" then
	v:SetPData( "waypos", Vector ( 2378.332031, 3584.725098, 200.031250 ) )
	print "set"
	v:notify ( (v:GetPData( "waypos" )) )

	elseif args[1] == "2" then

	v:SetPData( "waypos", Vector ( -420.485107, 3576.519043, 192.031250 ) )

	elseif args[1] == "3" then

	v:SetPData( "waypos", Vector ( 1997.740112, 2160.160400, 192.031250 ) )

	elseif args[1] == "4" then

	v:SetPData( "waypos", Vector ( 3710.600586, 5129.476074, 384.031250 ) )

	elseif args[1] == "5" then

	v:SetPData( "waypos", Vector ( 3718.439453, 7897.197754, 384.031250 ) )

	elseif args[1] == "6" then

	v:SetPData( "waypos", Vector ( 5537.891113, 4706.800781, 392.031250 ) )

	elseif args[1] == "7" then

	v:SetPData( "waypos", Vector ( 3935.802002, 2924.833496, 264.031250 ) )

	end



	end


	end






concommand.Add("dispatch_waypoint", DispatchWaypnt)


local function DispatchBodycamSTOP(ply, cmd, args)


	if not ply:Team() == TEAM_DISPATCH then return end



	ply:notify ("<:: You are no longer watching unit  ::>")
        ply:SetHealth(100)


	ply:UnSpectate()
                ply:ConCommand( "pp_mat_overlay effects/combine_binocove" )








end
concommand.Add("dispatch_bodycam_off", DispatchBodycamSTOP)

function CCTVWatch(ply, cmd, args)
	if not ply:Team() == TEAM_DISPATCH then return end
if args[1] == "1" then
	umsg.Start("CCTV1Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
print "done"

elseif args == "2" then
	umsg.Start("CCTV2Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "3" then
	umsg.Start("CCTV3Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "4" then
	umsg.Start("CCTV4Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "5" then
	umsg.Start("CCTV5Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "6" then
	umsg.Start("CCTV6Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "7" then
	umsg.Start("CCTV7Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "8" then
	umsg.Start("CCTV8Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "9" then
	umsg.Start("CCTV9Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "10" then
	umsg.Start("CCTV10Cam", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
elseif args == "close" then
	umsg.Start("CCTVReset", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
end
end

concommand.Add("dispatch_cctv", CCTVWatch)

function StopCam(ply)
umsg.Start("CCTVReset", ply)
end
concommand.Add("dispatch_cctvreset", StopCam)

function CoreUISv (ply)

	umsg.Start("CoreUI", ply) -- Prepare the usermessage to that same player to open the menu on his side.
	umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
-- ply:SetColor(0,0,0,0)
ply:Freeze( true )
ply:SetPos( Vector (7887.924805, 12612.353516, 8093.315918))

end


concommand.Add("dispatch_core", CoreUISv)
