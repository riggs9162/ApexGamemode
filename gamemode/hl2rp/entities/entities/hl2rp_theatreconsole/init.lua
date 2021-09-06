AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')
util.AddNetworkString("APEX-THEATRE-PANEL")


function ENT:Initialize()
	self:SetModel("models/props/cs_assault/ConsolePanelLoadingBay.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

end

function ENT:Use(activator)
	net.Start("APEX-THEATRE-PANEL")
	net.Send(activator)
end
