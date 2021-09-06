ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "anim" -- What type of entity is it, in this case, it's an AI.
ENT.PrintName		= "Nexus Ration Dispenser"
ENT.Author			= "TheVingard, Nova_Canterra"
ENT.Contact			= "N/A"
ENT.Purpose			= "To dispense rations to the UU"
ENT.Instructions	= "Press E to claim ration"
ENT.Category 		= "UU"

ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.	self.AutomaticFrameAdvance = bUsingAnim

end