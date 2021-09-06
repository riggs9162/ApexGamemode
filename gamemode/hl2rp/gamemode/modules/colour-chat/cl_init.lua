--~ function ApexReceiveMsg()
--~ return net.ReadString()

--~ end
--~ net.Receive("apexmessage", ApexReceiveMsg)


--~ function ApexReceiveTeam()
--~ return net.ReadColor()
--~ print(net.ReadColor())

--~ end
--~ net.Receive("apexchatdata_team", ApexReceiveTeam)

--~ function ApexReceiveName()
--~ return net.ReadString()

--~ end
--~ net.Receive("apexchatdata_name", ApexReceiveName)



function ApexChatBuild()
local oocTags = {
	["superadmin"]	= "Super Admin",
	["admin"]		= "Admin",
	["gamemaster"]	= "Game Master",	
	["moderator"]	= "Mod",
	["vip"]			= "VIP"
}

local ooccolour = {
	["superadmin"]	= Color(235,1,1),
	["admin"]		= Color(53,209,22),
	["gamemaster"]	= Color(242,0,255),
	["moderator"]	= Color(34,88,216),
	["vip"]			= Color(212,185,9),
	["user"]        = Color(255,255,255)
}


data = net.ReadString()
message = net.ReadString()
ply = net.ReadEntity()
plyNAME = ply:Nick()
teamCOL = team.GetColor(ply:Team())
steamNAME = ply:SteamName()
usergroup = ply:GetUserGroup()
steamID = ply:SteamID()

if (oocTags[usergroup]) then
prefix = "["..oocTags[usergroup].."]"
else
prefix = ""
end

if (ooccolour[usergroup]) then
prefixc = ooccolour[usergroup]
else
prefixc = ""
end


local data1 = "chat.AddText("..data..")"
local data2 = CompileString(data1, "ChatColourPrint")

data2()

end
net.Receive("apexchatdata", ApexChatBuild)