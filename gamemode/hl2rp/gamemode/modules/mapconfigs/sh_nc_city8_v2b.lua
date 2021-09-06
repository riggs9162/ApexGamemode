if not maphl2config  then maphl2config = {} end
maphl2config["rp_nc_city8_v2b"] = {

Spawn1=Vector(-6296.031250, 5696.001953, -159.968750),
Spawn2=Vector(-6886.111328, 5994.927734, -80.423271),
JailExit=Vector(-7227.603516, 9392.972656, -167.968750),
JailExitAngle= Angle(0.000000, 0.000000, 0.000000),
Broadcast=Vector(6861.963867, 1884.915527, -327.968750),
RationPos=Vector(),
RemoveArmor=true,
RemovePhysProps=false,
RationDispPos = Vector(-6011.838379, 9791.314453, -119.624725),
RationCPDispPos = Vector(-8668.901367, 9383.625000, -147.416992),
RemoveObjByPos={
},
ButtonTable =  {

{
pos = Vector ( 6881.3, 1899, -349.48 ),
check = function(p)
if p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
p:notify("Judgement Waiver activated")

return true
else

p:notify("Access denied to Judgement Waiver")

return false


end


end
},

{
pos = Vector(6881.3, 1869, -349.48),
check = function(p)
if p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
p:notify("Judgement Waiver deactivated")

return true
else

p:notify("Access denied to Judgement Waiver")

return false


end


end
},

{
pos = Vector(-7031.000000, 10693.000000, 94.559998 ),
check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "CCA-SeC" ) or string.match( p:Name(), "CCA-CmD" ) or string.match( p:Name(), "OTA-OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
		p:notify("Access granted to Nexus control")

		return true
		else

		p:notify("Access denied to Nexus control")

		return false


		end
	end

end
},

{
pos = Vector(-7069.000000, 10625.000000, 89.290001 ),
check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "CCA-SeC" ) or string.match( p:Name(), "CCA-CmD" ) or string.match( p:Name(), "OTA-OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
		p:notify("Access granted to Nexus control")

		return true
		else

		p:notify("Access denied to Nexus control")

		return false


		end
	end

end
},

{
pos = Vector(-3207.92, 6852.01, -40),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Ration cycle announced")

return true
else

p:notify("Access denied to ration cycle controls")

return false


end


end
},

{
pos = Vector(-6816.000000, 6097.500000, 89.000000 ),
check = function(p)
	if p:IsCP() or p:IsAdmin() then
	if string.match( p:Name(), "CCA-SeC" ) or string.match( p:Name(), "CCA-CmD" ) or string.match( p:Name(), "DvL" ) or p:Team() == TEAM_OVERWATCH or  p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
		p:notify("Access granted to main access tunnel")

		return true
	else

		p:notify("Access denied to main access tunnel")

		return false

	end

	end


end
},

{
pos = Vector(-6837.339844, -825.000000, 70.519997 ),
check = function(p)
	if p:IsCP() or p:IsAdmin() then
	if string.match( p:Name(), "CCA-SeC" ) or string.match( p:Name(), "CCA-CmD" ) or string.match( p:Name(), "DvL" ) or p:Team() == TEAM_OVERWATCH or  p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
		p:notify("Access granted to main access tunnel")

		return true
	else

		p:notify("Access denied to main access tunnel")

		return false

	end

	end


end
},


{
pos = Vector(-4151.500000, 6352.500000, -182.500000),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Access granted to tunnel network")

return true
else

p:notify("Access denied to tunnel network")

return false


end


end
},


{
pos = Vector(-3590, 8345.7, 74.26),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Access granted to tunnel network")

return true
else

p:notify("Access denied to tunnel network")

return false


end


end
},

{
pos = Vector(-3614.000000, 8357.000000, 72.000000),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Access granted to tunnel network")

return true
else

p:notify("Access denied to tunnel network")

return false


end


end
},

{
pos = Vector(-5665.000000, 8370.650391, 82.519997),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Access granted to tunnel network")

return true
else

p:notify("Access denied to tunnel network")

return false


end


end
},

{
pos = Vector(-6837.339844, 6985.000000, 78.519997),
check = function(p)
if p:IsCP() or p:IsAdmin() then
p:notify("Access granted to tunnel network")

return true
else

p:notify("Access denied to tunnel network")

return false


end


end
}

},

BioZones={
["Warehouse 3"]={Vector(-3646.147461, 7822.276367, -218.053802),Vector(-3018.838623, 6843.895020, 292.898132)},
["Main Access Tunnel"]={Vector(-6122.083008, 6033.544434, 16.782547),Vector(-6957.165039, -873.018555, 337.180481)},
["Citadel"]={Vector(-984.539001, 2878.605469, -4711.113770),Vector(5926.631348, 514.463501, 792.312622)},
["City Administrator's Office"]={Vector(5969.627930, 1366.259644, -408.810791),Vector(6997.258301, 2693.215332, 281.87359)},
["Citadel Control"]={Vector(3935.988770, 12683.167969, -1738.281860),Vector(2444.470459, 15324.928711, -3810.354248)},
["Plaza"]={Vector(1289.985596, 3577.594727, 462.567841),Vector(-579.104858, 780.070496, 1894.703613)},
["CWU Block"]={Vector( 80.010956, 392.066895, 410.826996),Vector(-2573.559326, -1815.437500, 1196.281982)},
["District 9 Zone 2"]={Vector(-8792.085938, -9439.851563, -216.088135),Vector(-3959.281250, -15105.430664, -473.439880)},
["District 9 Zone 1"]={Vector(-2936.031250, -2056.821045, 88.437164),Vector(-9061.037109, -9228.312500, -231.542480)},
["District 9 Hardpoint"]={Vector(-2999.947754, -800.018005, 70.396973),Vector(-8920.109375, -1951.870117, 39.911880)},
["District 2"]={Vector(-7368, 9968, 592),Vector(-3657, 7599, -224)},
["Nexus Entrance"]={Vector(-7368, 9968, 592),Vector(-8712, 9200, -224)},
["Nexus"]={Vector(-8744, 9968,-224),Vector(-6664, 10800, 304)},
["Science Facility"]={Vector(-9304.085938, 6367.967773, -203.543365),Vector(-7799.927734, 7727.992188, -202.028442)},
["District 1"]={Vector(-7576, 2688, 544),Vector(-3657, 7599, -224)}

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