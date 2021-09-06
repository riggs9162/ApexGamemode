overwatchSounds = {



	"npc/metropolice/vo/novisualonupi.wav",

	"npc/metropolice/vo/searchingforsuspect.wav",

	"npc/metropolice/vo/standardloyaltycheck.wav",

	"npc/metropolice/vo/loyaltycheckfailure.wav",

	"npc/metropolice/vo/citizensummoned.wav",

	"npc/metropolice/vo/confirmpriority1sighted.wav",

	"npc/metropolice/vo/searchingforsuspect.wav",

	"npc/combine_soldier/vo/motioncheckallradials.wav",

	"npc/combine_soldier/vo/overwatchreportspossiblehostiles.wav",

	"npc/combine_soldier/vo/overwatchrequestreserveactivation.wav",

	"npc/combine_soldier/vo/ovewatchorders3ccstimboost.wav",

	"npc/combine_soldier/vo/prison_soldier_negativecontainment.wav",

	"npc/combine_soldier/vo/prison_soldier_leader9dead.wav",

	"npc/combine_soldier/vo/prison_soldier_prosecuteD7.wav",

	"npc/combine_soldier/vo/copythat.wav",

	"npc/combine_soldier/vo/copy.wav",

	"npc/combine_soldier/vo/stabilizationteamhassector.wav",

	"npc/combine_soldier/vo/weaponsoffsafeprepforcontact.wav",

	"npc/combine_soldier/vo/stayalertreportsightlines.wav",

	"npc/combine_soldier/vo/stabilizationteamholding.wav",

	"npc/combine_soldier/vo/sectorissecurenovison.wav",

	"npc/combine_soldier/vo/prison_soldier_activatecentral.wav",

	"npc/combine_soldier/vo/prison_soldier_bunker3.wav",

	"npc/combine_soldier/vo/prison_soldier_bunker1.wav",

	"npc/combine_soldier/vo/prison_soldier_bunker2.wav",

	"npc/combine_soldier/vo/prison_soldier_fallback_b4.wav",

	"npc/combine_soldier/vo/prison_soldier_containD8.wav",

	"npc/combine_soldier/vo/prison_soldier_sundown3dead.wav",

	"npc/combine_soldier/vo/prison_soldier_prosecuteD7.wav",

	"npc/combine_soldier/vo/overwatchrequestreserveactivation.wav",

	"npc/combine_soldier/vo/overwatchrequestskyshield.wav",

	"npc/combine_soldier/vo/overwatchrequestwinder.wav",

	"npc/combine_soldier/vo/overwatchtarget1sterilized.wav",

	"npc/combine_soldier/vo/overwatchtargetcontained.wav",

	"npc/combine_soldier/vo/overwatchconfirmhvtcontained.wav",

	"npc/combine_soldier/vo/isfinalteamunitbackup.wav",

	"npc/combine_soldier/vo/prison_soldier_visceratorsA5.wav",

	"npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",

	"npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav",

	"npc/combine_soldier/vo/prepforcontact.wav",

	"npc/combine_soldier/vo/sightlineisclear.wav",

	"npc/combine_soldier/vo/affirmative2.wav",

	"npc/combine_soldier/vo/reportallpositionsclear.wav",

	"npc/combine_soldier/vo/readyweapons.wav",

	"npc/metropolice/vo/ten4.wav",

	"npc/combine_soldier/vo/affirmative.wav",

	"npc/combine_soldier/vo/reportingclear.wav",

	"npc/combine_soldier/vo/teamdeployedandscanning.wav"

}



local nextSound = CurTime();

local function overwatchTalk()



	if CurTime() > nextSound then

for v,k in pairs(player.GetAll()) do

		nextSound = CurTime() + math.random(20,120)

		if k:Team() == TEAM_OVERWATCH then
         timer.Simple(math.random(1,14), function()


			k:EmitSound( overwatchSounds[ math.random( #overwatchSounds ) ], 40 )
        end)


		end;

end

	end;



end;

hook.Add( "Think", "overwatchTalk", overwatchTalk );

