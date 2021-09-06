

hl2rp.beepSounds = {}
hl2rp.beepSounds[TEAM_CP] = {
	on = {
		"npc/metropolice/vo/on2.wav"
	},
	off = {
		"npc/metropolice/vo/off1.wav",
		"npc/metropolice/vo/off2.wav",
		"npc/metropolice/vo/off3.wav",
		"npc/metropolice/vo/off4.wav",
		"npc/overwatch/radiovoice/off2.wav",
		"npc/overwatch/radiovoice/off4.wav"

	}
}
hl2rp.beepSounds[TEAM_OVERWATCH] = {
	on = {
		"npc/combine_soldier/vo/on1.wav",
		"npc/combine_soldier/vo/on2.wav"
	},
	off = {
		"npc/combine_soldier/vo/off1.wav",
		"npc/combine_soldier/vo/off2.wav",
		"npc/combine_soldier/vo/off3.wav"
	}
}



voice = {}
voice.list = {}
voice.checks = voice.checks or {}
voice.chatTypes = {}

function voice.defineClass(class, onCheck, onModify, global)
	voice.checks[class] = {class = class:lower(), onCheck = onCheck, onModify = onModify, isGlobal = global}
end

function voice.getClass(client)
	local definitions = {}

	for k, v in pairs(voice.checks) do
		if (v.onCheck(client)) then
			definitions[#definitions + 1] = v
		end
	end

	return definitions
end

function voice.register(class, key, replacement, source, max)
	class = class:lower()
	
	voice.list[class] = voice.list[class] or {}
	voice.list[class][key:lower()] = {replacement = replacement, source = source}
end

function voice.getVoiceList(class, text, delay)
	local info = voice.list[class]

	if (!info) then
		return
	end

	local output = {}
	local original = string.Explode(" ", text)
	local exploded = string.Explode(" ", text:lower())
	local phrase = ""
	local skip = 0
	local current = 0

	max = max or 5

	for k, v in ipairs(exploded) do
		if (k < skip) then
			continue
		end

		if (current < max) then
			local i = k
			local key = v

			local nextValue, nextKey

			while (true) do
				i = i + 1
				nextValue = exploded[i]

				if (!nextValue) then
					break
				end

				nextKey = key.." "..nextValue

				if (!info[nextKey]) then
					i = i + 1

					local nextValue2 = exploded[i]
					local nextKey2 = nextKey.." "..(nextValue2 or "")

					if (!nextValue2 or !info[nextKey2]) then
						i = i - 1

						break
					end

					nextKey = nextKey2
				end

				key = nextKey
			end

			if (info[key]) then
				local source = info[key].source
				
				if (type(source) == "table") then
					source = table.Random(source)
				else
					source = tostring(source)
				end
				
				output[#output + 1] = {source, delay or 0.1}
				phrase = phrase..info[key].replacement.." "
				skip = i
				current = current + 1

				continue
			end
		end

		phrase = phrase..original[k].." "
	end
	
	if (phrase:sub(#phrase, #phrase) == " ") then
		phrase = phrase:sub(1, -2)
	end

	return #output > 0 and output or nil, phrase
end

voice.defineClass("combine", function(client)
	return client:isCombine()
end, function(client, sounds, chatType)
	if (chatType == "dispatch" or client:isCombineRank("SCN")) then
		return false
	end

	local beeps = hl2rp.beepSounds[client:Team()]

	table.insert(sounds, 1, {(table.Random(beeps.on)), 0.25})
	sounds[#sounds + 1] = {(table.Random(beeps.off)), nil, 0.25}
end)

voice.register("combine", "0", "0", "npc/metropolice/vo/zero.wav")
voice.register("combine", "1", "1", "npc/metropolice/vo/one.wav")
voice.register("combine", "10", "10", "npc/metropolice/vo/ten.wav")
voice.register("combine", "/10-0 HUNTING", "10-0, 10-0, viscerator is hunting!", "npc/metropolice/vo/tenzerovisceratorishunting.wav")
voice.register("combine", "/100", "100", "npc/metropolice/vo/onehundred.wav")
voice.register("combine", "/10-103 TAG", "Possible 10-103, my location, alert TAG units.", "npc/metropolice/vo/possible10-103alerttagunits.wav")
voice.register("combine", "/10-107", "I have a 10-107 here, send AirWatch for tag.", "npc/metropolice/vo/gota10-107sendairwatch.wav")
voice.register("combine", "/10-108", "We have a 10-108!", "npc/metropolice/vo/wehavea10-108.wav")
voice.register("combine", "/10-14", "Holding on 10-14 duty, eh, code four.", "npc/metropolice/vo/holdingon10-14duty.wav")
voice.register("combine", "/10-15", "Prepare for 10-15.", "npc/metropolice/vo/preparefor1015.wav")
voice.register("combine", "10-2", "10-2.", "npc/metropolice/vo/ten2.wav")
voice.register("combine", "/10-25", "Any unit, report in with 10-25 as suspect.", "npc/metropolice/vo/unitreportinwith10-25suspect.wav")
voice.register("combine", "/10-30", "I have a 10-30, my 10-20, responding, code two.", "npc/metropolice/vo/Ihave10-30my10-20responding.wav")
voice.register("combine", "10-4", "10-4.", "npc/metropolice/vo/ten4.wav")
voice.register("combine", "/10-65", "Unit is 10-65.", "npc/metropolice/vo/unitis10-65.wav")
voice.register("combine", "/10-78", "Dispatch, I need 10-78, officer in trouble!", "npc/metropolice/vo/dispatchIneed10-78.wav")
voice.register("combine", "/10-8 standing by", "10-8, standing by.", "npc/metropolice/vo/ten8standingby.wav")
voice.register("combine", "/10-8", "Unit is on-duty, 10-8.", "npc/metropolice/vo/unitisonduty10-8.wav")
voice.register("combine", "/10-91D", "10-91d count is...", "npc/metropolice/vo/ten91dcountis.wav")
voice.register("combine", "/10-97 GOA", "10-97, that suspect is GOA.", "npc/metropolice/vo/ten97suspectisgoa.wav")
voice.register("combine", "/10-97", "10-97.", "npc/metropolice/vo/ten97.wav")
voice.register("combine", "/10-99", "Officer down, I am 10-99, I repeat, I am 10-99!", "npc/metropolice/vo/officerdownIam10-99.wav")
voice.register("combine", "/11-44", "Get that 11-44 inbound, we're cleaning up now.", "npc/metropolice/vo/get11-44inboundcleaningup.wav")
voice.register("combine", "/11-6", "Suspect 11-6, my 10-20 is...", "npc/metropolice/vo/suspect11-6my1020is.wav")
voice.register("combine", "/11-99", "11-99, officer needs assistance!", "npc/metropolice/vo/11-99officerneedsassistance.wav")
voice.register("combine", "2", "2", "npc/metropolice/vo/two.wav")
voice.register("combine", "20", "20", "npc/metropolice/vo/twenty.wav")
voice.register("combine", "200", "200", "npc/metropolice/vo/twohundred.wav")
voice.register("combine", "3", "3", "npc/metropolice/vo/three.wav")
voice.register("combine", "30", "30", "npc/metropolice/vo/thirty.wav")
voice.register("combine", "300", "300", "npc/metropolice/vo/threehundred.wav")
voice.register("combine", "/34S AT", "All units, BOL, we have 34-S at...", "npc/metropolice/vo/allunitsbol34sat.wav")
voice.register("combine", "4", "4", "npc/metropolice/vo/four.wav")
voice.register("combine", "40", "40", "npc/metropolice/vo/fourty.wav")
voice.register("combine", "/404", "404 zone.", "npc/metropolice/vo/404zone.wav")
voice.register("combine", "/408", "I've got a 408 here at location.", "npc/metropolice/vo/Ivegot408hereatlocation.wav")
voice.register("combine", "/415B", "Is 415b.", "npc/metropolice/vo/is415b.wav")
voice.register("combine", "5", "5", "npc/metropolice/vo/five.wav")
voice.register("combine", "50", "50", "npc/metropolice/vo/fifty.wav")
voice.register("combine", "/505", "Dispatch, we need AirWatch, subject is 505!", "npc/metropolice/vo/airwatchsubjectis505.wav")
voice.register("combine", "6", "6", "npc/metropolice/vo/six.wav")
voice.register("combine", "60", "60", "npc/metropolice/vo/sixty.wav")
voice.register("combine", "/603", "603, unlawful entry.", "npc/metropolice/vo/unlawfulentry603.wav")
voice.register("combine", "/63", "63, criminal trespass.", "npc/metropolice/vo/criminaltrespass63.wav")
voice.register("combine", "7", "7", "npc/metropolice/vo/seven.wav")
voice.register("combine", "70", "70", "npc/metropolice/vo/seventy.wav")
voice.register("combine", "8", "8", "npc/metropolice/vo/eight.wav")
voice.register("combine", "80", "80", "npc/metropolice/vo/eighty.wav")
voice.register("combine", "9", "9", "npc/metropolice/vo/nine.wav")
voice.register("combine", "90", "90", "npc/metropolice/vo/ninety.wav")
voice.register("combine", "/THAT'S A GRENADE", "That's a grenade!", "npc/metropolice/vo/thatsagrenade.wav")
voice.register("combine", "/ACQUIRING", "Acquiring on visual!", "npc/metropolice/vo/acquiringonvisual.wav")
voice.register("combine", "/ADMINISTER", "Administer.", "npc/metropolice/vo/administer.wav")
voice.register("combine", "/CONFIRMED ADW", "Confirmed as ADW on that suspect, 10-0.", "npc/metropolice/vo/confirmadw.wav")
voice.register("combine", "/AFFIRMATIVE", "Affirmative.", "npc/metropolice/vo/affirmative.wav")
voice.register("combine", "/ALL UNITS MOVE", "All units, move in!", "npc/metropolice/vo/allunitsmovein.wav")
voice.register("combine", "/AMPUTATE", "Amputate.", "npc/metropolice/vo/amputate.wav")
voice.register("combine", "/ANTICITIZEN", "Anti-citizen.", "npc/metropolice/vo/anticitizen.wav")
voice.register("combine", "/ANTISEPTIC", "Antiseptic.", "npc/combine_soldier/vo/antiseptic.wav")
voice.register("combine", "/APEX", "Apex.", "npc/combine_soldier/vo/apex.wav")
voice.register("combine", "APPLY", "Apply.", "npc/metropolice/vo/apply.wav")
voice.register("combine", "/ARREST POSITIONS", "All units, move to arrest positions!", "npc/metropolice/vo/movetoarrestpositions.wav")
voice.register("combine", "/AT CHECKPOINT", "At checkpoint.", "npc/metropolice/vo/atcheckpoint.wav")
voice.register("combine", "/AT LOCATION REPORT", "Protection-teams at location, report in.", "npc/metropolice/vo/ptatlocationreport.wav")
voice.register("combine", "/BACK ME UP", "Back me up, I'm out!", "npc/metropolice/vo/backmeupImout.wav")
voice.register("combine", "/BACKUP", "Backup!", "npc/metropolice/vo/backup.wav")
voice.register("combine", "/BLADE", "Blade.", "npc/combine_soldier/vo/blade.wav")
voice.register("combine", "/BLEEDING", "Suspect is bleeding from multiple wounds!", "npc/metropolice/vo/suspectisbleeding.wav")
voice.register("combine", "/BLIP", "Catch that blip on the stabilization readout?", "npc/metropolice/vo/catchthatbliponstabilization.wav")
voice.register("combine", "/BLOCK HOLDING", "Block is holding, cohesive.", "npc/metropolice/vo/blockisholdingcohesive.wav")
voice.register("combine", "/BLOCK", "Block!", "npc/metropolice/vo/block.wav")
voice.register("combine", "/BOL 243", "CP, we need AirWatch to BOL for that 243.", "npc/metropolice/vo/cpbolforthat243.wav")
voice.register("combine", "/BOOMER", "Boomer.", "npc/combine_soldier/vo/boomer.wav")
voice.register("combine", "/BREAK COVER", "Break his cover!", "npc/metropolice/vo/breakhiscover.wav")
voice.register("combine", "/CAN1", "Pick up that can.", "npc/metropolice/vo/pickupthecan1.wav")
voice.register("combine", "/CAN2", "Pick up the can!", "npc/metropolice/vo/pickupthecan2.wav")
voice.register("combine", "/CAN3", "I said, pick up the can!", "npc/metropolice/vo/pickupthecan3.wav")
voice.register("combine", "/CAN4", "Now, put it in the trash-can.", "npc/metropolice/vo/putitinthetrash1.wav")
voice.register("combine", "/CAN5", "I said, put it in the trash-can!", "npc/metropolice/vo/putitinthetrash2.wav")
voice.register("combine", "/CAN6", "You knocked it over, pick it up!", "npc/metropolice/vo/youknockeditover.wav")
voice.register("combine", "/CANAL", "Canal.", "npc/metropolice/vo/canal.wav")
voice.register("combine", "/CANALBLOCK", "Canalblock!", "npc/metropolice/vo/canalblock.wav")
voice.register("combine", "/CAUTERIZE", "Cauterize.", "npc/metropolice/vo/cauterize.wav")
voice.register("combine", "/CHECK MISCOUNT", "Check for miscount.", "npc/metropolice/vo/checkformiscount.wav")
voice.register("combine", "/CHECKPOINTS", "Proceed to designated checkpoints.", "npc/metropolice/vo/proceedtocheckpoints.wav")
voice.register("combine", "/CITIZENSUMMONED", "Reporting citizen summoned into voluntary conscription for channel open service detail T94-332.", "npc/metropolice/vo/citizensummoned.wav")
voice.register("combine", "CITIZEN", "Citizen.", "npc/metropolice/vo/citizen.wav")
voice.register("combine", "/CLASSIFY DB", "Classify subject name as 'DB'; this block ready for clean-out.", "npc/metropolice/vo/classifyasdbthisblockready.wav")
voice.register("combine", "/CLEANED", "Cleaned.", "npc/combine_soldier/vo/cleaned.wav")
voice.register("combine", "/CLEAR CODE 100", "Clear and code one-hundred.", "npc/metropolice/vo/clearandcode100.wav")
voice.register("combine", "/CLOSE ON SUSPECT", "All units, close on suspect!", "npc/metropolice/vo/allunitscloseonsuspect.wav")
voice.register("combine", "/CLOSING", "Closing!", {"npc/combine_soldier/vo/closing.wav", "npc/combine_soldier/vo/closing2.wav"})
voice.register("combine", "/CODE 100", "Code one-hundred.", "npc/metropolice/vo/code100.wav")
voice.register("combine", "/CODE 2", "All units, code two!", "npc/metropolice/vo/allunitscode2.wav")
voice.register("combine", "/CODE 3", "Officer down, request all units, code three to my 10-20!", "npc/metropolice/vo/officerdowncode3tomy10-20.wav")
voice.register("combine", "/CODE 7", "Code seven.", "npc/metropolice/vo/code7.wav")
voice.register("combine", "/CONDEMNED", "Condemned zone!", "npc/metropolice/vo/condemnedzone.wav")
voice.register("combine", "/CONTACT 243", "Contact with 243 suspect, my 10-20 is...", "npc/metropolice/vo/contactwith243suspect.wav")
voice.register("combine", "/CONTACT PRIORITY", "I have contact with a priority two!", "npc/metropolice/vo/contactwithpriority2.wav")
voice.register("combine", "/CONTACT", "Contact!", "npc/combine_soldier/vo/contact.wav")
voice.register("combine", "/CONTAINED", "Contained.", "npc/combine_soldier/vo/contained.wav")
voice.register("combine", "/CONTROL 100", "Control is one-hundred percent this location, no sign of that 647-E.", "npc/metropolice/vo/control100percent.wav")
voice.register("combine", "/CONTROLSECTION", "Control-section!", "npc/metropolice/vo/controlsection.wav")
voice.register("combine", "/CONVERGING", "Converging.", "npc/metropolice/vo/converging.wav")
voice.register("combine", "/COPY THAT", "Copy that.", "npc/combine_soldier/vo/copythat.wav")
voice.register("combine", "/COPY", "Copy.", "npc/metropolice/vo/copy.wav")
voice.register("combine", "/COVER", "Cover!", "npc/combine_soldier/vo/coverhurt.wav")
voice.register("combine", "/CPCOMPROMISED", "CP is compromised, re-establish!", "npc/metropolice/vo/cpiscompromised.wav")
voice.register("combine", "/CPESTABLISH", "CP, we need to establish our perimeter at...", "npc/metropolice/vo/cpweneedtoestablishaperimeterat.wav")
voice.register("combine", "/CPOVERRUN", "CP is overrun, we have no containment!", "npc/metropolice/vo/cpisoverrunwehavenocontainment.wav")
voice.register("combine", "/DAGGER", "Dagger.", "npc/combine_soldier/vo/dagger.wav")
voice.register("combine", "/DASH", "Dash.", "npc/combine_soldier/vo/dash.wav")
voice.register("combine", "/DB COUNT", "DB count is...", "npc/metropolice/vo/dbcountis.wav")
voice.register("combine", "/DEFENDER", "Defender!", "npc/metropolice/vo/defender.wav")
voice.register("combine", "/DESERVICED AREA", "Deserviced area.", "npc/metropolice/vo/deservicedarea.wav")
voice.register("combine", "/DESIGNATE SUSPECT", "Designate suspect as...", "npc/metropolice/vo/designatesuspectas.wav")
voice.register("combine", "/DESTROY COVER", "Destroy that cover!", "npc/metropolice/vo/destroythatcover.wav")
voice.register("combine", "/DISLOCATE INTERPOSE", "Fire to dislocate that interpose!", "npc/metropolice/vo/firetodislocateinterpose.wav")
voice.register("combine", "/DISMOUNTING HARDPOINT", "Dismounting hardpoint.", "npc/metropolice/vo/dismountinghardpoint.wav")
voice.register("combine", "/DISP APB", "Disp updating APB likeness.", "npc/metropolice/vo/dispupdatingapb.wav")
voice.register("combine", "/DISTRIBUTION BLOCK", "Distribution block.", "npc/metropolice/vo/distributionblock.wav")
voice.register("combine", "/DOCUMENT", "Document.", "npc/metropolice/vo/document.wav")
voice.register("combine", "/DONT MOVE", "Don't move!", "npc/metropolice/vo/dontmove.wav")
voice.register("combine", "/ECHO", "Echo.", "npc/combine_soldier/vo/echo.wav")
voice.register("combine", "/ENGAGING", "Engaging!", "npc/combine_soldier/vo/engaging.wav")
voice.register("combine", "/ESTABLISH NEW CP", "Fall down, establish a new CP!", "npc/metropolice/vo/establishnewcp.wav")
voice.register("combine", "/EXPOSE TARGET", "Firing to expose target!", "npc/metropolice/vo/firingtoexposetarget.wav")
voice.register("combine", "/EXTERNAL", "External jurisdiction.", "npc/metropolice/vo/externaljurisdiction.wav")
voice.register("combine", "/FINAL VERDICT", "Final verdict administered.", "npc/metropolice/vo/finalverdictadministered.wav")
voice.register("combine", "/FINAL WARNING", "Final warning!", "npc/metropolice/vo/finalwarning.wav")
voice.register("combine", "/FIRST WARNING", "First warning, move away!", "npc/metropolice/vo/firstwarningmove.wav")
voice.register("combine", "/FIST", "Fist.", "npc/combine_soldier/vo/fist.wav")
voice.register("combine", "/FLASH", "Flash.", "npc/combine_soldier/vo/flash.wav")
voice.register("combine", "/FLATLINE", "Flatline.", "npc/combine_soldier/vo/flatline.wav")
voice.register("combine", "/FLUSH", "Flush.", "npc/combine_soldier/vo/flush.wav")
voice.register("combine", "/FREE NECROTICS", "I have free necrotics!", "npc/metropolice/vo/freenecrotics.wav")
voice.register("combine", "/GET DOWN", "Get down!", "npc/metropolice/vo/getdown.wav")
voice.register("combine", "/GET OUT", "Get out of here!", "npc/metropolice/vo/getoutofhere.wav")
voice.register("combine", "/GETTING 647E", "Still getting that 647-E from local surveillance.", "npc/metropolice/vo/stillgetting647e.wav")
voice.register("combine", "/GHOST", "Ghost.", "npc/combine_soldier/vo/ghost.wav")
voice.register("combine", "/GO AGAIN", "PT, go again.", "npc/metropolice/vo/ptgoagain.wav")
voice.register("combine", "/GO SHARP", "Go sharp!", "npc/combine_soldier/vo/gosharp.wav")
voice.register("combine", "/GOING IN", "Cover me, I'm going in!", "npc/metropolice/vo/covermegoingin.wav")
voice.register("combine", "/GOT A DB", "Uh, we got a DB here, cancel that 11-42.", "npc/metropolice/vo/wegotadbherecancel10-102.wav")
voice.register("combine", "/GOT HIM AGAIN", "Got him again, suspect is 10-20 at...", "npc/metropolice/vo/gothimagainsuspect10-20at.wav")
voice.register("combine", "/GOT ONE ACCOMPLICE", "I got one accomplice here!", "npc/metropolice/vo/gotoneaccompliceherea.wav")
voice.register("combine", "/GOT SUSPECT ONE", "I got suspect one here!", "npc/metropolice/vo/gotsuspect1here.wav")
voice.register("combine", "/GRENADE", "Grenade!", "npc/metropolice/vo/grenade.wav")
voice.register("combine", "/GRID", "Grid.", "npc/combine_soldier/vo/grid.wav")
voice.register("combine", "/HAHA", "Haha.", "npc/metropolice/vo/chuckle.wav")
voice.register("combine", "/HAMMER", "Hammer.", "npc/combine_soldier/vo/hammer.wav")
voice.register("combine", "/HARDPOINT PROSECUTE", "Is at hardpoint, ready to prosecute!", "npc/metropolice/vo/isathardpointreadytoprosecute.wav")
voice.register("combine", "/HARDPOINT SCANNING", "Hardpoint scanning.", "npc/metropolice/vo/hardpointscanning.wav")
voice.register("combine", "/HELIX", "Helix.", "npc/combine_soldier/vo/helix.wav")
voice.register("combine", "/HELP", "Help!", "npc/metropolice/vo/help.wav")
voice.register("combine", "/HERO", "Hero!", "npc/metropolice/vo/hero.wav")
voice.register("combine", "/HES 148", "He's gone 148!", "npc/metropolice/vo/hesgone148.wav")
voice.register("combine", "/HIGH PRIORITY", "High-priority region.", "npc/metropolice/vo/highpriorityregion.wav")
voice.register("combine", "/HOLD IT", "Hold it right there!", "npc/metropolice/vo/holditrightthere.wav")
voice.register("combine", "/HOLD POSITION", "Protection-team, hold this position.", "npc/metropolice/vo/holdthisposition.wav")
voice.register("combine", "/HOLD", "Hold it!", "npc/metropolice/vo/holdit.wav")
voice.register("combine", "/HUNTER", "Hunter.", "npc/combine_soldier/vo/hunter.wav")
voice.register("combine", "/HURRICANE", "Hurricane.", "npc/combine_soldier/vo/hurricane.wav")
voice.register("combine", "/I SAID MOVE", "I said move along.", "npc/metropolice/vo/Isaidmovealong.wav")
voice.register("combine", "/ICE", "Ice.", "npc/combine_soldier/vo/ice.wav")
voice.register("combine", "/IN POSITION", "In position.", "npc/metropolice/vo/inposition.wav")
voice.register("combine", "/INBOUND", "Inbound.", "npc/combine_soldier/vo/inbound.wav")
voice.register("combine", "/INFECTED", "Infected.", "npc/combine_soldier/vo/infected.wav")
voice.register("combine", "/INFECTION", "Infection!", "npc/metropolice/vo/infection.wav")
voice.register("combine", "/INFESTED", "Infested zone.", "npc/metropolice/vo/infestedzone.wav")
voice.register("combine", "/INJECT", "Inject!", "npc/metropolice/vo/inject.wav")
voice.register("combine", "/INOCULATE", "Inoculate.", "npc/metropolice/vo/innoculate.wav")
voice.register("combine", "/INTERCEDE", "Intercede!", "npc/metropolice/vo/intercede.wav")
voice.register("combine", "/INTERLOCK", "Interlock!", "npc/metropolice/vo/interlock.wav")
voice.register("combine", "/INVESTIGATE", "Investigate.", "npc/metropolice/vo/investigate.wav")
voice.register("combine", "/INVESTIGATING", "Investigating 10-103.", "npc/metropolice/vo/investigating10-103.wav")
voice.register("combine", "/ION", "Ion.", "npc/combine_soldier/vo/ion.wav")
voice.register("combine", "/IS 10-108", "Is 10-108!", "npc/metropolice/vo/is10-108.wav")
voice.register("combine", "/IS 10-8", "Unit is 10-8, standing by.", "npc/metropolice/vo/unitis10-8standingby.wav")
voice.register("combine", "/IS CLOSING", "Is closing on suspect!", "npc/metropolice/vo/isclosingonsuspect.wav")
voice.register("combine", "/IS DOWN", "Is down!", "npc/metropolice/vo/isdown.wav")
voice.register("combine", "/IS INBOUND", "Unit is inbound.", "npc/combine_soldier/vo/unitisinbound.wav")
voice.register("combine", "/IS MOVING IN", "Unit is moving in.", "npc/combine_soldier/vo/unitismovingin.wav")
voice.register("combine", "/IS MOVING", "Is moving in!", "npc/metropolice/vo/ismovingin.wav")
voice.register("combine", "/IS PASSIVE", "Is passive.", "npc/metropolice/vo/ispassive.wav")
voice.register("combine", "/IS READY TO GO", "Is ready to go!", "npc/metropolice/vo/isreadytogo.wav")
voice.register("combine", "/ISOLATE", "Isolate!", "npc/metropolice/vo/isolate.wav")
voice.register("combine", "/JET", "Jet.", "npc/combine_soldier/vo/jet.wav")
voice.register("combine", "/JUDGE", "Judge!", "npc/combine_soldier/vo/judge.wav")
voice.register("combine", "/JUDGE", "Judge.", "npc/combine_soldier/vo/judge.wav")
voice.register("combine", "/JUDGMENT", "Suspect, prepare to receive civil judgment!", "npc/metropolice/vo/prepareforjudgement.wav")
voice.register("combine", "/JURISDICTION", "Stabilization-jurisdiction.", "npc/metropolice/vo/stabilizationjurisdiction.wav")
voice.register("combine", "/JURY", "Jury!", "npc/metropolice/vo/jury.wav")
voice.register("combine", "/KEEP MOVING", "Keep moving!", "npc/metropolice/vo/keepmoving.wav")
voice.register("combine", "/KILO", "Kilo.", "npc/combine_soldier/vo/kilo.wav")
voice.register("combine", "/KING", "King!", "npc/metropolice/vo/king.wav")
voice.register("combine", "/LAST SEEN AT", "Hiding, last seen at range...", "npc/metropolice/vo/hidinglastseenatrange.wav")
voice.register("combine", "/LEADER", "Leader.", "npc/combine_soldier/vo/leader.wav")
voice.register("combine", "/LEVEL 3", "I have a level three civil-privacy violator here!", "npc/metropolice/vo/level3civilprivacyviolator.wav")
voice.register("combine", "/LINE", "Line!", "npc/metropolice/vo/line.wav")
voice.register("combine", "/LOCATION", "Location?", "npc/metropolice/vo/location.wav")
voice.register("combine", "/LOCK POSITION", "All units, lock your position!", "npc/metropolice/vo/lockyourposition.wav")
voice.register("combine", "/LOCK", "Lock!", "npc/metropolice/vo/lock.wav")
voice.register("combine", "/LOOK OUT", "Look out!", "npc/metropolice/vo/lookout.wav")
voice.register("combine", "/LOOSE PARASITICS", "Loose parasitics!", "npc/metropolice/vo/looseparasitics.wav")
voice.register("combine", "/LOST CONTACT", "Lost contact!", "npc/combine_soldier/vo/lostcontact.wav")
voice.register("combine", "/LOW ON", "Running low on verdicts, taking cover!", "npc/metropolice/vo/runninglowonverdicts.wav")
voice.register("combine", "/MACE", "Mace.", "npc/combine_soldier/vo/mace.wav")
voice.register("combine", "/MAINTAIN CP", "All units, maintain this CP!", "npc/metropolice/vo/allunitsmaintainthiscp.wav")
voice.register("combine", "/MALCOMPLIANCE", "Issuing malcompliance citation.", "npc/metropolice/vo/issuingmalcompliantcitation.wav")
voice.register("combine", "/MALCOMPLIANT 10-107", "Malcompliant 10-107 at my 10-20, preparing to prosecute.", "npc/metropolice/vo/malcompliant10107my1020.wav")
voice.register("combine", "/MALIGNANT", "Malignant!", "npc/metropolice/vo/malignant.wav")
voice.register("combine", "/MATCH ON APB", "I have a match on APB likeness.", "npc/metropolice/vo/matchonapblikeness.wav")
voice.register("combine", "/MINOR HITS", "Minor hits, continuing prosecution!", "npc/metropolice/vo/minorhitscontinuing.wav")
voice.register("combine", "/MOVE ALONG", "Move along!", "npc/metropolice/vo/movealong.wav")
voice.register("combine", "/MOVE BACK", "Move back, right now!", "npc/metropolice/vo/movebackrightnow.wav")
voice.register("combine", "/MOVE IN", "Move in!", "npc/combine_soldier/vo/movein.wav")
voice.register("combine", "/MOVE IT", "Move it!", "npc/metropolice/vo/moveit.wav")
voice.register("combine", "/MOVE", "Move!", "npc/metropolice/vo/move.wav")
voice.register("combine", "/MOVING TO COVER", "Moving to cover!", "npc/metropolice/vo/movingtocover.wav")
voice.register("combine", "/MOVING TO HARDPOINT", "Moving to hardpoint!", "npc/metropolice/vo/movingtohardpoint.wav")
voice.register("combine", "/NECROTICS", "Necrotics!", "npc/metropolice/vo/necrotics.wav")
voice.register("combine", "/NEED ANY HELP", "Need any help with this one?", "npc/metropolice/vo/needanyhelpwiththisone.wav")
voice.register("combine", "/NEEDS ASSISTANCE", "Officer needs assistance, I am 11-99!", "npc/metropolice/vo/officerneedsassistance.wav")
voice.register("combine", "/NEEDS HELP", "Officer needs help!", "npc/metropolice/vo/officerneedshelp.wav")
voice.register("combine", "/NO 647", "Clear, no 647, no 10-107.", "npc/metropolice/vo/clearno647no10-107.wav")
voice.register("combine", "/NO CONTACT", "No contact!", "npc/metropolice/vo/nocontact.wav")
voice.register("combine", "/NO I'M GOOD", "No, I'm good.", "vo/trainyard/ba_noimgood.wav")
voice.register("combine", "/NO VISUAL ON", "No visual on UPI at this time.", "npc/metropolice/vo/novisualonupi.wav")
voice.register("combine", "/NOMAD", "Nomad.", "npc/combine_soldier/vo/nomad.wav")
voice.register("combine", "/NONCITIZEN", "Noncitizen.", "npc/metropolice/vo/noncitizen.wav")
voice.register("combine", "/NONPATROL", "Non-patrol region.", "npc/metropolice/vo/nonpatrolregion.wav")
voice.register("combine", "/NONTAGGED VIROMES", "Non-tagged viromes here!", "npc/metropolice/vo/non-taggedviromeshere.wav")
voice.register("combine", "/NOVA", "Nova.", "npc/combine_soldier/vo/nova.wav")
voice.register("combine", "/NOW GET OUT", "Now, get out of here!", "npc/metropolice/vo/nowgetoutofhere.wav")
voice.register("combine", "/NOW", "Now.", "vo/trainyard/ba_thatbeer01.wav")
voice.register("combine", "/OUTBREAK", "Outbreak!", "npc/combine_soldier/vo/outbreak.wav")
voice.register("combine", "/OUTBREAK", "Outbreak!", "npc/metropolice/vo/outbreak.wav")
voice.register("combine", "/OVERWATCH", "Overwatch.", "npc/combine_soldier/vo/overwatch.wav")
voice.register("combine", "/PACIFYING", "Pacifying!", "npc/metropolice/vo/pacifying.wav")
voice.register("combine", "/PAIN1", "Ugh!", "npc/metropolice/pain1.wav")
voice.register("combine", "/PAIN2", "Uagh!", "npc/metropolice/pain2.wav")
voice.register("combine", "/PAIN3", "Augh!", "npc/metropolice/pain3.wav")
voice.register("combine", "/PAIN4", "Agh!", "npc/metropolice/pain4.wav")
voice.register("combine", "/PATROL", "Patrol!", "npc/metropolice/vo/patrol.wav")
voice.register("combine", "/PAYBACK", "Payback.", "npc/combine_soldier/vo/payback.wav")
voice.register("combine", "/PHANTOM", "Phantom.", "npc/combine_soldier/vo/phantom.wav")
voice.register("combine", "/PICKUP 647E", "Anyone else pick up a, uh... 647-E reading?", "npc/metropolice/vo/anyonepickup647e.wav")
voice.register("combine", "/POSITION AT HARDPOINT", "In position at hardpoint.", "npc/metropolice/vo/inpositionathardpoint.wav")
voice.register("combine", "/POSITION TO CONTAIN", "Position to contain.", "npc/metropolice/vo/positiontocontain.wav")
voice.register("combine", "/POSSIBLE 404", "Possible 404 here!", "npc/metropolice/vo/possible404here.wav")
voice.register("combine", "/POSSIBLE 647E", "Possible 647-E here, request AirWatch tag.", "npc/metropolice/vo/possible647erequestairwatch.wav")
voice.register("combine", "/POSSIBLE ACCOMPLICE", "Report sightings of possible accomplice.", "npc/metropolice/vo/reportsightingsaccomplices.wav")
voice.register("combine", "/POSSIBLE LEVEL 3", "Possible level three civil-privacy violator here!", "npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav")
voice.register("combine", "/PREPARING TO JUDGE", "Preparing to judge a 10-107, be advised.", "npc/metropolice/vo/preparingtojudge10-107.wav")
voice.register("combine", "/PRESERVE", "Preserve!", "npc/metropolice/vo/preserve.wav")
voice.register("combine", "/PRESSURE", "Pressure!", "npc/metropolice/vo/pressure.wav")
voice.register("combine", "/PRIORITY 1", "Confirm, priority-one sighted.", "npc/metropolice/vo/confirmpriority1sighted.wav")
voice.register("combine", "/PRIORITY 2", "I have a priority-two anti-citizen here!", "npc/metropolice/vo/priority2anticitizenhere.wav")
voice.register("combine", "/PRODUCTION BLOCK", "Production-block.", "npc/metropolice/vo/productionblock.wav")
voice.register("combine", "/PROSECUTE MALCOMPLIANT", "Ready to prosecute malcompliant citizen, final warning issued!", "npc/metropolice/vo/readytoprosecutefinalwarning.wav")
voice.register("combine", "/PROSECUTE", "Prosecute!", "npc/metropolice/vo/prosecute.wav")
voice.register("combine", "/PROSECUTING", "Prosecuting.", "npc/combine_soldier/vo/procecuting.")
voice.register("combine", "/PROTECTION COMPLETE", "Protection complete.", "npc/metropolice/vo/protectioncomplete.wav")
voice.register("combine", "/QUICK", "Quick!", "npc/metropolice/vo/quick.wav")
voice.register("combine", "/QUICKSAND", "Quicksand.", "npc/combine_soldier/vo/quicksand.wav")
voice.register("combine", "/RANGE", "Range.", "npc/combine_soldier/vo/range.wav")
voice.register("combine", "/RANGER", "Ranger.", "npc/combine_soldier/vo/ranger.wav")
voice.register("combine", "/RAZOR", "Razor.", "npc/combine_soldier/vo/razor.wav")
voice.register("combine", "/READY AMPUTATE", "Ready to amputate!", "npc/metropolice/vo/readytoamputate.wav")
voice.register("combine", "/READY CHARGES", "Ready charges!", "npc/combine_soldier/vo/readycharges.wav")
voice.register("combine", "/READY JUDGE", "Ready to judge.", "npc/metropolice/vo/readytojudge.wav")
voice.register("combine", "/READY PROSECUTE", "Ready to prosecute!", "npc/metropolice/vo/readytoprosecute.wav")
voice.register("combine", "/READY WEAPONS", "Ready weapons!", "npc/combine_soldier/vo/readyweapons.wav")
voice.register("combine", "/REAPER", "Reaper.", "npc/combine_soldier/vo/reaper.wav")
voice.register("combine", "/REINFORCEMENT TEAMS", "Reinforcement-teams, code three!", "npc/metropolice/vo/reinforcementteamscode3.wav")
voice.register("combine", "/REPORT CLEAR", "Reporting clear.", "npc/combine_soldier/vo/reportingclear.wav")
voice.register("combine", "/REPORT IN", "CP requests all units, uhh... Location report-in.", "npc/metropolice/vo/cprequestsallunitsreportin.wav")
voice.register("combine", "/REPORT LOCATION", "All units, report location suspect!", "npc/metropolice/vo/allunitsreportlocationsuspect.wav")
voice.register("combine", "/REPORT STATUS", "Local CP-teams, report status.", "npc/metropolice/vo/localcptreportstatus.wav")
voice.register("combine", "/REPURPOSED", "Repurposed area.", "npc/metropolice/vo/repurposedarea.wav")
voice.register("combine", "/RESIDENTIAL BLOCK", "Residential block.", "npc/metropolice/vo/residentialblock.wav")
voice.register("combine", "/RESPOND CODE 3", "All units at location, responding code three!", "npc/metropolice/vo/allunitsrespondcode3.wav")
voice.register("combine", "/RESPONDING", "Responding.", "npc/metropolice/vo/responding2.wav")
voice.register("combine", "/RESTRICT", "Restrict!", "npc/metropolice/vo/restrict.wav")
voice.register("combine", "/RESTRICTED", "Restricted block.", "npc/metropolice/vo/restrictedblock.wav")
voice.register("combine", "/RESTRICTION ZONE", "Terminal restriction-zone!", "npc/metropolice/vo/terminalrestrictionzone.wav")
voice.register("combine", "/RIPCORD", "Ripcord!", "npc/combine_soldier/vo/ripcord.wav")
voice.register("combine", "/RODGER THAT", "Rodger that!", "npc/metropolice/vo/rodgerthat.wav")
voice.register("combine", "/ROLLER", "Roller!", "npc/metropolice/vo/roller.wav")
voice.register("combine", "/RUNNING", "He's running!", "npc/metropolice/vo/hesrunning.wav")
voice.register("combine", "/SACRIFICE CODE", "All units, sacrifice code one and maintain this CP!", "npc/metropolice/vo/sacrificecode1maintaincp.wav")
voice.register("combine", "/SAVAGE", "Savage.", "npc/combine_soldier/vo/savage.wav")
voice.register("combine", "/SCAR", "Scar.", "npc/combine_soldier/vo/scar.wav")
voice.register("combine", "/SEARCH", "Search!", "npc/metropolice/vo/search.wav")
voice.register("combine", "/SEARCHING FOR SUSPECT", "Searching for suspect.", "npc/metropolice/vo/searchingforsuspect.wav")
voice.register("combine", "/SECOND WARNING", "This is your second warning!", "npc/metropolice/vo/thisisyoursecondwarning.wav")
voice.register("combine", "/SECTOR NOT STERILE", "Confirmed- sector not sterile.", "npc/combine_soldier/vo/confirmsectornotsterile.wav")
voice.register("combine", "/SECTOR NOT SECURE", "Sector is not secure.", "npc/combine_soldier/vo/sectorisnotsecure.wav")
voice.register("combine", "/SECURE ADVANCE", "Assault-point secured, advance!", "npc/metropolice/vo/assaultpointsecureadvance.wav")
voice.register("combine", "/SECURE", "Secure.", "npc/combine_soldier/vo/secure.wav")
voice.register("combine", "/SENTENCE", "Sentence delivered.", "npc/metropolice/vo/sentencedelivered.wav")
voice.register("combine", "/SERVE", "Serve.", "npc/metropolice/vo/serve.wav")
voice.register("combine", "/SHADOW", "Shadow.", "npc/combine_soldier/vo/shadow.wav")
voice.register("combine", "/SHARPZONE", "Sharpzone.", "npc/combine_soldier/vo/sharpzone.wav")
voice.register("combine", "/SHIT", "Shit!", "npc/metropolice/vo/shit.wav")
voice.register("combine", "/SHOTS FIRED", "Shots fired, hostile malignants here!", "npc/metropolice/vo/shotsfiredhostilemalignants.wav")
voice.register("combine", "/SLAM", "Slam.", "npc/combine_soldier/vo/slam.wav")
voice.register("combine", "/SLASH", "Slash.", "npc/combine_soldier/vo/slash.wav")
voice.register("combine", "/SOCIOCIDE", "Sociocide.", "npc/metropolice/vo/sociocide.wav")
voice.register("combine", "/SOCIOSTABLE", "We are socio-stable at this location.", "npc/metropolice/vo/wearesociostablethislocation.wav")
voice.register("combine", "/SPEAR", "Spear.", "npc/combine_soldier/vo/spear.wav")
voice.register("combine", "/STAB", "Stab.", "npc/combine_soldier/vo/stab.wav")
voice.register("combine", "/STANDING BY", "Standing by.", "npc/combine_soldier/vo/standingby].wav")
voice.register("combine", "/STAR", "Star.", "npc/combine_soldier/vo/star.wav")
voice.register("combine", "/STATIONBLOCK", "Stationblock.", "npc/metropolice/vo/stationblock.wav")
voice.register("combine", "/STAY ALERT", "Stay alert.", "npc/combine_soldier/vo/stayalert.wav")
voice.register("combine", "/STERILIZE", "Sterilize!", "npc/metropolice/vo/sterilize.wav")
voice.register("combine", "/STINGER", "Stinger.", "npc/combine_soldier/vo/stringer.wav")
voice.register("combine", "/STORM", "Storm.", "npc/combine_soldier/vo/storm.wav")
voice.register("combine", "/STRIKE", "Striker.", "npc/combine_soldier/vo/striker.wav")
voice.register("combine", "/SUBJECT 505", "Subject is 505!", "npc/metropolice/vo/subjectis505.wav")
voice.register("combine", "/SUBJECT HIGH SPEED", "All units, be advised, subject is now high-speed!", "npc/metropolice/vo/subjectisnowhighspeed.wav")
voice.register("combine", "/SUBJECT", "Subject!", "npc/metropolice/vo/subject.wav")
voice.register("combine", "/SUNDOWN", "Sundown.", "npc/combine_soldier/vo/sundown.wav")
voice.register("combine", "/SUSPECT INCURSION", "Disp reports suspect-incursion at location.", "npc/metropolice/vo/dispreportssuspectincursion.wav")
voice.register("combine", "/SUSPECT MOVED TO", "Suspect has moved now to...", "npc/metropolice/vo/supsecthasnowmovedto.wav")
voice.register("combine", "/SUSPECT RESTRICTED CANALS", "Suspect is using restricted canals at...", "npc/metropolice/vo/suspectusingrestrictedcanals.wav")
voice.register("combine", "/SUSPEND", "Suspend!", "npc/metropolice/vo/suspend.wav")
voice.register("combine", "/SWEEPER", "Sweeper.", "npc/combine_soldier/vo/sweeper.wav")
voice.register("combine", "/SWEEPING IN", "Sweeping in!", "npc/combine_soldier/vo/sweepingin.wav")
voice.register("combine", "/SWEEPING SUSPECT", "Sweeping for suspect!", "npc/metropolice/vo/sweepingforsuspect.wav")
voice.register("combine", "/SWIFT", "Swift.", "npc/combine_soldier/vo/swift.wav")
voice.register("combine", "/SWORD", "Sword.", "npc/combine_soldier/vo/sword.wav")
voice.register("combine", "/TAG 10-91D", "Tag 10-91d!", "npc/metropolice/vo/tag10-91d.wav")
voice.register("combine", "/TAG BUG", "Tag one bug!", "npc/metropolice/vo/tagonebug.wav")
voice.register("combine", "/TAG NECROTIC", "Tag one necrotic!", "npc/metropolice/vo/tagonenecrotic.wav")
voice.register("combine", "/TAG PARASITIC", "Tag one parasitic!", "npc/metropolice/vo/tagoneparasitic.wav")
voice.register("combine", "/TAKE A LOOK", "Going to take a look!", "npc/metropolice/vo/goingtotakealook.wav")
voice.register("combine", "/TAKE COVER", "Take cover!", "npc/metropolice/vo/takecover.wav")
voice.register("combine", "/TAP", "Tap!", "npc/metropolice/vo/tap.wav")
voice.register("combine", "/TARGET", "Target.", "npc/combine_soldier/vo/target.wav")
voice.register("combine", "/TEAM ADVANCE", "Team in position, advance!.", "npc/metropolice/vo/teaminpositionadvance.wav")
voice.register("combine", "/TEAM HOLDING", "Stabilization team holding in position.", "npc/combine_soldier/vo/stabilizationteamholding.wav")
voice.register("combine", "/THERE HE GOES", "There he goes! He's at...", "npc/metropolice/vo/therehegoeshesat.wav")
voice.register("combine", "/THERE HE IS", "There he is!", "npc/metropolice/vo/thereheis.wav")
voice.register("combine", "/TRACKER", "Tracker.", "npc/combine_soldier/vo/tracker.wav")
voice.register("combine", "/TRANSITBLOCK", "Transit-block.", "npc/metropolice/vo/transitblock.wav")
voice.register("combine", "/TROUBLE", "Lookin' for trouble?", "npc/metropolice/vo/lookingfortrouble.wav")
voice.register("combine", "/UNDER FIRE", "Officer under fire, taking cover!", "npc/metropolice/vo/officerunderfiretakingcover.wav")
voice.register("combine", "/UNIFORM", "Uniform.", "npc/combine_soldier/vo/uniform.wav")
voice.register("combine", "/UNION", "Union!", "npc/metropolice/vo/union.wav")
voice.register("combine", "/UNKNOWN", "Suspect location unknown.", "npc/metropolice/vo/suspectlocationunknown.wav")
voice.register("combine", "/UP THERE", "He's up there!", "npc/metropolice/vo/hesupthere.wav")
voice.register("combine", "/UPI", "UPI.", "npc/metropolice/vo/upi.wav")
voice.register("combine", "/UTL SUSPECT", "UTL that suspect.", "npc/metropolice/vo/utlthatsuspect.wav")
voice.register("combine", "/UTL", "UTL suspect.", "npc/metropolice/vo/utlsuspect.wav")
voice.register("combine", "/VACATE", "Vacate, citizen!", "npc/metropolice/vo/vacatecitizen.wav")
voice.register("combine", "/VAMP", "Vamp.", "npc/combine_soldier/vo/vamp.wav")
voice.register("combine", "/VERDICT", "You want a malcompliance verdict?", "npc/metropolice/vo/youwantamalcomplianceverdict.wav")
voice.register("combine", "/VICE", "Vice!", "npc/metropolice/vo/vice.wav")
voice.register("combine", "/VICTOR", "Victor!", "npc/metropolice/vo/victor.wav")
voice.register("combine", "/VISCON", "Viscon.", "npc/combine_soldier/vo/viscon.wav")
voice.register("combine", "/VISUAL EXOGEN", "Visual on exogen.", "npc/combine_soldier/vo/visualonexogen.wav")
voice.register("combine", "/WARNING GIVEN", "Second warning given!", "npc/metropolice/vo/secondwarning.wav")
voice.register("combine", "/WASTERIVER", "Wasteriver.", "npc/metropolice/vo/wasteriver.wav")
voice.register("combine", "/WATCH IT", "Watch it!", "npc/metropolice/vo/watchit.wav")
voice.register("combine", "/WINDER", "Winder.", "npc/combine_soldier/vo/winder.wav")
voice.register("combine", "/WORKFORCE", "Workforce intake.", "npc/metropolice/vo/workforceintake.wav")
voice.register("combine", "/WRAP IT UP", "That's it, wrap it up.", "npc/combine_soldier/vo/thatsitwrapitup.wav")
voice.register("combine", "/XRAY", "XRay!", "npc/metropolice/vo/xray.wav")
voice.register("combine", "/YEAH", "Yeah.", "npc/metropolice/mc1ans_yeah.wav")
voice.register("combine", "/YELLOW", "Yellow!", "npc/metropolice/vo/yellow.wav")
voice.register("combine", "/YEP", "Yep.", "npc/metropolice/mc1ans_yep.wav")
voice.register("combine", "/YOU CAN GO", "Alright, you can go.", "npc/metropolice/vo/allrightyoucango.wav")
voice.register("combine", "/ZONE", "Zone!", "npc/metropolice/vo/zone.wav")
voice.register("combine", "/DROP YOUR WEAPON", "Drop your weapon.", "npc/metropolice/dropweapon.wav")
voice.register("combine", "/FREEZE", "Freeze!", "npc/metropolice/freeze.wav ")
voice.register("combine", "/GROUND", "Stay where you are! Get on the ground! Do it now!", "npc/metropolice/getonground.wav ")
voice.register("combine", "/HIDING", "There is no point in hiding.", "npc/metropolice/hiding02.wav ")
voice.register("combine", "/ESCAPE", "You have no chance of escape.", "npc/metropolice/hiding03.wav ")
voice.register("combine", "/SURROUNDED", "Youre surrounded!", "npc/metropolice/hiding04.wav")
voice.register("combine", "/SHUT UP", "Shut up.", "npc/metropolice/mc2ans_shutup.wav")
voice.register("combine", "/COVERED", "We have you covered.", "npc/metropolice/hiding05.wav ")
voice.register("combine", "/TAKEDOWN", "Take him down!", "npc/metropolice/takedown.wav")
voice.register("combine", "/HM", "Hmph", "npc/metropolice/mc1ans_hm.wav")
voice.register("combine", "/WHAT THE", "What the?", "npc/metropolice/surprise1.wav")
voice.register("combine", "/MINE", "He is mine!", "npc/metropolice/shooter03.wav ")
voice.register("combine", "/RIGHT", "Right!", "npc/metropolice/shooter04.wav ")
voice.register("combine", "/SEE HIM", "Yes, I see him.", "npc/metropolice/shooter05.wav ")
voice.register("combine", "/GOT IT", "Got it.", "npc/metropolice/shooter01.wav")
voice.register("combine", "/HIT", "I got hit!", "npc/metropolice/shooter02.wav ")
voice.register("combine", "/COULD BE", "Could be.", "npc/metropolice/mc2ans_couldbe.wav")
voice.register("combine", "/RADIALS FREE", "Report all redials free.", "npc/combine_soldier/vo/reportallradialsfree.wav")
voice.register("combine", "/SIGHT LINES", "Stay alert, report sight lines.", "npc/combine_soldier/vo/stayalertreportsightlines.wav")
voice.register("combine", "/BODYPACK", "Bodypack holding!", "npc/combine_soldier/vo/bodypackholding.wav")
voice.register("combine", "/PROCEEDING", "Containment  proceeding", "npc/combine_soldier/vo/containmentproceeding.wav")
voice.register("combine", "/HVT CONTAINED", "Overwatch confirms, helix vector tango is contained.", "npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav")
voice.register("combine", "/MEDICAL", "Request medical!", "npc/combine_soldier/vo/requestmedical.wav")
voice.register("combine", "/STIM", "Request stim dose!", "npc/combine_soldier/vo/requeststimdose.wav")
voice.register("combine", "/FLARE DOWN", "Flare down!", "npc/combine_soldier/vo/flaredown.wav")

// voice.register("dispatch", "ACTIVITY LEVEL 1", "You are charged with anti-civil activity level: ONE. Protection-unit prosecution code: DUTY, SWORD, OPERATE.", "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav")
voice.register("dispatch", "ANTI-CITIZEN", "Attention, ground-units: Anti-citizen reported in this community. Code: LOCK, CAUTERIZE, STABILIZE.", "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav")
// voice.register("dispatch", "ANTI-CIVIL EVIDENCE", "Protection-team, alert: Evidence of anti-civil activity in this community. Code: ASSEMBLE, CLAMP, CONTAIN.", "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav")
// voice.register("dispatch", "ARE CHARGED WITH", "Individual, you are charged with capital malcompliance. Anti-citizen status, APPROVED.", "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav")
voice.register("dispatch", "ASSUME POSITIONS", "Attention, please: All citizens in local residential block, assume your inspection-positions.", "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav")
voice.register("dispatch", "AUTONOMOUS JUDGMENT", "Attention, all ground-protection teams, autonomous judgment is now in effect. Sentencing is now discretionary. Code, AMPUTATE, ZERO, CONFIRM.", "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav")
voice.register("dispatch", "CITIZEN RELOCATION", "Citizen notice: Failure to co-operate will result in permanent off-world relocation.", "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav")
voice.register("dispatch", "CONSPIRACY", "Citizen reminder: Inaction is conspiracy. Report counter-behavior to a Civil-Protection team immediately.", "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav")
voice.register("dispatch", "CONVICTED", "Individual, you are convicted of multi-anti-civil violations. Implict citizenship revoked. Status, MALIGNANT.", "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav")
voice.register("dispatch", "DEDUCTED", "Attention, occupants: Your block is now charged with permissive inactive coersion. Five ration-units deducted.", "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav")
voice.register("dispatch", "EVASION BEHAVIOR", "Attention, please, evasion behaviour consistent with malcompliant defendant. Ground protection-team, alert, code: ISOLATE, EXPOSE, ADMINISTER.", "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav")
// voice.register("dispatch", "INDIVIDUAL CHARGED WITH", "Individual, you are charged with socio-endangerment level: ONE. Protection-unit prosecution code, DUTY, SWORD, MIDNIGHT.", "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav")
voice.register("dispatch", "INSPECTION", "Citizen notice, priority identification-check in-progress. Please assemble in your designated inspection positions.", "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav")
voice.register("dispatch", "JUDGMENT WAIVER", "Attention, all ground-protection teams, judgment waiver now in effect. Capital prosecution is discretionary.", "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav")
voice.register("dispatch", "MISCOUNT DETECTED", "Attention, residents: Miscount detected in your block. Co-operation with your Civil Protection team permits full ration reward.", "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav")
voice.register("dispatch", "MISSION FAILURE", "Attention, ground-units: Mission-failure will result in permanent off-world assignment. Code-reminder: SACRIFICE, COAGULATE, CLAMP.", "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav")
voice.register("dispatch", "OVERWATCH ACKNOWLEDGES", "Overwatch acknowledges critical exogen-breach. AirWatch augmentation-force dispatched and inbound. Hold for re-enforcement.", "npc/overwatch/cityvoice/fprison_airwatchdispatched.wav")
voice.register("dispatch", "POTENTIAL INFECTION", "Attention, residents: This blocks contains potential civil infection. INFORM, CO-OPERATE, ASSEMBLE.", "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav")
voice.register("dispatch", "RECEIVE YOUR VERDICT", "Individual, you are now charged with socio-endangerment level: FIVE. Cease evasion immediately, recieve your verdict.", "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav")
voice.register("dispatch", "STATUS EVASION", "Attention, protection-team, status evasion in progress in this community. RESPOND, ISOLATE, INQUIRE.", "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav")
voice.register("dispatch", "UNIDENTIFIED", "Attention, please: Unidentified person of interest, confirm your civil status with local protection-team immediately.", "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav")
voice.register("dispatch", "UNREST PROCEDURE", "Attention, community: Unrest procedure code is now in effect. INNOCULATE, SHIELD, PACIFY. Code: PRESSURE, SWORD, STERILIZE.", "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav")
voice.register("dispatch", "UNREST STRUCTURE", "Alert, community ground-protection units, local unrest structure detected. ASSEMBLE, ADMINISTER, PACIFY.", "npc/overwatch/cityvoice/f_localunrest_spkr.wav")

voice.register("radio", "10-103m", "10-103m, disturbance by mentally unfit", "npc/overwatch/radiovoice/disturbancemental10-103m.wav")
voice.register("radio", "10-0", "10-0, begin scanning", "npc/overwatch/radiovoice/beginscanning10-0.wav")
voice.register("radio", "148", "148. Resisting arrest", "npc/overwatch/radiovoice/resistingpacification148.wav")
voice.register("radio", "243", "243, assualt on protection team", "npc/overwatch/radiovoice/assault243.wav")
voice.register("radio", "50%", "50% reproduction credits", "npc/overwatch/radiovoice/halfreproductioncredits.wav")
voice.register("radio", "27", "27, attempted crime", "npc/overwatch/radiovoice/attemptedcrime27.wav")
voice.register("radio", "507", "507, public non-complicance", "npc/overwatch/radiovoice/publicnoncompliance507.wav")
voice.register("radio", "603", "603, unlawful entry", "npc/overwatch/radiovoice/unlawfulentry603.wav")
voice.register("radio", "94", "94, weapon", "npc/overwatch/radiovoice/weapon94.wav")
voice.register("radio", "No activity", "Airwatch reports no activity", "npc/overwatch/radiovoice/airwatchcopiesnoactivity.wav")
voice.register("radio", "sentencing", "All protection team units, complete sentencing at will", "npc/overwatch/radiovoice/completesentencingatwill.wav")
voice.register("radio", "code 3", "All teams respond code 3", "npc/overwatch/radiovoice/allteamsrespondcode3.wav")
voice.register("radio", "terminal verdict", "All units deliver terminal verdict immediatley", "npc/overwatch/radiovoice/allunitsdeliverterminalverdict.wav")
voice.register("radio", "forward pressure", "All units apply forward pressure", "npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav")
voice.register("radio", "Verdict Code", "All units: Verdict Code is", "npc/overwatch/radiovoice/allunitsverdictcodeis.wav")
voice.register("radio", "charged with", "Attention, you have been charged with", "npc/overwatch/radiovoice/attentionyouhavebeenchargedwith.wav")
voice.register("radio", "Capital Malcompliance", "Capital Malcompliance", "npc/overwatch/radiovoice/capitalmalcompliance.wav")
voice.register("radio", "Immediate amputation", "Immediate amputation", "npc/overwatch/radiovoice/immediateamputation.wav")
voice.register("radio", "In progress", "In progress", "npc/overwatch/radiovoice/inprogress.wav")
voice.register("radio", "Investigate report", "Investigate and report", "npc/overwatch/radiovoice/investigateandreport.wav")
voice.register("radio", "Level 5", "Level 5 anti-civil activity", "npc/overwatch/radiovoice/level5anticivilactivity.wav")
voice.register("radio", "Officer closing", "Officer closing on suspect", "npc/overwatch/radiovoice/officerclosingonsuspect.wav")
voice.register("radio", "off-world service", "Permanent off-world service assignment", "npc/overwatch/radiovoice/permanentoffworld.wav")
voice.register("radio", "Accomplices operating", "Protection team, be adivsed: Accomplices operating in area", "npc/overwatch/radiovoice/accomplicesoperating.wav")
voice.register("radio", "lock down", "Protection team, lock down your location. Sacrifice code", "npc/overwatch/radiovoice/lockdownlocationsacrificecode.wav")
voice.register("radio", "Reinforcement teams", "Reinforcement teams code 3", "npc/overwatch/radiovoice/reinforcementteamscode3.wav")
voice.register("radio", "units contain", "Remaining units contain", "npc/overwatch/radiovoice/remainingunitscontain.wav")
voice.register("radio", "Memory", "Reminder: Memory replacement is the first step towards rank privileges", "npc/overwatch/radiovoice/remindermemoryreplacement.wav")
voice.register("radio", "Report please", "Report please", "npc/overwatch/radiovoice/reportplease.wav")
voice.register("radio", "Respond111", "Respond", "npc/overwatch/radiovoice/respond.wav")
voice.register("radio", "Socio-stabilization", "Socio-stabilization restored", "npc/overwatch/radiovoice/sociostabilizationrestored.wav")
voice.register("radio", "Remaining units", "Remaining units contain", "npc/overwatch/radiovoice/remainingunitscontain.wav")
voice.register("radio", "Suspend negotiations", "Suspend negotiations", "npc/overwatch/radiovoice/suspendnegotiations.wav")
voice.register("radio", "Unit deserviced", "Unit deserviced", "npc/overwatch/radiovoice/unitdeserviced.wav")
voice.register("radio", "judged guilty", "You are judged guilty by Civil Protection teams", "npc/overwatch/radiovoice/youarejudgedguilty.wav")
voice.register("radio", "Unit down", "Unit down at", "npc/overwatch/radiovoice/unitdownat.wav")
voice.register("radio", "404 zone", "404 zone", "npc/overwatch/radiovoice/404zone.wav")
voice.register("radio", "Industrial zone", "Industrial zone", "npc/overwatch/radiovoice/industrialzone.wav")
voice.register("radio", "Zero", "0", "npc/overwatch/radiovoice/zero.wav") -- npc/overwatch/radiovoice/zero.wav
voice.register("radio", "One", "1", "npc/overwatch/radiovoice/one.wav")
voice.register("radio", "Two", "2", "npc/overwatch/radiovoice/two.wav")
voice.register("radio", "Three", "3", "npc/overwatch/radiovoice/three.wav")
voice.register("radio", "Four", "4", "npc/overwatch/radiovoice/four.wav")
voice.register("radio", "Five", "5", "npc/overwatch/radiovoice/five.wav")
voice.register("radio", "Six", "6", "npc/overwatch/radiovoice/six.wav")
voice.register("radio", "Seven", "7", "npc/overwatch/radiovoice/seven.wav")
voice.register("radio", "Eight", "8", "npc/overwatch/radiovoice/eight.wav")
voice.register("radio", "Nine", "9", "npc/overwatch/radiovoice/nine.wav")
voice.register("radio", "Administer", "Administer", "npc/overwatch/radiovoice/administer.wav") -- npc/overwatch/radiovoice/administer.wav npc/overwatch/radiovoice/respond.wav
voice.register("radio", "Respond", "Respond", "npc/overwatch/radiovoice/respond.wav")
voice.register("radio", "Amputate", "Amputate", "npc/overwatch/radiovoice/amputate.wav")
voice.register("radio", "Anti-Citizen", "Anti-Citizen", "npc/overwatch/radiovoice/anticitizen.wav")


local function CPTalk(client, text)

	local volume = 80;

	local sounds, message = voice.getVoiceList("combine", text)
	if not sounds then return end

	local beeps = hl2rp.beepSounds[client:Team()]

	table.insert(sounds, 1, {(table.Random(beeps.on)), 0.25})
	sounds[#sounds + 1] = {(table.Random(beeps.off)), nil, 0.25}

	netstream.Start(nil, "voicePlay", sounds, volume, client:EntIndex())

	return message;
end

hook.Add( "CPTalk", "CPTalk", CPTalk )

local function DispatchTalk(client, text)

	local volume = 50;

	local sounds, message = voice.getVoiceList("dispatch", text)
	if not sounds then return end



	netstream.Start(nil, "voicePlay", sounds, volume)
	return message;
end

hook.Add( "DispatchTalk", "DispatchTalk", DispatchTalk )

local function DispatchRadioTalk(client, text)
if client:Team() == TEAM_CP or client:Team() == TEAM_OVERWATCH or client:Team() == TEAM_ADMINISTRATOR or client:Team() == TEAM_DISPATCH then 
	local volume = 80;


	local sounds, message = voice.getVoiceList("radio", text)
	if not sounds then return end


	netstream.Start(nil, "voicePlay1", sounds, volume)
	return message;
end
end

hook.Add( "DispatchRadioTalk", "DispatchRadioTalk", DispatchRadioTalk )