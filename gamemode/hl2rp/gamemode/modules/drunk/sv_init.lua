util.AddNetworkString( "DrunkVomit" )

local meta = FindMetaTable( "Player" )

function meta:addDrunkLevel(num)
	if self:getDarkRPVar("DrunkLevel") then
		self:SetDarkRPVar("DrunkLevel", self:getDrunkLevel()+num)
	else
		self:SetDarkRPVar("DrunkLevel", num)
	end
end

function meta:setDrunkLevel(num)
	self:SetDarkRPVar("DrunkLevel", num)
end

function meta:getDrunkLevel()
	return self:getDarkRPVar("DrunkLevel")
end

function meta:setLastVomit()
	self:SetDarkRPVar("LastVomit", CurTime())
end

function meta:getLastVomit()
	if not self:getDarkRPVar("LastVomit") then return 0 end
	return CurTime()-self:getDarkRPVar("LastVomit");
end

function meta:vomit()
	net.Start( "DrunkVomit" )
	net.Send(self)

	local edata = EffectData()

	edata:SetOrigin( self:EyePos() )

	edata:SetEntity( self )



	util.Effect( "vomit", edata, true, true )
end

function meta:hasMaxBarrels()

	local numb = 0
	for k, v in pairs( ents.FindByClass( "hl2rp_beerbrewer" ) ) do
			if self:SteamID() == v.SID then
				numb = numb +1
			end
		--PrintTable(v:GetTable())

	end
	if numb > 1 then
		return true
	end
		return false
end

timer.Create( "DrunkThink", 4, 0, function()
	for k, ply in pairs( player.GetAll() ) do

		if ply:getDrunkLevel() and ply:getDrunkLevel() > 0 then
			--print(ply:getDrunkLevel()-0.1)-- Debug Only print
			ply:setDrunkLevel(ply:getDrunkLevel()-0.1)
		end

		if ply:getDrunkLevel() and ply:getDrunkLevel() > 28 then
			if ply:getLastVomit() == 0 then ply:setLastVomit() end
			if ply:getLastVomit() > 30 then
				ply:vomit()
				
				ply:setLastVomit()
			end
		end		

		if ply:getDrunkLevel() and ply:getDrunkLevel() > 52 then
			ply:Kill();
		end		

	end

end)

hook.Add("OnPlayerChangedTeam", "RemoveDrunkOnChange", function(ply)
	ply:setDrunkLevel(0)
end)

hook.Add("PlayerDeath", "RemoveDrunkOnDeath", function(ply)
	ply:setDrunkLevel(0)
end)


concommand.Add("rp_vomit", function(ply)

	if not ply:IsAdmin() then return end

	ply:vomit()
end)

concommand.Add("rp_getdrunk", function(ply)

	if not ply:IsAdmin() then return end

	ply:addDrunkLevel(10)
end)

concommand.Add("rp_getsober", function(ply)

	if not ply:IsAdmin() then return end

	ply:setDrunkLevel(0)
end)


