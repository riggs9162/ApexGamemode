local LOWERED_ANGLES = Angle(30, -30, -25)
local hl2rp_CVAR_LOWER2 = 0

function GM:CalcViewModelView(weapon, viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)
	if (!IsValid(weapon)) then
		return
	end

	local client = LocalPlayer()
	local value = 0

	if (!client:isWepRaised()) then
		value = 100
	end

	local fraction = (client.hl2rpRaisedFrac or 0) / 100
	local rotation = weapon.LowerAngles or LOWERED_ANGLES
	
	eyeAngles:RotateAroundAxis(eyeAngles:Up(), rotation.p * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Forward(), rotation.y * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Right(), rotation.r * fraction)

	client.hl2rpRaisedFrac = Lerp(FrameTime() * 2, client.hl2rpRaisedFrac or 0, value)

	viewModel:SetAngles(eyeAngles)

	if (weapon.GetViewModelPosition) then
		local position, angles = weapon:GetViewModelPosition(eyePos, eyeAngles)

		oldEyePos = position or oldEyePos
		eyeAngles = angles or eyeAngles
	end
	
	if (weapon.CalcViewModelView) then
		local position, angles = weapon:CalcViewModelView(viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)

		oldEyePos = position or oldEyePos
		eyeAngles = angles or eyeAngles
	end

	return oldEyePos, eyeAngles
end

local KEY_BLACKLIST = IN_ATTACK + IN_ATTACK2

function GM:StartCommand(client, command)
	local weapon = client:GetActiveWeapon()

	if !client:isWepRaised() then
		if (IsValid(weapon) and weapon.FireWhenLowered) then
			return
		end

		command:RemoveKey(KEY_BLACKLIST)
	else
	--	command:AddKey(KEY_BLACKLIST)
	end

end
