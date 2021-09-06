function UnMarkDeath(ply, attacker, dmginfo)
	ply:SetNWBool("Called911",false)
end
hook.Add("DoPlayerDeath", "UnMarkDeaths", UnMarkDeath)