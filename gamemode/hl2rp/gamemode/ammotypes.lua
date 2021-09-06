-- Pistol ammo type. Used by p228, desert eagle and all other pistols
GM:AddAmmoType("pistol", "9mm ammo", "models/Items/BoxSRounds.mdl", 10, 24, function(ply) return ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 3 and ply:Team() == TEAM_CITIZEN  end)

-- Rifle ammo, usually used by assault rifles
GM:AddAmmoType("smg1", "Rifle ammo", "models/Items/BoxMRounds.mdl", 60, 30, function(ply) return ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 3 and ply:Team() == TEAM_CITIZEN  end)

GM:AddAmmoType("357", ".357 ammo", "models/items/357ammo.mdl" 30, 4, function(ply) return ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 3 and ply:Team() == TEAM_CITIZEN  end)

-- Buckshot ammo, used by the shotguns
GM:AddAmmoType("buckshot", "Shotgun ammo", "models/Items/BoxBuckshot.mdl", 20, 8, function(ply) return ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 3 and ply:Team() == TEAM_CITIZEN  end)