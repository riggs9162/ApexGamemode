if not maphl2config  then maphl2config = {} end

maphl2config["rp_city17_district47_hl2rp"] = {

Spawn1=Vector(-1908.905518, -2066.885986, 26.503090),

Spawn2=Vector(-3638.797607, -1381.328491, 464.594757),

JailExit=Vector(-952.447205, -1030.185181, 448.031250),

JailExitAngle= Angle(0.000000, 0.000000, 0.000000),

Broadcast=Vector(-413.703674, -1613.121460, 1335.710205),

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
id = 1920,
check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Nexus Defence Shield")

		return true

		else

		p:notify("Access denied to Nexus Defence Shield")

		return false

		end

	end

end
},



{

id = 1786,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

if LastJw and LastJw + 15 > CurTime() then return false end

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Judgment Waiver Controls")
                if not jw or jw == false then
jw=true
                SetGlobalBool("jw",true)
elseif jw==true then
jw=false
                SetGlobalBool("jw",false)


end
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

id = 1785,

check = function(p)

	if p:IsAdmin() then



	p:notify("Access granted to Autonomous Judgement Controls")



	return true

	else



	p:notify("Access denied to Autonomous Judgement Controls")



	return false





	

	end



end

},

-- Announcement buttons

{

id = 1843,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



{

id = 1847,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



{

id = 1850,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



{

id = 1356,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



{

id = 1355,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



{

id = 1354,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Announcement Controls")



		return true

		else



		p:notify("Access denied to Announcement Controls")



		return false





		end

	end



end

},



-- Nexus Airlock

{

id = 4278,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OTA-C17-" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Main Nexus Airlock")



		return true

		else



		p:notify("Access denied to Main Nexus Airlock")



		return false





		end

	end



end

},



{

id = 4264,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Main Nexus Airlock")



		return true

		else



		p:notify("Access denied to Main Nexus Airlock")



		return false





		end

	end



end

},



-- Nexus Prison



{

id = 1575,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 1")



		return true

		else



		p:notify("Access denied to Detention Cell 1")



		return false





		end

	end



end

},



{

id = 1578,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 2")



		return true

		else



		p:notify("Access denied to Detention Cell 2")



		return false





		end

	end



end

},



{

id = 1587,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 3")



		return true

		else



		p:notify("Access denied to Detention Cell 3")



		return false





		end

	end



end

},



{

id = 1599,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 4")



		return true

		else



		p:notify("Access denied to Detention Cell 4")



		return false





		end

	end



end

},



{

id = 1603,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 5")



		return true

		else



		p:notify("Access denied to Detention Cell 5")



		return false





		end

	end



end

},



{

id = 1606,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 6")



		return true

		else



		p:notify("Access denied to Detention Cell 6")



		return false





		end

	end



end

},



{

id = 1621,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 7")



		return true

		else



		p:notify("Access denied to Detention Cell 7")



		return false





		end

	end



end

},



{

id = 1632,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Cell 8")



		return true

		else



		p:notify("Access denied to Detention Cell 8")



		return false





		end

	end



end

},



{

id = 1871,

check = function(p)

	if p:IsCP() or p:IsAdmin() then



		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL-JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Detention Master Switch")



		return true

		else



		p:notify("Access denied to Detention Master Switch")



		return false





		end

	end



end

},



{

id = 4264,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Detention Centre")

	return true

	else

	p:notify("Access denied to Detention Centre")

	return false
	
	end
end
},

-- CHAMBER OF DEATH!!!

{
	
id = 4298,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Execution Chamber")
		return true

		else

		p:notify("Access denied to Execution Chamber")

		return false

		end
	end
end
},

{
	
id = 4301,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Execution Beam Activated")
		return true

		else

		p:notify("Access denied")

		return false

		end
	end
end
},
-- Front gate toggles

{

id = 5240,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Nexus Hardpoint Door 1")
		return true

		else

		p:notify("Access denied to Nexus Hardpoint Door 1")

		return false

		end
	end
end
},

{

id = 5072,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Nexus Hardpoint Door 2")
		return true

		else

		p:notify("Access denied to Nexus Hardpoint Door 2")

		return false

		end
	end
end
},

{

id = 5054,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Nexus Hardpoint Door 1")
		return true

		else

		p:notify("Access denied to Nexus Hardpoint Door 1")

		return false

		end
	end
end
},

{

id = 5243,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Nexus Hardpoint Door 2")
		return true

		else

		p:notify("Access denied to Nexus Hardpoint Door 2")

		return false

		end
	end
end
},

-- Outpost
{

id = 2052,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "CCA-C17-DvL" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Lockdown Force Field")
		return true

		else

		p:notify("Access denied to Lockdown Force Field")

		return false

		end
	end
end
},

-- Elevator call

{

id = 1906,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

{

id = 1907,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

{
id = 1908,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

{
id = 1909,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

{

id = 1910,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

{

id = 4421,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Nexus Elevator")

	return true

	else

	p:notify("Access denied to Nexus Elevator")

	return false
	
	end
end
},

--Elevator

{

id = 1889,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Trainyard")

	return true

	else

	p:notify("Access denied to Trainyard")

	return false
	
	end
end
},

{
id = 1890,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

	p:notify("Access granted to Ground Level")

	return true

	else

	p:notify("Access denied to Ground Level")

	return false
	
	end
end

},

{

id = 1891,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Floor 1: Prison Control")
		return true

		else

		p:notify("Access denied to Floor 1: Prison Control")

		return false

		end
	end
end
},

{

id = 1892,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Floor 2: Nexus Control")
		return true

		else

		p:notify("Access denied to Floor 2: Nexus Control")

		return false

		end
	end
end
},

{

id = 1893,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or p:Team() == TEAM_OVERWATCH or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Floor 3: Adminstration")
		return true

		else

		p:notify("Access denied to Floor 3: Adminstration")

		return false

		end
	end
end
},

{

id = 4419,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or p:Team() == TEAM_OVERWATCH or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Floor 4")
		return true

		else

		p:notify("Access denied to Floor 4")

		return false

		end
	end
end
},

-- Misc
{

id = 4616,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		p:notify("Access granted to the Nexus")
		return true

		else

		p:notify("Access denied to the Nexus")

		return false

	end
end
},

{

id = 4618,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		p:notify("Access granted to the Nexus")
		return true

		else

		p:notify("Access denied to the Nexus")

		return false

	end
end
},

{

id = 4225,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Intergation and Disposal")
		return true

		else

		p:notify("Access denied to Intergation and Disposal")

		return false

		end
	end
end
},

{

id = 4227,

check = function(p)
	if p:IsCP() or p:IsAdmin() then

		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "CmD" ) or string.match( p:Name(), "OWC" ) or string.match( p:Name(), "JURY" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

		p:notify("Access granted to Intergation and Disposal")
		return true

		else

		p:notify("Access denied to Intergation and Disposal")

		return false

		end
	end
end
}

},

BioZones={
["Zone 1"]={Vector(-3559.968750, 751.968750, 400),Vector(-578.851807, -626.956970, 819.703308)},
["Zone 2"]={Vector(-255.968750, -1497.968750, 400),Vector(1761.510620, 2521.100830, 1051.168701)},
["Zone 3"]={Vector(1890.293701, 1291.484009, 225),Vector( 3435.760498, -1144.328491, 913.941528)},
["Nexus"]={Vector(-1263.968750, -1744.031250, 400),Vector(-36.514580, -3531.228760, 1585.457886)},
["Nexus Hardpoint"]={Vector( -1057.231934, -1701.858521, 325),Vector(-2437.369385, 1118.921753, 539.975525)},
["Nexus Station"]={Vector(-47.677864, -1833.067993, -110),Vector( -4462.868164, -2715.592285, 1022.227234)},
["Trainyard"]={Vector( 6.162742, -1746.574707, -65),Vector( 4669.820313, -2992.609863, 611.012817)}
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