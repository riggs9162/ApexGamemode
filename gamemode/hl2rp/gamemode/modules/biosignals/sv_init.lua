
function ToCp(msg)
	for k, v in pairs(player.GetAll()) do
		if v:IsCP() then
			v:ChatPrint(msg)
			v:EmitSound("npc/overwatch/radiovoice/unitdownat.wav")
			timer.Simple(1, function()
if not v:IsValid() then return end
 v:EmitSound("npc/overwatch/radiovoice/404zone.wav") end)
			timer.Simple(2.3, function()
if not v:IsValid() then return end
 v:EmitSound("npc/overwatch/radiovoice/allteamsrespondcode3.wav") end)
		end
	end
end



function BioDeath(victim)
if not victim:IsCP() then return end
victim.nolock = true
for v,k in pairs(GetConfig().BioZones)do
local name=v
print(k)
for k, v in pairs (ents.FindInBox(k[1], k[2]) ) do
		if v:IsPlayer() and v == victim then
			ToCp("Unit ("..victim:GetName()..") down at: "..name)
			victim.nolock = false
			break
		end
end

end


if victim.nolock == true then
	ToCp("Unit ("..victim:GetName()..") down at: unknown location.")
	victim.nolock = true
end

end

hook.Add("PlayerDeath", "dasasdsa", BioDeath)
