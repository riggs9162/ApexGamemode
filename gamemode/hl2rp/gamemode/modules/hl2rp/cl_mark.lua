hook.Add("HUDPaint", "HUD911", function()
	local ply = LocalPlayer()
	local w, h = 200, 50
	local x, y = ScrW()-w-10, 10
	for k,v in pairs ( player.GetAll( ) ) do
		if v:GetNWBool("Called911") and LocalPlayer():IsCP() then
			local scrn = Vector(v:GetPos().x, v:GetPos().y, v:GetPos().z):ToScreen()
			local distance = math.floor(LocalPlayer():GetPos():Distance(v:GetPos()) / 25)
			draw.DrawText(distance.."m", "ChatFont", scrn.x-35, scrn.y+20, Color(255,255,255), TEXT_ALIGN_CENTER)
			draw.DrawText("CCA REQUEST: "..v:Nick(), "ChatFont", scrn.x+20, scrn.y, Color(255,255,255), TEXT_ALIGN_CENTER)
			surface.SetDrawColor( 255, 255, 255, 255 )
			
		end
	end
end)


--[[
Some code is commented out in here
The commented code merely adds the skull & crossbones symbol to the "POLICE ASSAULT IN PROGRESS" HUD
]]

surface.CreateFont("pd2_assault_text",{
	font = "Roboto Cn",
	size = 30,
	weight = 0,
	antialias = true,
	outline = false
})
surface.CreateFont("pd2_assault_text_shad",{
	font = "Roboto Cn",
	size = 20,
	weight = 0,
	antialias = true,
	outline = true
})


local function DrawScrollingText( text,	xxx, y, texwide )
	surface.SetFont("pd2_assault_text")

	local w, h = surface.GetTextSize( text  )
	w = w

	local x = math.fmod( CurTime() * 125, w ) * -1

	while ( x < texwide ) do

		surface.SetTextColor(Color(255,0,0,255))
		surface.SetTextPos( x + xxx, y )
		surface.DrawText( text )

		x = x + w

	end

end

local songs = {
	{"music/hl1_song10.mp3",105},
	{"music/hl1_song15.mp3",105},
	{"music/hl1_song17.mp3",125},
	{"music/hl2_song12_long.mp3",73}
}





local function Assault_Icon_Beep()
	timer.Create("assault_icon_beeper",0.1,11,function()
		assault_icon = !assault_icon
	end)
end



CreateClientConVar("hl2rp_jw_music","1")


local moar_w = 230
hook.Add("HUDPaint","JW_HUD",function()
if LocalPlayer():IsCP() and GetGlobalBool("jw",false)==true then
	moar_w = math.Clamp(moar_w - 7.5,0,230)


	surface.SetDrawColor(Color(255,0,0,10 + (math.abs(math.sin(CurTime() * 2)) * 45)))

	surface.DrawRect(ScrW() - 310 + moar_w,22,265 - moar_w,46)

	surface.SetDrawColor(Color(255,0,0,255))
	surface.DrawRect(ScrW() - 310 + moar_w,65,15,3)
	surface.DrawRect(ScrW() - 310 + moar_w,55,3,12)

	surface.DrawRect(ScrW() - 310 + moar_w,22,15,3)
	surface.DrawRect(ScrW() - 310 + moar_w,24,3,12)

	surface.DrawRect(ScrW() - 60,65,15,3)
	surface.DrawRect(ScrW() - 48,55,3,12)

	surface.DrawRect(ScrW() - 60,22,15,3)
	surface.DrawRect(ScrW() - 48,24,3,12)


		surface.DrawRect(ScrW() - 40,22,20,20)

		surface.SetDrawColor(0,0,0,255)
		surface.SetMaterial(Material("icon16/error.png"))
		surface.DrawTexturedRect(ScrW() - 38,24,16,16)

	if moar_w <= 0 then


		render.SetScissorRect(ScrW() - 310,22,ScrW() - 45,68,true)
		DrawScrollingText("///     JUDGEMENT WAIVER IN PROGRESS     ",ScrW() - 300,30,300)
		render.SetScissorRect(0,0,0,0,false)
	end



	end
end)
