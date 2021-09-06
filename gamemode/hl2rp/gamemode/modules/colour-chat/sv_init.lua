util.AddNetworkString( "apexchatdata" )
local meta = FindMetaTable("Player")

function meta:ApexChat(msg_data, ply, msg) -- INPUT: STRING this is experimental, may cause lag. be careful. ONLY WORKS WITH OOC AND GLOBAL CHAT CURRENTLY
data = tostring(msg_data)
if not msg then msg = "" end
if not ply then ply = "" end
net.Start("apexchatdata")
net.WriteString(msg_data) -- cheeky way of sending loads of data types in one, see cl file
net.WriteString(msg)
net.WriteEntity(ply)
net.Send(self)



end

--~ function ApexNetworkMessage(msg)
--~ for j, k in pairs (player.GetAll()) do
--~ net.Start("apexmessage")
--~ net.WriteString(msg) -- cheeky way of sending loads of data types in one, see cl file
--~ net.Send(k)
--~ end
--~ end


--~ function TeamSend(ply,k)
--~ net.Start("apexchatdata_team")
--~ net.WriteColor(team.GetColor(ply:Team()))
--~ print(ply:Team())
--~ net.Send(k)
--~ end

--~ function NameSend(ply,k)
--~ net.Start("apexchatdata_name")
--~ net.WriteString(ply:GetName())
--~ net.Send(k)
--~ end


