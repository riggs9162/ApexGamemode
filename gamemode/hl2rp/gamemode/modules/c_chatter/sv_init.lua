local metroSounds = {

	"npc/combine_soldier/vo/prison_soldier_visceratorsA5.wav",
	"npc/combine_soldier/vo/sectorissecurenovison.wav",
	"npc/combine_soldier/vo/prison_soldier_bunker3.wav",
	"npc/combine_soldier/vo/prison_soldier_bunker2.wav",
	"npc/combine_soldier/vo/copythat.wav",
	"npc/metropolice/vo/novisualonupi.wav",
	"npc/metropolice/vo/searchingforsuspect.wav",
	"npc/metropolice/vo/standardloyaltycheck.wav",
	"npc/metropolice/vo/loyaltycheckfailure.wav",
	"npc/metropolice/vo/citizensummoned.wav",
	"npc/metropolice/vo/confirmpriority1sighted.wav",
	"npc/metropolice/vo/searchingforsuspect.wav",
	"npc/metropolice/vo/anyonepickup647e.wav",
	"npc/combine_soldier/vo/affirmative2.wav",
	"npc/combine_soldier/vo/prison_soldier_prosecuteD7.wav",
	"npc/combine_soldier/vo/reportallpositionsclear.wav",
	"npc/metropolice/vo/localcptreportstatus.wav",
	"npc/metropolice/vo/pickingupnoncorplexindy.wav",
	"npc/metropolice/vo/ten4.wav",
	"npc/metropolice/vo/Ihave10-30my10-20responding.wav",
	"npc/metropolice/vo/cprequestsallunitsreportin.wav",
	"npc/metropolice/vo/copy.wav",
	"npc/metropolice/vo/clearno647no10-107.wav",
	"npc/metropolice/vo/affirmative.wav",
	"npc/metropolice/vo/affirmative2.wav",
	"npc/metropolice/vo/holdingon10-14duty.wav",
	"npc/combine_soldier/vo/reportingclear.wav",
	"npc/combine_soldier/vo/reportallpositionsclear.wav",
	"npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",
	"npc/combine_soldier/vo/standingby].wav",
	"npc/metropolice/vo/checkformiscount.wav",
	"npc/metropolice/vo/wegotadbherecancel10-102.wav",
	"npc/metropolice/vo/stillgetting647e.wav",
	"npc/metropolice/vo/unitreportinwith10-25suspect.wav",
	"npc/metropolice/vo/dispreportssuspectincursion.wav",
	"npc/metropolice/vo/ptatlocationreport.wav",
	"npc/metropolice/vo/possible404here.wav",
	"npc/metropolice/vo/possible10-103alerttagunits.wav",
	"npc/metropolice/vo/possible647erequestairwatch.wav",
	"npc/metropolice/vo/reportsightingsaccomplices.wav",
	"npc/metropolice/vo/matchonapblikeness.wav",
	"npc/overwatch/radiovoice/disturbancemental10-103m.wav",
	"npc/overwatch/radiovoice/allunitsbolfor243suspect.wav",
	"npc/overwatch/radiovoice/allunitsdeliverterminalverdict.wav",
	"npc/overwatch/radiovoice/completesentencingatwill.wav",
	"npc/overwatch/radiovoice/allunitsreturntocode12.wav",
	"npc/overwatch/radiovoice/destructionofcpt.wav",
	"npc/overwatch/radiovoice/airwatchcopiesnoactivity.wav",
	"npc/overwatch/radiovoice/accomplicesoperating.wav",
	"npc/overwatch/radiovoice/leadersreportratios.wav",
	"npc/overwatch/radiovoice/publicnoncompliance507.wav",
	"npc/overwatch/radiovoice/remindermemoryreplacement.wav",
	"npc/overwatch/radiovoice/reporton.wav",
	"npc/overwatch/radiovoice/rewardnotice.wav",
	"npc/overwatch/radiovoice/reminder100credits.wav",
	"npc/overwatch/radiovoice/antifatigueration3mg.wav",
	"npc/overwatch/radiovoice/recalibratesocioscan.wav",
	"npc/overwatch/radiovoice/politistablizationmarginal.wav",
	"npc/overwatch/radiovoice/resistingpacification148.wav",
	"npc/overwatch/radiovoice/suspectisnow187.wav",
	"npc/overwatch/radiovoice/teamsreportstatus.wav",
	"npc/overwatch/radiovoice/youarechargedwithterminal.wav",
	"npc/overwatch/radiovoice/allunitsverdictcodeonsuspect.wav",

}

local nextSound = CurTime();
local function metroTalk()

	if CurTime() > nextSound then

		nextSound = CurTime() + math.random(20,180)
		for k,v in pairs(player.GetAll()) do
			if v:Team() == TEAM_CP then

					v:EmitSound( metroSounds[ math.random( #metroSounds ) ] , 40)

			end;
		end;

	end;

end;
hook.Add( "Think", "metroTalk", metroTalk );
