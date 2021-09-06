util.AddNetworkString( "ClientNotice" )

local meta = FindMetaTable( "Player" )

function meta:notify( message)
	net.Start( "ClientNotice" )
	 net.WriteString( message )
	net.Send( self )
end