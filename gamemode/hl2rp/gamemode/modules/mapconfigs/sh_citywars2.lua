if not maphl2config  then maphl2config = {} end
print("Loaded maphl2config cityruins2 config.")

maphl2config["cityruins2"] = {

Spawn1=Vector(6972.408691, -6870.656738, -2385.342773),

Spawn2=Vector(-7165.147949, 5369.706055, 3146.670898),

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

id =9999,

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

["Somewhere, over the rainbow!"]={Vector(6972.408691, -6870.656738, -2385.342773),Vector(-7165.147949, 5369.706055, 3146.670898)}

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