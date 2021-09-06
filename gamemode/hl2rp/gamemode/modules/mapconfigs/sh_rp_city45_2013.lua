if not maphl2config  then maphl2config = {} end
maphl2config["rp_city45_2013"] = {
Spawn1=Vector(-2518.828369, 2044.253418, 467.387451),
Spawn2=Vector(-1718.954590, 3028.245605, 911.715698),
JailExit=Vector(-1626.041138, 2703.455078, 629.551941),
JailExitAngle= Angle(0.000000, 128, 0.000000),
Broadcast=Vector(1979.948853, 596.333252, 2943.031250),
RationPos=Vector(),
RemoveArmor=true,
RemovePhysProps=false,
RationDispPos = Vector(384.486603, 3586.132813, 550.927185),
RationCPDispPos = Vector(1803.898438, 674.680115, 804.312073),
RemoveObjByPos={
Vector(1173.000000, -382.000000, 74.339996),
Vector(1175.000000, -389.000000, 73.302002),
Vector(1023.000000, -382.000000, 74.339996),
Vector(938.000000, -382.000000, 74.339996)
},
ButtonTable =  {

{
pos = Vector(2192.010010, 906.359985, 939.510010 ),
check = function(p)
if p:Team() == TEAM_CP or p:Team() == TEAM_OVERWATCH or  p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
jw = true
if jw == true then
p:notify("You have deactivated JW.")

return true
else

p:notify("You have activated JW.")

return true
end

else
p:notify("You must be a higher rank to activate this.")
return false

end

end
},

{
pos = Vector(2160.010010, 908.520020, 936.989990  ),
check = function(p)
if p:IsAdmin() then
p:notify("You have activated lockdown.")

return true
else

p:notify("You must be an admin to perform this action.")

return false


end


end
},
{
pos = Vector(2258.010010, 912.119995, 940.090027  ),
check = function(p)
if p:IsAdmin() then
p:notify("You have activated thumpers.")

return true
else

p:notify("You must be an admin to perform this action.")

return false


end


end
}

},
BioZones={
["Plaza"]={Vector(1289.985596, 3577.594727, 462.567841),Vector(-579.104858, 780.070496, 1894.703613)},
["CWU Block"]={Vector( 80.010956, 392.066895, 410.826996),Vector(-2573.559326, -1815.437500, 1196.281982)},
["Nexus (Lower)"]={Vector(-419.959229, -2223.557617, -265.056122),Vector( 2078.324951, 694.232178, 410.962036)},
["Nexus (Upper)"]={Vector(2503.161865, 518.211670, 537.514038),Vector(1456.461304, 1396.226074, 3903.375000)},
["Trainstation"]={Vector( -562.355408, 3192.391846, 1307.742676),Vector(-2437.369385, 1118.921753, 539.975525)},
["Checkpoint"]={Vector(4928.832031, 1716.839478, 409.814728),Vector(2865.234619, -1246.801147, 1434.107544)},
["Residential"]={Vector(3706.463379, 1905.920288, 454.658264),Vector(1371.479248, 3548.520264, 1285.428345)},
["Abandoned train yard"]={Vector(-2117.502441, 1971.503418, 873.890015),Vector(-3843.302979, 457.810242, -60.171127)}
},
CitadelPortal=Vector(776.069275, 1932.165527, 1211.063354),
AptData={
Vector(1791,2898,987),
Vector(1911,2898,987),
Vector(2717,2898,987),
Vector(2837,2898,987),
Vector(2837,2898,830),
Vector(2717,2898,830),
Vector(1911,2898,830),
Vector(1791,2898,830),
Vector(1791,2898,673),
Vector(1911,2898,673),
Vector(2717,2898,673),
Vector(2837,2898,673)

}
}