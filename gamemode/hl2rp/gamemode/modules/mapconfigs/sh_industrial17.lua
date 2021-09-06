if not maphl2config  then maphl2config = {} end
print("Loaded maphl2config rp_apex_industrial17_b10 config.")

maphl2config["rp_apex_industrial17_b10"] = {

Spawn1=Vector(-1596.293335, 3627.601563, 1152.450806),

Spawn2=Vector(-5084.677734, 2456.962402, 354.788422),

JailExit=Vector(2356.154053, 3228.347168, 200.031250),

JailExitAngle= Angle(2.539727, 179.481476, 0.000000),

Broadcast=Vector(2723.096436, 4052.320313, 3480.031250),

RationPos=Vector(),

RemoveArmor=true,

RemovePhysProps=false,

RationDispPos = Vector(384.486603, 3586.132813, 550.927185), 

RationCPDispPos = Vector(1803.898438, 674.680115, 804.312073), 

RemoveObjByPos={

Vector(-410, -2241, 821),

Vector(-352, -2242, 821)

},

ButtonTable =  {

{
id = 5803,
check = function(p)
	if p:CanAfford(1) then

        p:AddMoney(-1)

		p:notify("You put 1 token into the vending machine.")

		return true

		else

		p:notify("You don't have enough money to make this purchase.")

		return false


	end

end
},



{

id = 4879,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

if LastJw and LastJw + 15 > CurTime() then return false end

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Judgement Waiver Acivated.")


        SetGlobalBool("jw",true)


        LastJw=CurTime()


		return true

		else



		p:notify("Access denied to Judgment Waiver Controls")



		return false


		end

	end



end

},

{

id = 4880,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

if LastJw and LastJw + 15 > CurTime() then return false end

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Judgement Waiver De-acivated.")


        SetGlobalBool("jw",false)


        LastJw=CurTime()


		return true

		else



		p:notify("Access denied to Judgment Waiver Controls")



		return false


		end

	end



end

},



{

id = 4878,

check = function(p)

	if p:IsAdmin() then



	p:notify("Lockdown de-activated.")



	return true

	else



	p:notify("Access denied to Lockdown controls.")



	return false





	

	end



end

},

{

id = 4877,

check = function(p)

	if p:IsAdmin() then



	p:notify("Lockdown activated.")



	return true

	else



	p:notify("Access denied to Lockdown controls.")



	return false





	

	end



end

},

{

id = 4881,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Gate toggled.")



	return true

	else



	p:notify("Access denied to gate controls.")



	return false





	

	end



end

},

{

id = 4883,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Gate toggled.")



	return true

	else



	p:notify("Access denied to gate controls.")



	return false





	

	end



end

},

{

id = 4887,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Gate toggled.")



	return true

	else



	p:notify("Access denied to gate controls.")



	return false





	

	end



end

},

{

id = 4885,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Gate toggled.")



	return true

	else



	p:notify("Access denied to gate controls.")



	return false





	

	end



end

},

{

id = 5195,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Shell beach gate opened.")



	return true

	else



	p:notify("Access denied to Shell beach gate controls.")



	return false





	

	end



end

},

{

id = 5196,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Shell beach gate closed.")



	return true

	else



	p:notify("Access denied to Shell beach gate controls.")



	return false





	

	end



end

},

{

id = 5963,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "DvL" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Access granted to RDC door")



	return true

	else



	p:notify("Access denied to RDC door")



	return false





	

	end



end

},

{

id = 3844,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "DvL" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Access granted to RDC closed")



	return true

	else



	p:notify("Access denied to RDC closed")



	return false





	

	end



end

},

{

id = 4965,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "DvL" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Access granted to workcycle announcment")



	return true

	else



	p:notify("Access denied to workcycle announcment")



	return false





	

	end



end

},


{

id = 5669,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" )  then
        return true

	else

	return false





	

	end



end

},

{

id = 5670,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" ) then

	return true

	else

	return false





	

	end



end

},

{

id = 5577,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" ) then

	return true

	else

	return false

	end



end

},

{

id = 5668,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" ) then

	return true

	else

	return false

	end



end

},

{

id = 5681,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" ) then

	return true

	else

	return false

	end



end

},

{

id = 5682,

check = function(p)

	if string.match( p:Name(), "Mr Wasabi" ) then

	return true

	else

	return false

	end



end

},

{

id = 3843,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then



	p:notify("Access granted to RDC open")



	return true

	else



	p:notify("Access denied to RDC open")



	return false





	

	end



end

}


},
BioZones={
["Zone 1"]={Vector(-1029.761475, 3846.442383, 145.046249),Vector(-477.046478, 2368.791504, 335.014008)},
["Zone 1 "]={Vector(-1046.824341, 2305.866699, 155.014618),Vector( -67.561920, 970.629395, 313.453491)},
["Zone 1  "]={Vector(-49.381927, 970.885742, 313.453491),Vector(766.317932, 1116.373901, 133.528259)},
["Zone 1  "]={Vector(766.122559, 1131.525269, 135.045013),Vector( 520.756348, 1895.182129, 305.748199)},
["Zone 1   "]={Vector(-72.051712, 2420.701660, 120.955093),Vector(1444.932373, 1928.770508, 305.984833)},
["Zone 1 Checkpoint "]={Vector( 1465.775269, 1921.082397, 86.649582),Vector(2432.423584, 2431.340332, 348.479553)},
["Zone 1 Checkpoint  "]={Vector(2176.856201, 2443.275146, 127.303734),Vector(1822.109497, 2968.868652, 391.529327)},
["Zone 1     "]={Vector(2461.809326, 2421.933594, 135.756714),Vector(3035.562988, 2038.321289, 440.851013)},
["Zone 1      "]={Vector(3073.235107, 1154.522949, 121.944489),Vector(3938.338623, 5615.883789, 545.357483)},
["Zone 1 Theatre"]={Vector(3016.415771, 1813.463623, 129.987671),Vector(2191.460938, 923.569580, 608.526794)},
["Metropol"]={Vector(3595.157715, 1666.775513, -39.484100),Vector(3901.503662, 2549.606201, 1373.014160)},
["Diordna"]={Vector(3971.935547, 4738.779297, 332.112122),Vector(4606.538574, 5648.479492, 1038.036499)},
["Terminal Hotel"]={Vector(-312.209442, 3940.913574, 31.553032),Vector(645.955200, 4696.874023, 1229.425781)},
["Warehouse 1"]={Vector( 509.377930, 1122.122070, 139.774902),Vector(-53.119801, 1909.650757, 584.988342)},
["Warehouse 2"]={Vector(4993.952637, 3590.456299, 203.012405),Vector(4224.267090, 3961.133789, 557.860657)},
["Warehouse 3"]={Vector(2691.376953, 5121.277344, 320.866547),Vector(3387.688477, 6012.975098, 850.225464)},
["Warehouse 4"]={Vector(3974.502441, 4473.903809, 375.723206),Vector(4467.315918, 4104.208984, 610.411743)},
["Zone 1 Catwalks"]={Vector(3462.487549, 5819.147461, 832.326538),Vector(3588.620117, 1149.981934, 988.212097)},
["Zone 1 Catwalks "]={Vector(3451.375488, 5122.277344, 828.225525),Vector(2445.488525, 4856.549805, 985.942627)},
["Plaza Catwalks"]={Vector(2446.472168, 5149.363770, 795.374817),Vector(849.915527, 3041.474121, 1623.124756)},
["Traintracks"]={Vector(-1036.890625, 3841.911377, 314.754639),Vector(-507.680389, 1907.994263, 874.092041)},
["Traintracks "]={Vector(-479.605469, 1917.132324, 350.860321),Vector(3063.656738, 2503.289063, 860.362915)},
["Traintracks  "]={Vector(3080.191650, 1136.107910, 563.333313),Vector(3939.576416, 5640.351074, 669.770447)},
["Zone 2"]={Vector(-415.047424, 3844.370850, 97.434433),Vector(322.507050, 2582.471680, 412.607452)},
["Zone 2 "]={Vector(439.133728, 3381.322998, 113.708443),Vector(1279.131104, 3839.467529, 366.066376)},
["Zone 2  "]={Vector(1347.266113, 4098.734375, 125.404564),Vector(2425.816895, 3076.668213, 681.672668)},
["Zone 2   "]={Vector(2436.408203, 4099.972656, 50.028797),Vector(1803.619385, 5368.755371, 729.188599)},
["Zone 2    "]={Vector(2488.043701, 4791.758301, 286.190002),Vector(3363.462646, 5102.896484, 493.929504)},
["Zone 2     "]={Vector( 1217.946533, 3904.985596, 134.415375),Vector(656.076721, 5085.422852, 535.555420)},
["Zone 2      "]={Vector(1353.107300, 4082.180908, 349.542999),Vector(1755.640503, 4907.127930, 614.223022)},
["Hospital"]={Vector(384.523682, 3328.512451, 113.912979),Vector(1246.338013, 2583.503174, 594.880737)},
["Zone 3"]={Vector( 4000.188965, 4734.145996, 321.670868),Vector(5628.965820, 4493.187988, 691.787292)},
["Zone 3 "]={Vector(5653.437500, 4487.351074, 299.425262),Vector(6389.471191, 4195.530273, 794.697754)},
["Zone 3  "]={Vector(6380.309570, 4156.623047, 314.488983),Vector(5473.040527, 3244.875732, 2004.917236)},
["Shell Beach Tunnel"]={Vector(3842.878662, 5632.900879, 319.605255),Vector(3613.835449, 7931.359863, 573.070679)},
["Shell Beach"]={Vector(16252.493164, 8047.750488, -175.419800),Vector(-3784.619873, 14537.699219, 1011.381104)},
["Nexus Lobby"]={Vector(2474.510498, 3329.767090, 194.190506),Vector(3076.064209, 3830.787842, 350.546997)},
["Nexus Canteen"]={Vector(2560.302002, 3856.632813, 257.788696),Vector(3376.587158, 4272.765625, 507.654633)},
["Nexus"]={Vector(3354.469971, 3839.197998, 394.313873),Vector(2917.594727, 3322.791260, 521.591003)},
["Nexus "]={Vector(2541.593994, 2759.099121, 262.874329),Vector(2837.312012, 3307.162354, 512.261475)},
["Upper Nexus"]={Vector(2545.881348, 2576.760254, 528.587036),Vector(3313.645752, 4095.645020, 3217.277344)},
["Nexus Prison"]={Vector(3066.534180, 2571.775879, 195.163483),Vector(2194.586182, 3051.929932, 4.205414)},
["Nexus Prison "]={Vector(2600.295410, 3076.914551, 90.818878),Vector(3314.496338, 3838.297607, 220.996643)},
["Nexus Prison  "]={Vector(2702.055420, 3854.846436, 198.280167),Vector(2911.171387, 4383.917969, -299.047150)},
["Nexus Prison  "]={Vector(2913.586914, 4423.237305, -299.047150),Vector(2210.659668, 4597.004883, -114.407410)},
["Nexus Prison   "]={Vector(1922.479736, 4213.447266, -330.778473),Vector(2749.101074, 3326.804688, -78.790482)},
["Lower Nexus"]={Vector(2934.112305, 1350.556030, -2336.771729),Vector(827.240967, 3880.651611, -341.927399)},
["CA Office"]={Vector(3327.520020, 4102.697266, 3420.183350),Vector(2527.016357, 2561.057861, 4365.282227)},
["Construction Site"]={Vector(3624.138428, 1114.046021, 142.293915),Vector(4224.040039, 1664.438599, 1673.330566)},
["Construction Site "]={Vector(4289.855469, 1149.862427, 197.982635),Vector(6555.555664, 3202.489746, 1289.440918)},
["Zone 3     "]={Vector(5148.376953, 4765.783691, 296.114441),Vector(6348.016602, 5509.948730, 630.437378)}
},

CitadelPortal=Vector(-9025.842773, 7174.173340, 4307.405762),

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