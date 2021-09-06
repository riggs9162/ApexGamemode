FAdmin.StartHooks["Force namechange"] = function()
	FAdmin.Access.AddPrivilege("Force namechange", 2)
	FAdmin.Commands.AddCommand("fname", nil, "<Player>", "[Normal/Silent/Explode/Rocket]")

	FAdmin.ScoreBoard.Player:AddActionButton("Force namechange", "fadmin/icons/ragdoll", Color(73,147,197),
	function(ply) return FAdmin.Access.PlayerHasPrivilege(LocalPlayer(), "Force namechange") end,
	function(ply, button)
		RunConsoleCommand("_FAdmin", "fname", ply:SteamID())
	end)
	FAdmin.ScoreBoard.Main.AddPlayerRightClick("Force namechange", function(ply)
		if ply:IsAdmin() then return end
		RunConsoleCommand("_FAdmin", "fname", ply:SteamID())
	end)
end