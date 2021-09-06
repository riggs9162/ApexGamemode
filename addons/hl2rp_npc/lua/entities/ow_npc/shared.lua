ENT.Base = "base_ai" -- This entity is based on "base_ai"

ENT.Type = "ai" -- What type of entity is it, in this case, it's an AI.

ENT.PrintName		= "OW NPC"

ENT.Author			= "Datamats, JamesAMG, TheVingard"

ENT.Contact			= "N/A"

ENT.Purpose			= "ATM Banker"

ENT.Instructions	= "Press E"

ENT.Category 		= "Universal Union"



ENT.AutomaticFrameAdvance = true

ENT.Spawnable = true

ENT.AdminOnly = true



ENT.AutomaticFrameAdvance = true -- This entity will animate itself.





OWRanks = {}

OWDivisions = {}

OWRanks[1] = {

		id = 1,

		name = "OWS",

		description = [[Name: Overwatch Solider

Description:

Overwatch Soldiers comprise most of the OTA forces. They have been
extensively modified with technology and organs from other Combine
races and are completely without empathy or emotions of any kind.
They were once human. Prisoners and volunteers from, the ranks of
the CCA, but they are far from human now.
They have become something new.



(YOU CANNOT GO ROGUE)



]],

		xp = 600

}



OWRanks[2] = {

		id = 2,

		name = "EOW",

		description = [[Name: Overwatch Elite

Description:

EOW are the best of the best. They have undergone further modification
and are human in name only, with very few original components
remaining. A single EOW is easily capable of killing dozens of lesser
beings and they are rightly feared by foe and ally alike.
The Elite of the OTA are death incarnate.

(YOU CANNOT GO ROGUE)



]],

		xp = 1000

}







OWDivisions[1] = {

		id = 1,

		name = "ECHO",

		model = "models/Combine_Soldier.mdl",

		weapons = {},

		description = [[Name: ECHO

Description:

ECHO are the footsoldiers of the OTA. They make up the bulk of the
Universal Union's military forces, and often function in small squads
of two or three units, led by an Elite unit. Mostly, ECHO’s will
Patrol the Combine Highways as well as defending hardpoints
and the Nexus.]],

		max = 40,

		xp = 600

}



OWDivisions[1].weapons[1] = {"weapon_r_handcuffs", "weapon_smg1"}
OWDivisions[1].weapons[2] = {"weapon_r_handcuffs", "weapon_ar2", "weapon_frag"}



OWDivisions[3] = {

		id = 3,

		name = "MACE",

		model = "models/Combine_Soldier.mdl",

		weapons = {},

		description = [[Name: MACE

Description:

The MACE division are OTA trained and augmented to perform in extreme
close quarters. They are specialist units, and often only one will
accompany a squad. MACE are trained to use aggressive tactics, and are
equipped to breach apartment buildings and move in fast.
They may patrol with OTA squads but mainly will remain in the Nexus
unless taking part in a raid or assigned to a squad.
]],

		max = 40,

		xp = 800

}



OWDivisions[3].weapons[1] = {"sight_shotgun", "weapon_r_handcuffs", "breachingcharge"}
OWDivisions[3].weapons[2] = {"sight_shotgun", "weapon_r_handcuffs", "breachingcharge", "weapon_frag"}



OWDivisions[2] = {

		id = 2,

		name = "RANGER",

		model = "models/Combine_Soldier.mdl",

		weapons = {},

		description = [[Name: RANGER

Description:

The RANGER division are OTA trained in the use of sniper rifles and
intended to engage the enemy at long range. They will almost never
accompany a squad and will mostly remain somewhere high, and with
good lines of site. They are often used to safely eliminate high
profile targets and scout areas for other OTA.
]],

		max = 40,

		xp = 800

}



OWDivisions[2].weapons[1] = {"ironsight_pistol", "weapon_r_handcuffs", "grub_combine_sniper"}
OWDivisions[2].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs", "grub_combine_sniper", "weapon_frag"}



OWDivisions[4] = {

		id = 3,

		name = "KING",

		model = "models/Combine_Super_Soldier.mdl",

		weapons = {},

		description = [[Name: KING

Description:

KING are elite OTA, moved from other divisions because of their
exemplary performance. KING are intimidating figures, feared even
by their comrades in the CCA. They are cold, calculating and
brutally efficient. KING are often assigned to lead squads of OTA
or command a Hardpoint on behalf of the OWC.
]],

		max = 40,

		xp = 1000

}



OWDivisions[4].weapons[1] = {"weapon_r_handcuffs", "sight_xr4"}
OWDivisions[4].weapons[2] = {"weapon_r_handcuffs", "sight_xr4", "weapon_frag"}




OWDivisions[5] = {

		id = 5,

		name = "X-RAY",

		model = "models/Combine_Soldier.mdl",

		weapons = {},

		description = [[Name: X-RAY

Description:

X-RAY are OTA field medics, trained in treating transhuman soldiers
for wounds likely to be sustained on the battlefield. They will often
accompany an OTA squad, functioning as a field medic. Like all OTA,
they are completely without empathy, caring only to get their patients
in fighting condition as fast as possible.
]],

		max = 40,

		xp = 1200

}



OWDivisions[5].weapons[1] = {"weapon_medkit", "weapon_r_handcuffs", "weapon_smg1"}
OWDivisions[5].weapons[2] = {"weapon_medkit", "weapon_r_handcuffs", "weapon_frag"}


OWDivisions[6] = {

		id = 6,

		name = "SENTINEL",

		model = "models/Combine_Super_Soldier.mdl",

		weapons = {},

		description = [[Name: SENTINEL

Description:

SENTINEL units are the elite personal bodyguards of
the City Administrator. They answer only to the him, serving his
every need. Whilst they do not care personally for the Administrator,
his safety is the only thing that concerns them. They are always
found close to the CA, never leaving his side.

]],

		max = 40,

		xp = 1300

}

OWDivisions[6].weapons[1] = {"stunstick", "weapon_r_handcuffs", "weapon_ar2"}
OWDivisions[6].weapons[2] = {"stunstick", "weapon_r_handcuffs", "weapon_ar2", "weapon_frag"}

OWDivisions[7] = {

		id = 7,

		name = "NOVA",

		model = "models/combine_soldier_prisonguard.mdl",

		weapons = {},

		description = [[Name: NOVA

Description:

NOVA is charged with guarding, manning and maintaining prisons
of UU facilities. In the detention, they are in charge. And 
when someone escapes, they are at fault.
They are not allowed to leave the nexus even with JW/AJ.

]],

		max = 40,

		xp = 1300

}

OWDivisions[7].weapons[1] = {"stunstick", "weapon_r_handcuffs", "weapon_ar2"}
OWDivisions[7].weapons[2] = {"stunstick", "weapon_r_handcuffs", "weapon_ar2", "weapon_frag"}



--Update

OWDivisions[8] = {

		id = 8,

		name = "OWC",

		model = "models/dpfilms/metropolice/rtb_police.mdl",

		weapons = {"ironsight_357","weapon_ar2", "weapon_r_handcuffs", "weapon_frag"},

		description = [[Name: Overwatch Commander

Description:

The Overwatch Commander is the leader of all OTA forces.
Whilst other OTA are modified for combat exclusively, the OWC
is allowed some free thought, in order to better fulfill their
role as the tactical mastermind of the Universal Unions forces.
The OWC will organise OTA units and will almost always lead
from the front lines.

]],

		xp = 3000

}







function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.

	self.AutomaticFrameAdvance = bUsingAnim

end



-- Since this file is ran by both the client and the server, both will share this information.