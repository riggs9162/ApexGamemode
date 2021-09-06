
ENT.Base			= "base_gmodentity" 
ENT.Type			= "anim"
ENT.PrintName		= "ATM"
ENT.Author			= "Robotboy655"
ENT.Contact			= "N/A"
ENT.Purpose			= "ATM Banker"
ENT.Instructions	= "Press E"
ENT.Category 		= "Roleplay"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end