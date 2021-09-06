drunklevel = 0
local puke = 0
local pukeAngle = 0

hook.Add("CalcView", "DrunkVision", function(ply, origin, angle, fov)

	local netdrunklevel = ply:getDarkRPVar( "DrunkLevel")

	if CurTime() - puke < 3 then
		pukeAngle = Lerp( math.min(FrameTime()*3,1), pukeAngle, -25 )
		angle.pitch = angle.pitch - pukeAngle
	elseif CurTime() - puke < 6 then
		pukeAngle = Lerp( math.min(FrameTime()*1.2, 1), pukeAngle, 0 )
		angle.pitch = angle.pitch - pukeAngle
	end

	if !netdrunklevel or LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then return end



	if netdrunklevel < drunklevel then

	drunklevel = math.Approach(drunklevel, netdrunklevel, -0.2)

	else

	drunklevel = math.Approach(drunklevel, netdrunklevel, 0.1)

	end



	if netdrunklevel <= 0 then return end



	local multiplier = 20/100 *drunklevel;

	angle.pitch = angle.pitch + math.cos( RealTime() ) * multiplier;

	angle.roll = angle.roll + math.sin( RealTime() ) * multiplier;


end)

hook.Add("CreateMove", "DrunkWalk", function(move)

	local ply = LocalPlayer();

	if !IsValid(ply) ||drunklevel <= 0 or LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then return end



	local sidemove = math.sin(CurTime())*1.6*drunklevel;

	move:SetSideMove(move:GetSideMove()+sidemove)

end)

net.Receive( "DrunkVomit", function( len, ply )
	puke = CurTime();
	LocalPlayer():DrawViewModel(false)
	timer.Simple( 4.5, function() LocalPlayer():DrawViewModel(true) end )

end )