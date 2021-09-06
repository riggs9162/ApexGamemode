resource.AddFile( "materials/waypointmarker/wpmarker.vmt" )
resource.AddFile( "materials/waypointmarker/wpmarker.vtf" )
util.AddNetworkString("waypointmarker")
util.AddNetworkString("deathmarker")
util.AddNetworkString("requestmarker")




function CreateWaypoint(ply,args)
if not ply:IsCP() then return false end
		local trace = ply:GetEyeTraceNoCursor()
		if (!trace.Hit) then return end
print(args)
		local strings = {name = ply:Name(), msg = args or false}
		local transmitstring = util.TableToJSON(strings)
		net.Start("waypointmarker")
			net.WriteVector(trace.HitPos)
			net.WriteString(transmitstring)
		net.Broadcast()
ply:notify("Waypoint generated.")
return ""

end


AddChatCommand("/waypoint",CreateWaypoint)


function CreateRequest(ply,args)
if ply:IsCP() or ply:isArrested() or ply:Team() == TEAM_VORT then return end

		local strings = {name = ply:Name(), msg = args or false}
		local transmitstring = util.TableToJSON(strings)
		net.Start("requestmarker")
			net.WriteVector(ply:GetPos())
			net.WriteString(transmitstring)
		net.Broadcast()
ply:notify("Request sent.")
return ""
end


AddChatCommand("/request",CreateRequest)

