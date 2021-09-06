local meta = FindMetaTable("Player")

function meta:AddXp( amount )
	local current_xp = self:GetXp()
	self:SetXp( current_xp + amount )
end

function meta:SetXp( amount )
	self:SetNetworkedInt( "Xp", amount )
	self:SetDarkRPVar("xp", amount)
	self:SaveXp()
end

function meta:SaveXp()
	local experience = self:GetXp()
	self:SetPData( "xp", experience )
end

function meta:SaveXpTXT()
	file.Write( gmod.GetGamemode().Name .."/Xp/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetXpString() )
end

function meta:TakeXp( amount )
   self:AddXp( -amount )
end

function meta:GetXp()
	return self:GetNetworkedInt( "Xp" )
end




if (SERVER) then


	XP_STARTAMOUNT = 0

	function xFirstSpawn( ply )
		local experience = ply:GetPData( "xp" )

		if experience == nil then
			ply:SetPData("xp", XP_STARTAMOUNT)
			ply:SetXp( XP_STARTAMOUNT )
		else
			ply:SetXp( experience )
		end

	end
	hook.Add( "PlayerInitialSpawn", "xPlayerInitialSpawn", xFirstSpawn )

	function PrintXp( pl )
		pl:ChatPrint( "Your xp is: " .. pl:GetXp() )
	end

	function xPlayerDisconnect( ply )
		print("Player Disconnect: Xp saved to SQLLite and TXT")
		ply:SaveXp()
		ply:SaveXpTXT()
	end

	concommand.Add( "xp_get", PrintXp )

end

time=60*10

hook.Add( "PlayerInitialSpawn", "XPAdd", function(ply)  -- Create hook for when a playerj oins
	timer.Create(ply:SteamID() .. "XPTimer", time, 0, function () xpGive(ply) end) --create a timer for each player using thier name in the identifier. the 10 is the delay in seconds, 0 is how many times to repeat ( 0 is infinte)
end)

local vipxp = 10;
local xpa = 5;
function xpGive(ply)
	if ply:getDarkRPVar("AFK") then
		ply:ChatPrint("You did not get any XP because you are AFK!" )		
		
	elseif ply:IsUserGroup( "vip" ) then
        ply:AddXp(vipxp)
		ply:ChatPrint("For playing on the server (and owning VIP) for 10 minutes you have been awarded "..vipxp )
    else
		ply:AddXp(xpa)
		ply:ChatPrint("For playing on the server for 10 minutes you have been awarded "..xpa )
    end
end

--For HUD use "tostring(LocalPlayer():GetXp())"