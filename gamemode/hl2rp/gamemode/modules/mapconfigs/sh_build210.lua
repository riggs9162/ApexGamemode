if not maphl2config  then maphl2config = {} end
print("Loaded maphl2config rp_city17_build210 config.")

maphl2config["rp_city17_build210"] = {

Spawn1=Vector(-3008.031250, -1327.968750, 112.029320),

Spawn2=Vector(-5228.991211, 1167.740356, 463.573486),

JailExit=Vector(-3383.426514, 1337.348755, 112.031250),

JailExitAngle= Angle( 15.824656, -89.999123, 0.000000),

Broadcast=Vector(5987.755371, -2517.000244, 4968.569336),

RationPos=Vector(),

RemoveArmor=true,

RemovePhysProps=false,

RationDispPos = Vector(1424.016113, -1872.031250, -399.968750), 

RationCPDispPos = Vector(1424.016113, -1872.031250, -399.968750), 

RemoveObjByPos={

Vector(-410, -2241, 821),

Vector(-352, -2242, 821)

},

ButtonTable =  {
   
--[[{

id = 2061,

check = function(p)

if p:IsCP() or p:IsAdmin() then
    if LastPressJw and LastPressJw + 15 > CurTime() then return false end
    if not LastJw and LastJw + 300 <= CurTime() or p:IsAdmin() then
		if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then
            if not jw or jw == false then
                jw = true
		        p:notify("Judgement Waiver Acivated.")
                SetGlobalBool("jw",true)
                LastPressJw=CurTime()
            return true
            end
            elseif jw == true then
                jw = false
                p:notify("Judgement Waiver Deacivated.")
                SetGlobalBool("jw",false)
                LastJw=CurTime()
            return true
            end
		else

		    p:notify("Access denied to Judgment Waiver Controls")

		return false
		end

	end

end
    
},
--]]

{

id = 2061,

check = function(p)

	if p:IsCP() or p:IsAdmin() then

if LastJw and LastJw + 18 > CurTime() then return false end

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

id = 2067,

check = function(p)

	if p:IsAdmin() then

	p:notify("Access granted to Autonomous Judgement.")

	return true

	else

	p:notify("Access denied to Autonomous Judgement.")

	return false

	end

end

},

{

id = 4186,

check = function(p)

	if not p:IsCP() then

	p:notify("Access granted to rebel HQ")

	return true

	else

	p:notify("Access Denied to rebel HQ")

	return false

	end

end

},

{

id = 5643,

check = function(p)

	if string.match( p:Name(), "SeC" ) or string.match( p:Name(), "OWC" ) or p:IsAdmin() then

	p:notify("Access granted to parasitic canister firing mechanism")

	return true

	else

	p:notify("Access denied to parasitic canister firing mechanism")

	return false

	end

end

},

{

id = 5379,

check = function(p)

	if p:Team() == TEAM_ADMINISTRATOR or p:IsAdmin() then

	p:notify("Access granted to broadcast system")

	return true

	else

	p:notify("Access denied to broadcast system")

	return false

	end

end

}


},
BioZones={

["Zone 1"]={Vector(-1029.761475, 3846.442383, 145.046249),Vector(-477.046478, 2368.791504, 335.014008)},

["Sector 1"]={Vector (1998.702271, 1265.296021, -401.574402), Vector (-1189.226563, -1531.610596, 1464.188477) },

["Sector 2"]={Vector (947.496155, -4532.618164, 30.642742), Vector (-6064.364258, -1272.699829, 880.003357) },

["Sector 3"]={Vector (-2383.459229, 6584.082031, 116.132050), Vector (3921.082031, 1283.224609, 2692.404785) },

["Sector 4"]={Vector (3109.357666, -2182.955078, -54.181992), Vector (940.367981, -6601.234863, 1534.752563) },

["Trainstation"]={Vector (-1162.224854, 3242.571289, 35.870049), Vector (-7875.363281, -1324.983521, 2473.268066) },

["Citadel"]={Vector (3262.474121, -2635.190186, 496.044739), Vector (7398.701172, 990.439880, 7123.252930) },

["Nexus Prison"]={Vector (2123.996338, 942.857727, -186.134094), Vector (6796.709473, -2051.819336, 715.693298) },

["Lower Nexus Armoury"]={Vector (5023.581543, -4433.145996, -523.683838), Vector (1768.775391, -2054.540283, -23.446060) },

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