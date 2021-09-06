function RappelFinish(e,playercolor,movetype,weaponcolor,overridepos)

	local oldwepcolor = weaponcolor

	local oldcolor = playercolor

	if IsValid(e.Rappel) then

		e:EmitSound("npc/combine_soldier/zipline_hitground"..math.random(1,2)..".wav")


			if IsValid(e.Rappel) then

				local ply = e.Rappel
                               ply.IsRappeling = nil
				e:EmitSound("npc/combine_soldier/zipline_clip2.wav")

				if IsValid(ply.RappelEnt) then
			--	ply:UnSpectate()
                                 if overridepos then
					ply:SetPos(overridepos)
else
					ply:SetPos(ply.RappelEnt:GetPos())
end
					ply:SetEyeAngles(Angle(0,ply.RappelEnt:GetAngles().yaw,0))

					e:Remove()

				end

				ply:SetMoveType(movetype)

				if (ply:GetMoveType()!=MOVETYPE_WALK) then

					ply:SetMoveType(MOVETYPE_WALK)

				end

				-- Doing observer makes clockwork observer fuck up D;

				ply:SetWeaponColor(oldwepcolor)
 

				--Clockwork.player:ToggleWeaponRaised(ply);

				ply:SetNoDraw(false)
    ply:SetNWEntity("sh_Eyes",nil)

                                ply:SetNotSolid(false)


				--ply:UnSpectate()
    ply:GodDisable()

 				ply:Freeze(false)
                             

				ply:SetColor(oldcolor)


			else

				e:Remove()

			end

	end

end





function PlayerRappel(ply)

	local playerwepcolor = ply:GetWeaponColor()

	local playercolor = ply:GetColor()

	local movetype = ply:GetMoveType()

	local po = ply:GetPos() + (ply:GetForward() * 30)

	local t = {}

	t.start = po

	t.endpos = po - Vector(0,0,1000)

	t.filter = {ply}

	local tr = util.TraceLine(t)

	if tr.HitPos.z <= ply:GetPos().z then
if tr.HitPos:Distance(ply:GetPos()) < 200 then return end
--if tr.HitPos.y > ply:GetPos().y + 10 or tr.HitPos.y < ply:GetPos().y - 10 then return end
--if tr.HitPos.x > ply:GetPos().x + 10 or tr.HitPos.x < ply:GetPos().x - 10 then return end
ply.StartPos=ply:GetPos()
		local e = ents.Create("npc_metropolice")

		e:SetKeyValue("waitingtorappel",1)

		e:SetPos(po)

		e:SetAngles(Angle(0,ply:EyeAngles().yaw,0))

		e:Spawn()

		e:CapabilitiesClear()

		e:CapabilitiesAdd( CAP_MOVE_GROUND  )

 		--timer.Simple(10, function() RappelFinish(e,playercolor,movetype) end)
timer.Simple(16, function() 
if e and IsValid(e) then
e:Remove()

if IsValid(ply) then

				ply:SetMoveType(movetype)

				if (ply:GetMoveType()!=MOVETYPE_WALK) then

					ply:SetMoveType(MOVETYPE_WALK)

				end
ply:ChatPrint("You got stuck, fixing....")
				-- Doing observer makes clockwork observer fuck up D;

				ply:SetWeaponColor(Vector(1,1,1))
 

				--Clockwork.player:ToggleWeaponRaised(ply);

				ply:SetNoDraw(false)
    ply:SetNWEntity("sh_Eyes",nil)
    ply:SetNotSolid(false)


				--ply:UnSpectate()
    ply:GodDisable()

 			ply:Freeze(false)
                             

				ply:SetColor(Color(255,255,255,255))
    ply.IsRappeling = nil


end

end
end)

		timer.Create( "rappelchecker", 0.5, 0, function()
if IsValid(e) then

			if e:IsOnGround() then
    if loopsnd then
    loopsnd:Stop()
    end
				RappelFinish(e,playercolor,movetype,playerwepcolor)

				timer.Destroy("rappelchecker")
    
    else
    local loopsnd = CreateSound(e,"npc/combine_soldier/zipline2.wav")
    loopsnd:Play()
    
    if e.LastPos and e.LastPos==e:GetPos() then 
    RappelFinish(e,playercolor,movetype,playerwepcolor,ply.StartPos)
    timer.Destroy("rappelchecker")
    end
    

			end
e.LastPos = e:GetPos()
end
		end)

		e.Rappel = ply

  e:EmitSound("npc/combine_soldier/zipline_clip1.wav")
		local loopsnd = CreateSound(e,"npc/combine_soldier/zipline2.wav")
  loopsnd:Play()

		e:SetModel(ply:GetModel())

		local plyweapon = ply:GetActiveWeapon():GetClass()

		if plyweapon == "cw_hands" then

			local plyweapon = "weapon_stunstick"

		end

		if plyweapon == "cw_keys" then

			local plyweapon = "weapon_stunstick"

		end

	--	e:Give(plyweapon)

		e:SetName("npc_gman")

		e.Gods = true

		e.God = true

		ply:SetMoveType(MOVETYPE_FLY)
ply.IsRappeling = true

		ply:Freeze(true)
  ply:SetNoDraw(true)

		ply:SetNWEntity("sh_Eyes",e)

		--ply:SetViewEntity(e)

		--ply:Spectate( OBS_MODE_CHASE )

		--ply:SpectateEntity( e )


		--Clockwork.player:ToggleWeaponRaised(ply);

		e:Fire("beginrappel")

		e:Fire("addoutput","OnRappelTouchdown rappelent,RunCode,0,-1", 0 )

		ply.RappelEnt = e

	end

end



hook.Add("EntityTakeDamage","RAPPEL-DMG",function(ent)
if ent:IsNPC() and ent.God then
return true
end


end)


