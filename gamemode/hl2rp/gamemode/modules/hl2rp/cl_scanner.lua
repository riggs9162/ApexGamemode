surface.CreateFont("nutScannerFont", {
		font = "Lucida Sans Typewriter",
		antialias = false,
		outline = true,
		weight = 800,
		size = 18
})


PICTURE_WIDTH, PICTURE_HEIGHT = 580, 420
PICTURE_WIDTH2, PICTURE_HEIGHT2 = PICTURE_WIDTH * 0.5, PICTURE_HEIGHT * 0.5
PICTURE_WIDTH3, PICTURE_HEIGHT3 = ScrW()/3.9,ScrH()/4
local ScreenshotRequested = false


hook.Add( "CalcView", "ThirdPersonView", function( ply, pos, angles, fov )



		local entity = ply:GetViewEntity()
		local self= LocalPlayer()

		if (IsValid(entity) and entity:GetClass():find("scanner")) then
			view = {}
			view.origin = entity:GetPos() - Vector( 0, 0, 10 )
			view.angles = ply:EyeAngles()
			view.fov = fov
			
		if LocalPlayer():KeyDown(IN_ATTACK) then
				if ((self.lastPic or 0) < CurTime()) then
			    self.lastPic = CurTime() + 10

			local flash = DynamicLight(0)

			if (flash) then
				flash.pos = entity:GetPos()
				flash.r = 255
				flash.g = 255
				flash.b = 255
				flash.brightness = 0.2
				flash.Decay = 5000
				flash.Size = 3000
				flash.DieTime = CurTime() + 0.3

				timer.Simple(0.05, function()
				  	ScreenshotRequested = true  
				end)
			end
end

		end
		
				if LocalPlayer():KeyDown(IN_ATTACK2) then
				    if ((self.lastemote or 0) < CurTime()) then
			            self.lastemote = CurTime() + 2
			            if ((self.lastangry or 0) < CurTime()) then
			                self.lastangry = CurTime() + 10
			            	    net.Start("apexScannerAngry")
                                    net.WriteBool( 1 )
		                            net.WriteEntity(entity)
	                            net.SendToServer()
	                   end
			        end
		        end
		    
				if LocalPlayer():KeyDown(IN_RELOAD) then
				    if ((self.lastemote or 0) < CurTime()) then
			            self.lastemote = CurTime() + 2
			            	net.Start("apexScannerEmote")
                                net.WriteBool( 1 )
		                        net.WriteEntity(entity)
	                        net.SendToServer()
			        end
			    end
end

			return view		
		

end )

hook.Add( "PostRender", "example_screenshot", function()
    if ( !ScreenshotRequested ) then return end
	ScreenshotRequested = false
    
	local data = util.Compress(render.Capture({
		format = "jpeg",
		h = PICTURE_HEIGHT,
		w = PICTURE_WIDTH,
		quality = 35,
		x = ScrW()*0.5 - PICTURE_WIDTH2,
		y = ScrH()*0.5 - PICTURE_HEIGHT2
	}))

	net.Start("nutScannerData")
		net.WriteUInt(#data, 16)
		net.WriteData(data, #data)
		net.WriteEntity(entity)
	net.SendToServer()

end)

















PHOTO_CACHE = PHOTO_CACHE or {}


net.Receive("nutScannerData", function()
		local data = net.ReadData(net.ReadUInt(16))
		data = util.Base64Encode(util.Decompress(data))

		if (data) then
			if (IsValid(CURRENT_PHOTO)) then
				local panel = CURRENT_PHOTO

				CURRENT_PHOTO:AlphaTo(0, 0.25, 0, function()
					if (IsValid(panel)) then
						panel:Remove()
					end
				end)
			end

			local html = Format([[
				<html>
					<body style="background: black; overflow: hidden; margin: 0; padding: 0;">
						<img src="data:image/jpeg;base64,%s" width="%s" height="%s" />
					</body>
				</html>
			]], data, PICTURE_WIDTH3, PICTURE_HEIGHT3)

			local panel = vgui.Create("DPanel")
			panel:SetSize(PICTURE_WIDTH3 + 8, PICTURE_HEIGHT3 + 8)
			panel:SetPos(ScrW(), 8)
			panel:SetDrawBackground(true)
			panel:SetAlpha(150)

			panel.body = panel:Add("DHTML")
			panel.body:Dock(FILL)
			panel.body:DockMargin(4, 4, 4, 4)
			panel.body:SetHTML(html)

			panel:MoveTo(ScrW() - (panel:GetWide() + 8), 8, 0.5)

			timer.Simple(15, function()
				if (IsValid(panel)) then
					panel:MoveTo(ScrW(), 8, 0.5, 0, -1, function()
						panel:Remove()
					end)
				end
			end)

			PHOTO_CACHE[#PHOTO_CACHE + 1] = {data = html, time = os.time()}
			CURRENT_PHOTO = panel
		end
end)

concommand.Add("nut_photocache", function()
		local frame = vgui.Create("DFrame")
		frame:SetTitle("Photo Cache")
		frame:SetSize(480, 360)
		frame:MakePopup()
		frame:SetSkin("Cortex")
		frame:Center()

		frame.list = frame:Add("DScrollPanel")
		frame.list:Dock(FILL)
		frame.list:SetDrawBackground(true)

		for k, v in ipairs(PHOTO_CACHE) do
			local button = frame.list:Add("DButton")
			button:SetTall(28)
			button:Dock(TOP)
			button:DockMargin(4, 4, 4, 0)
			button:SetText(os.date("%X - %d/%m/%Y", v.time))
			button.DoClick = function()
				local frame2 = vgui.Create("DFrame")
				frame2:SetSize(PICTURE_WIDTH + 8, PICTURE_HEIGHT + 8)
				frame2:SetTitle(button:GetText())
				frame2:MakePopup()
				frame2:SetSkin("Cortex")
				frame2:Center()

				frame2.body = frame2:Add("DHTML")
				frame2.body:SetHTML(v.data)
				frame2.body:Dock(FILL)
				frame2.body:DockMargin(4, 4, 4, 4)
			end
		end
end)












local toggle_sound = Sound("buttons/blip1.wav")

local convars = {
	should_overlay = 1,
	should_warn_if_flashlight = 1,
	emit_light = 1,
	color_contrast = 1.5,
	laser_enabled = 1,
	light_size = 750,
	color_r = 120,
	color_g = 255,
	color_b = 120,
}

for k, v in pairs(convars) do
	if not ConVarExists("nv_"..k) then
		CreateClientConVar("nv_"..k, v, true, false)
	end
end

local function nv_getdata(var, notbool)
	local data = GetConVarNumber("nv_"..var)
	if not notbool then
		data = tobool(data)
	end
	return data or false
end

local function nv_color()
	local nv_color = Color(
                NVR or 255,
	NVG or 255,
	NVB or 255,
	nv_getdata("color_a", true) or 255)
	return nv_color
end

local function nv_setcolor(col)
	for k, v in pairs(col) do
		RunConsoleCommand("nv_color_"..k, v)
	end
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

local function nv_posvisible(pos)
	if pos.x < 50 then return false end
	if pos.x > ScrW() - 50 then return false end
	if pos.y < 50 then return false end
	if pos.y > ScrH() - 50 then return false end

	return true
end

local function nv_unitstofeat(units)
    units = units + (units*0.25)
    units = math.floor(units / 12)
	return units
end

local function nv_cansee(ent)
	local tracedata = {}
	tracedata.start = LocalPlayer():GetShootPos()
	tracedata.endpos = nv_center(ent)
	tracedata.filter = {ent, LocalPlayer()}
	local trace = util.TraceLine(tracedata)
	if trace.Hit then
		return false
	end

	return true
end


local function nv_ents()
	local entities = {}

	for k, v in pairs(ents.FindByClass("npc_*")) do
		table.insert(entities, v)
	end
	for k, v in pairs(player.GetAll()) do
		if v != LocalPlayer() then
                     if v:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			table.insert(entities, v)
                     end
		end
	end
	for k, v in pairs(entities) do
		if not nv_cansee(v) then
			table.remove(entities, k)
		else
			if nv_center(v):Distance(LocalPlayer():GetPos()) > 3000 then
				table.remove(entities, k)
			end
		end
	end

	return entities
end


local on = false





hook.Add("Think", "NV_EmitLight", function()
	if nv_getdata("emit_light") then
		local light = DynamicLight(LocalPlayer():EntIndex())
		if (light) and on then
			light.Pos = LocalPlayer():GetPos() + Vector(0,0,30)
			light.r = NVR
			light.g = NVG
			light.b = NVB
			light.Brightness = 1
			light.Size = nv_getdata("light_size", true)
			light.Decay = nv_getdata("light_size", true) * 5
			light.DieTime = CurTime() + 1
			light.Style = 0
		end
	end
end)

local colormod = {}
colormod[ "$pp_colour_brightness" ] = 0
colormod[ "$pp_colour_colour" ] = 1
colormod[ "$pp_colour_mulr" ] = 0
colormod[ "$pp_colour_mulg" ] = 0
colormod[ "$pp_colour_mulb" ] = 0

hook.Add("HUDPaint", "NV_Overlay", function()
	if on then
		surface.SetDrawColor(Color(NVR,NVG,NVB,math.random(255)))

		for k, v in pairs(nv_ents()) do
			if nv_cansee(v) then
				local pos = nv_center(v):ToScreen()

				if nv_posvisible(pos) then
					surface.DrawLine(pos.x, 0, pos.x, ScrH())
					surface.DrawLine(0, pos.y, ScrW(), pos.y)
					local dist = LocalPlayer():GetShootPos():Distance(nv_center(v))
					draw.DrawText(nv_unitstofeat(dist) - 2, "Default",
					pos.x + 3, pos.y - 15, nv_color(), TEXT_ALIGN_LEFT)
				end
			end
		end


			draw.TexturedQuad({
				texture = surface.GetTextureID("effects/combine_binocoverlay"),
				color = Color(NVR,NVG,NVB,190),
				x = 0,
				y = 0,
				w = ScrW(),
				h = ScrH()
			})


	end
end)

hook.Add("HUDShouldDraw", "NV_DisableCrosshair", function(element)
	if element == "CHudCrosshair" then
		return not on
	end
end)

hook.Add("RenderScreenspaceEffects", "NV_ColorMod", function()
    if on then
		colormod[ "$pp_colour_contrast" ] = nv_getdata("color_contrast", true)
		colormod[ "$pp_colour_addr" ] = NVR / 2550
		colormod[ "$pp_colour_addg" ] = NVG / 2550
		colormod[ "$pp_colour_addb" ] = NVB / 2550
        DrawColorModify(colormod)
    end
end)

function LoadNV(ColR,ColG,ColB)

    surface.PlaySound(toggle_sound)
	on = not on


timer.Create("OWCHECK",1,0,function()
if not LocalPlayer():IsCP() then
	on = false
timer.Remove("OWCHECK")

end
end)

NVR=ColR
NVG=ColG
NVB=ColB
end