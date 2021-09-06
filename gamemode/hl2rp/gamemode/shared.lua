/*--------------------------------------------------------
Default teams. If you make a team above the citizen team, people will spawn with that team!
--------------------------------------------------------*/
TEAM_CITIZEN = AddExtraTeam("Citizen", {
	color = Color(20, 150, 20, 255),
	model = { 
		"models/Humans/Group01/Female_01.mdl",
		"models/Humans/Group01/Female_02.mdl",
		"models/Humans/Group01/Female_03.mdl",
		"models/Humans/Group01/Female_04.mdl",
		"models/Humans/Group01/Female_06.mdl",
		"models/Humans/Group01/male_01.mdl",
		"models/Humans/Group01/Male_02.mdl",
		"models/Humans/Group01/male_03.mdl",
		"models/Humans/Group01/Male_04.mdl",
		"models/Humans/Group01/Male_05.mdl",
		"models/Humans/Group01/Male_06.mdl",
		"models/Humans/Group01/Male_07.mdl",
		"models/Humans/Group01/Male_08.mdl",
		"models/Humans/Group01/Male_09.mdl"
	},
	description = [[The lowest class of Universal Union society. 
	They are forced to follow the UU’s dictatorship with absolute 
	obedience, or face punishments and even execution. The UU keeps
	citizens weak and malnourished, and it is all they can do to
	try and survive. However, some brave citizens dare to 
	stand against the UU…]],
	weapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket"},
	command = "citizen",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 0,

                PlayerLoadout = function(ply) ply:SetArmor(0) return true end,
	customCheck = function(ply)
	if SERVER then
		ply:SetDarkRPVar("citopt", 1)
	end
		return true
	end
})

TEAM_CWU = AddExtraTeam("Civil Worker's Union", {
	color = Color(123, 147, 163, 255),
	model = {
		"models/Humans/Group01/female_01.mdl",
		"models/Humans/Group01/Female_02.mdl",
		"models/Humans/Group01/Female_03.mdl",
		"models/Humans/Group01/Female_04.mdl",
		"models/Humans/Group01/Female_06.mdl",
		"models/Humans/Group01/male_01.mdl",
		"models/Humans/Group02/Male_02.mdl",
		"models/Humans/Group01/male_03.mdl",
		"models/Humans/Group02/Male_04.mdl",
		"models/Humans/Group01/Male_05.mdl",
		"models/Humans/Group02/Male_06.mdl",
		"models/Humans/Group01/Male_07.mdl",
		"models/Humans/Group02/Male_08.mdl",
		"models/Humans/Group01/Male_09.mdl"
	},
	description = [[A citizen who has been recruited or signed up
	to work for the UU. CWU receive many benefits, with access to
	better food and medical supplies. Most CWU operate business in 
	the city, selling resources to other citizens in return for 
	tokens, and some may be hired by the City Administrator to work
	for him. Most CWU believe that the goal of the Combine is good
	and do their best to support it.
XP Requirement: 15]],
	weapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket"},
	command = "cwu",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 15,
	PlayerDeath = function(ply, weapon, killer)
		ply:ChangeTeam(GAMEMODE.DefaultTeam, true)
	end,
	customCheck = function(ply)
	if SERVER then
		ply:SetDarkRPVar("citopt", 5)
	end
		return true
	end
})


TEAM_CP = AddExtraTeam("Civil Protection", {
	color = Color(25, 25, 170, 255),
	model = "models/dpfilms/metropolice/hdpolice.mdl",
	description = [[The CPs are the Universal Union’s human police force.
	They are responsible for the enforcement of the UU’s laws, and 
	controlling the population. The CPs consists of multiple divisions, 
	each with a specific role. Many join the CPs in hopes of getting better
	rations, or simply for the power it brings over their fellow citizens.
Max Units: ]]..roundUp(table.Count(player.GetAll())*(2/5)+1)..[[

XP Requirement: 35]],
	weapons = {},
	command = "cp",
	max = 12,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 35,
	PlayerDeath = function(ply, weapon, killer)
		ply:ChangeTeam(GAMEMODE.DefaultTeam, true)
	end
})

TEAM_OVERWATCH = AddExtraTeam("Overwatch Transhuman Arm", {
	color = Color(50, 50, 50, 255),
	model = "models/player/soldier_stripped.mdl",
	description = [[The OTA are the military wing of the Universal Union’s forces.
	They are highly trained and extensively modified super soldiers, far stronger
	than any normal human. They are entirely without fear or emotion of any kind,
	called on to the streets only when circumstances are at their most dire.
	Otherwise, they remain in the Nexus or guarding hardpoints around the city.
	They are completely obedient to their commander, following orders without
	regard to their own safety. Operating in small squads, the OTA are a force
	to be reckoned with, and haunt the dreams of any citizen with common sense.

Max Units: 8
XP Requirement: 600]],
	weapons = {"keys", "pocket"},
	command = "ow",
	max = 12,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 600,
	PlayerDeath = function(ply, weapon, killer)
		ply:ChangeTeam(GAMEMODE.DefaultTeam, true)
	end
})

TEAM_ADMINISTRATOR = AddExtraTeam("City Administrator", {
	color = Color(150, 20, 20, 255),
	model = {
		"models/Humans/suitfem/female_02.mdl",
		"models/taggart/gallahan.mdl"
	},
	description = [[The City Administrator is an unmodified human appointed 
	to run the city by the Universal Union. He has been chosen because of
	his fierce support of and loyalty for the UU. They are given a great deal
	of authority and may override the orders of other commanders,
	such as the SeC and OWC. During a military situation however,
	formal command passes fully to the OWC. Despite this power, his main 
	role is that of propaganda. He will broadcast messages to the citizens
	of the city, ensuring them of their safety and the righteousness of our 
	Benefactors. He spends most of his time in his office, managing the
	piles of paperwork a bustling city produces, 
	and rarely takes to the streets. 
Max: 1
XP Requirement: 3000]],
	weapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket"},
	command = "administrator",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 3000,
	mayor = true,
	PlayerDeath = function(ply, weapon, killer)
		ply:ChangeTeam(GAMEMODE.DefaultTeam, true)
	end

})

TEAM_VORT = AddExtraTeam("Vortigaunt", {
	color = Color(172, 156, 11, 255),
	model = "models/vortigaunt_slave.mdl",
	description = [[A mysterious alien race, enslaved by the Universal Union.
	They are a wise and mainly peaceful race, forced into servitude by other
	races for centuries. Most are treated poorly by the Combine, forced to 
	clean the streets and Nexus. However, once freed they are able to harness
	a mysterious energy, known as the Vortessence, that connects them with
	each other.
XP Requirement: 1200]],
	weapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket"},
	command = "vort",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	candemote = false,
	mayorCanSetSalary = false,
	xp = 1200,
	mayor = false,
                customCheck = function(ply) return 
table.HasValue({"admin", "superadmin", "moderator", "vip", "developer"}, ply:GetNWString("usergroup"))
end,
                CustomCheckFailMsg = "You can only become a Vortigaunt if you donate, type !vip",
                PlayerCanPickupWeapon = function(ply, weapon) return false end,
                PlayerLoadout = function(ply) ply:ChatPrint( "You selected vortigaunt, please roleplay correctly or you will be banned." ) ply:ChatPrint( "Playing as this job requires a high standard of RP." ) ply:ChatPrint( "Do not use your microphone." ) ply:ChatPrint( "Do not change your name." ) ply:ChatPrint( "Feel free to use OOC tools in order to RP properly" ) ply:ChatPrint( "This role cannot pickup weapons." ) return true end,
})

//ADD CUSTOM TEAMS UNDER THIS LINE:









/*
--------------------------------------------------------
HOW TO MAKE A DOOR GROUP
--------------------------------------------------------
AddDoorGroup("NAME OF THE GROUP HERE, you see this when looking at a door", Team1, Team2, team3, team4, etc.)

WARNING: THE DOOR GROUPS HAVE TO BE UNDER THE TEAMS IN SHARED.LUA. IF THEY ARE NOT, IT MIGHT MUCK UP!


The default door groups, can also be used as examples:
*/
AddDoorGroup("Civil Worker's Union", TEAM_CWU, TEAM_CP, TEAM_OVERWATCH, TEAM_ADMINISTRATOR)
AddDoorGroup("Civil Protection", TEAM_CP, TEAM_OVERWATCH, TEAM_ADMINISTRATOR)


GM:AddGroupChat(function(ply) return ply:IsCP() end)
GM:AddGroupChat(TEAM_MOB, TEAM_GANG)


GM.DefaultTeam = TEAM_CITIZEN

GM.CivilProtection = {
	[TEAM_CP] = true,
	[TEAM_OVERWATCH] = true,
	[TEAM_ADMINISTRATOR] = true
}