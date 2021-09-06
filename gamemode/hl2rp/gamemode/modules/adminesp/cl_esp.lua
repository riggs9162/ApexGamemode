hook.Add("HUDPaint","APEX-ADMIN-ESP",function()
		local client = LocalPlayer()

		if (client:IsAdmin() and client:GetMoveType() == MOVETYPE_NOCLIP and showesp) then
rebelcount=0
			for k, v in pairs(player.GetAll()) do
   if string.match( v:GetModel(), "group03" ) and v:Alive() then 
v.IsRebel=true
rebelcount=rebelcount+1 
else
v.IsRebel=nil
end
				if (v != client) then
					local position = v:LocalToWorld(v:OBBCenter()):ToScreen()
					local x, y = position.x, position.y

					draw.DrawText(v:Name(), "Trebuchet18", x,y, team.GetColor(v:Team()),TEXT_ALIGN_CENTER)
    if v.IsRebel then draw.DrawText("REBEL", "Trebuchet18", x,y+15, Color(255,0,0,255),TEXT_ALIGN_CENTER) end
				end
			end

for v,k in pairs(ents.GetAll())do
if k:GetClass()=="cp_npc" then
local position = k:LocalToWorld(k:OBBCenter()):ToScreen()
local x, y = position.x, position.y
					draw.DrawText("CP NPC", "Trebuchet24", x,y, Color(255,255,255,255))
elseif k:GetClass()=="ow_npc" then
local position = k:LocalToWorld(k:OBBCenter()):ToScreen()
local x, y = position.x, position.y
					draw.DrawText("OW NPC", "Trebuchet24", x,y, Color(255,255,255,255))
end

end


surface.SetDrawColor(70,70,70,130)
surface.DrawRect(0,0,200,100)
draw.DrawText("Players connected: "..#player.GetAll().."/"..game.MaxPlayers(),"Trebuchet18",10,10,Color(255,0,0,255))
draw.DrawText("Entity count: "..#ents.GetAll(),"Trebuchet18",10,30,Color(255,0,0,255))
draw.DrawText("Total combine: "..#team.GetPlayers(TEAM_CP)+#team.GetPlayers(TEAM_OVERWATCH),"Trebuchet18",10,50,Color(255,0,0,255))
draw.DrawText("Total citizens: "..#team.GetPlayers(TEAM_CITIZEN).." ("..rebelcount.." are rebels)","Trebuchet18",10,70,Color(255,0,0,255))

		end

end)



concommand.Add("hl2rp_showesp",function(p)
if not p:IsAdmin() then return end

if showesp then
showesp=nil
chat.AddText("ADMIN ESP OFF")
else
showesp=true
chat.AddText("ADMIN ESP ON")
end



end)

