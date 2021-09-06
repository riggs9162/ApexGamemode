maphl2config = {}

function GetConfig()

if not maphl2config[game.GetMap()] then return print("NO MAP CONFIG!! SET IT IN MAPCONFIGS.LUA") end

local c = maphl2config[game.GetMap()]

return c





end


if SERVER then
	concommand.Add("debug_getid",function(p)

p:ChatPrint(p:GetEyeTrace().Entity:MapCreationID())
p:ChatPrint(p:GetEyeTrace().Entity:GetClass())


end)
end




if CLIENT then

local tbl = {}







concommand.Add("debug_adddoor",function()

local e=LocalPlayer():GetEyeTrace().Entity

if e then

table.insert(tbl,e:GetPos())

end

for v,k in pairs(tbl)do

print("Vector("..k.x..","..k.y..","..k.z.."),")



end

end)






end
