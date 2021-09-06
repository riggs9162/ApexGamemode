ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "ai" -- What type of entity is it, in this case, it's an AI.
ENT.PrintName		= "CP NPC"
ENT.Author			= "Datamats ~ Re Evaluated By JamesDK"
ENT.Contact			= "N/A"
ENT.Purpose			= "ATM Banker"
ENT.Instructions	= "Press E"
ENT.Category 		= "Universal Union"

ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.AutomaticFrameAdvance = true -- This entity will animate itself.
 

CPRanks = {}
CPDivisions = {}
CPRanks[1] = {
		id = 1,
		name = "RCT",
		description = [[Name: Recruit (RCT)
Description:
Recruits are little more than citizens in a uniform. 
Most recruits are in the process of receiving basic training
and are kept within the bounds of the Nexus at all times, 
unless partnered with another unit.

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 35
}

CPRanks[2] = {
		id = 2,
		name = "05",
		description = [[Name: Ground Unit 05 (05)
Description: 
05’s are the first official rank a CP unit receives. 
They have undergone some basic training but still 
have very little knowledge of CP procedure. 05’s are 
often partnered with other units, from other divisions.

-- You CAN go rogue (With Staff Permission)!! --]],
		xp = 75
}

CPRanks[3] = {
		id = 3,
		name = "04",
		description = [[Name: Ground Unit 04 (04)
Description: 
04’s are the last trainee ranks of the CP. They have almost 
completed basic training, and have a good knowledge of 
CP procedure. 

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 100
}

CPRanks[4] = {
		id = 4,
		name = "03",
		description = [[Name: Ground Unit 03 (03)
Description: 
03’s have completed CP basic training, and are ready to begin
their official duties. They are the first of the frontline CP 
forces and work with other Ground Units to perform their duties. 
They and all higher units are fitted with biosignals.

-- You CAN go rogue (With Staff Permission)! --]],
		xp = 200
}

CPRanks[5] = {
		id = 5,
		name = "02",
		description = [[Name: Ground Unit 02 (02)
Description: 
02’s have been promoted from 03 after proving their competence and 
loyalty to their superiors. 02’s are frequently given training in 
advanced techniques, such as breaching.
-- You CANNOT go rogue! --]],
		xp = 300
}

CPRanks[6] = {
		id = 6,
		name = "01",
		description = [[Name: Ground Unit 01 (01)
Description: 
01’s are Ground Units that have proven themselves completely loyal 
to the Universal Union, and have undergone some basic memory 
replacement, removing negative thoughts about the UU. 
Many of them are promoted in order to prepare them for a 
command position, and frequently undergo leadership training.

-- You CANNOT go rogue! --]],
		xp = 400
}

CPRanks[7] = {
		id = 7,
		name = "OfC",
		description = [[Name: Officer (OfC)
Description: 
OfC’s are CP units that have been chosen to join the high command 
of the CP. They have undergone leadership training and are often 
tasked with commanding small squads of CP officers, and training 
recruits and other low ranked units. They have undergone significant 
memory modification, 
removing almost all negative thoughts about the UU.

-- You CANNOT go rogue! --]],
		xp = 500
}

CPRanks[8] = {
		id = 8,
		name = "EpU",
		description = [[Name: Elite Protection Unit (EpU)
Description: 
EpU’s are Elite Protection Units. They have been promoted as a reward 
for their exceptional service to the Universal Union, and their loyalty 
to the CP is unquestionable. EpU’s are frequently given 
more powerful weaponry and often lead squads of other CP units. 
They also are tasked with giving basic training to recruits.

-- You CANNOT go rogue! --]],
		xp = 600
}

CPRanks[9] = {
		id = 9,
		name = "DvL",
		description = [[Name: Division Leader (DvL)
Description:
The DvL is an exceptional unit, chosen to become the leader 
of a particular division. They are responsible for the activities 
of all units assigned to their division. Often, they will select 
an EpU to act as their second in command and will frequently 
organise training sessions for their own division. 

-- You CANNOT go rogue! --
Max: 1 Per Division]],
		xp = 800,
		max = 1
}

CPDivisions[1] = {
		id = 1,
		name = "UNION",
		model = "models/dpfilms/metropolice/hdpolice.mdl",
		weapons = {},
		description = [[Name: UNION
Description: 
The UNION division is the most common within the CP. Their job 
is to patrol the city and man checkpoints. They will often carry 
out searches of the apartment complex and other buildings. They 
are the frontline of the CP, and all other divisions are designed
to support them.
-- You CAN go rogue (With Staff Permission)! --
]],
		max = 64,
		xp = 35
}
CPDivisions[1].weapons[1] = {"stunstick","door_ram"}
CPDivisions[1].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs"}
CPDivisions[1].weapons[7] = {"weapon_smg1"}

CPDivisions[2] = {
		id = 2,
		name = "HELIX",
		model = "models/dpfilms/metropolice/civil_medic.mdl",
		weapons = {},
		description = [[Name: HELIX
Description: 
The HELIX division is made up of medically trained units and are 
responsible for the general health of the city and the CP. HELIX’s
often use CWU medics as assistants and frequently set up health centres
to treat the injured and unwell. HELIX units are able to provide 
additional medical supplies to those that require them, in exchange for 
tokens. Individual HELIX units often join up with other CP divisions and 
squads in order to function as a field medic.


-- You CANNOT go rogue! --
Max Units: 10]],
		max = 10,
		xp = 60
}

CPDivisions[2].weapons[1] = {"stunstick"}
CPDivisions[2].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs","weapon_medkit"}
CPDivisions[2].weapons[7] = {"door_ram"}


CPDivisions[3] = {
		id = 3,
		name = "GRID",
		model = "models/dpfilms/metropolice/hl2concept.mdl",
		weapons = {},
		description = [[Name: GRID
Description: 
The GRID division are mechanics, responsible for the maintenance of the 
Universal Union’s technology, vehicles and weaponry. GRID units 
also operate scanner drones, which patrol throughout the city and are 
often used for reconnaissance.OCPsionally GRID units will carry out 
vehicular patrols in APCs. The main role of GRID units is to provide 
mechanical and technological support of other divisions.

-- You CANNOT go rogue! --
Max Units: 6]],
		max = 6,
		xp = 100
}

CPDivisions[3].weapons[1] = {"stunstick"}
CPDivisions[3].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs"}
CPDivisions[3].weapons[7] = {"ironsight_smg3","breachingcharge","door_ram"}

CPDivisions[4] = {
		id = 4,
		name = "JURY",
		model = "models/dpfilms/metropolice/policetrench.mdl",
		weapons = {},
		description = [[Name: JURY
Description: 
The JURY division manages the Nexus prison, and is trained to interrogate
captives. Their uniforms are often covered in the blood and viscera of 
their victims and not even their CP comrades are entirely comfortable 
being around them. Every officer is familiar with the screams that come 
from the interrogation rooms, and the cold, brutal efficiency the JURY’s 
operate with. 
One shudders to imagine what inhuman thoughts lurk behind that mask…

-- You CANNOT go rogue! --
Max Units: 4]],
		max = 4,
		xp = 200
}

CPDivisions[4].weapons[1] = {"stunstick"}
CPDivisions[4].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs"}
CPDivisions[4].weapons[7] = {"door_ram"}
CPDivisions[4].weapons[9] = {"sight_shotgun"}

--CPDivisions[5] = {
--		id = 5,
--		name = "RAZOR",
--		model = "models/dpfilms/metropolice/playermodels/pm_urban_police.mdl",
--		weapons = {},
--		description = [[Name: RAZOR
--Description: 
--Razor units are the most elite Civil Protection Ground Units for 
--Close/Medium range combat and are deadly in squads against unarmoured 
--opponents. Razor's primary objectives are to eliminate insurgent 
--(rebel) presence within the districts. Razor Units are however 
--commonly ordered to guard district checkpoints such as the District 6 
--entrance. 

-- You CANNOT go rogue! --
--Max Units: 4]],
--		max = 4,
--		xp = 600
--}	

--CPDivisions[5].weapons[1] = {"stunstick"}
--CPDivisions[5].weapons[2] = {"ironsight_pistol", "weapon_r_handcuffs"}
--CPDivisions[5].weapons[3] = {"weapon_shotgun", "weapon_ar2", "weapon_smg1"}

CPDivisions[5] = {
		id = 5,
		name = "SPEAR",
		model = "models/dpfilms/metropolice/elite_police.mdl",
		weapons = {},
		description = [[Name: SPEAR
Description: 
The SPEAR division is an elite division, tasked with patrolling 404 zones
in small squads and locating rogue units.Members of SPEAR are highly 
trained and hardened by the harsh conditions in the 404 zones they 
patrol and as such are almost entirely fearless, and highly loyal.

-- You CANNOT go rogue! --
Max Units: 2]],
		max = 2,
		xp = 1500
}

CPDivisions[5].weapons[1] = {"weapon_r_handcuffs", "sight_shotgun","door_ram"}

CPDivisions[6] = {
		id = 6,
		name = "CmD",
		model = "models/dpfilms/metropolice/police_bt.mdl",
		weapons = {"stunstick", "ironsight_pistol", "weapon_smg1", "weapon_r_handcuffs","door_ram"},
		description = [[Name: COMMANDER
Description: 
The CmD or Commander is the field commander of the CP forces. He is 
responsible for ensuring the SeC’s instructions are respected and obeyed 
within the CP. When there is no SeC available, he is considered 
leader of the CP. The CmD is the field commander of the CP, and often 
leads raiding parties of CP. The CmD also acts as the Division Leader
of SPEAR, and is responsible for organising patrols of 404 zones. 

-- You CANNOT go rogue! --
Max: 1
]],
		xp = 1500
}

CPDivisions[7] = {
		id = 7,
		name = "SeC",
		model = "models/dpfilms/metropolice/phoenix_police.mdl",
		weapons = {"sight_usp2", "weapon_r_handcuffs"},
		description = [[Name: SECTORAL COMMANDER
Description: 
The Sectoral Commander is the commanding officer of a sectors
CP force. The SeC is considered too important to risk on the
frontline, and as such spends most of the time inside the Nexus.
The SeC has the final say on anything CP related and has undergone
extensive memory replacement and enhancement. He is harder, smarter,
faster and stronger than any other CP unit and is a fearsome 
individual, second only to the City Administrator. 
The SeC is also responsible for many of the advanced training 
programs CP units complete. 

-- You CANNOT go rogue! --
Max: 1
]],
		xp = 2200
}


function ENT:SetAutomaticFrameAdvance( bUsingAnim ) -- This is called by the game to tell the entity if it should animate itself.
	self.AutomaticFrameAdvance = bUsingAnim
end

-- Since this file is ran by both the client and the server, both will share this information.