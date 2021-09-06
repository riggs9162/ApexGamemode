util.AddNetworkString( "thirdPerson" )

function thirdPerson(ply)

net.Start( "thirdPerson" )
net.WriteBool(true)
net.Send( ply )

end
AddChatCommand("/thirdperson", thirdPerson)

function firstPerson(ply)

net.Start( "thirdPerson" )
net.WriteBool(false)
net.Send( ply )

end
AddChatCommand("/firstperson", firstPerson)

hook.Add("PlayerSpawn","NOCROSSHAIR",function(p)
p:CrosshairDisable()
end)

