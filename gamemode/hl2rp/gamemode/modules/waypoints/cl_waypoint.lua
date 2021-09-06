local wptexture = surface.GetTextureID("waypointmarker/wpmarker")

	net.Receive("waypointmarker", function()
		if LocalPlayer():IsCP() then
			local WaypointPos = net.ReadVector() + Vector(0,0,50)
			local StringTable = util.JSONToTable(net.ReadString())
			local WaypointPosScreen = WaypointPos:ToScreen()
			local time =60
			local charlimit=24
			local DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			timer.Create(StringTable.name.."UpdateWPPos", 0.01, time*100, function()
				WaypointPosScreen = WaypointPos:ToScreen()
				DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			end)

			function MakeWaypoint()
				draw.TexturedQuad({texture = wptexture, color = Color(255, 255, 255, 255), x = WaypointPosScreen.x-16, y = WaypointPosScreen.y, w = 32, h = 32})
				draw.SimpleText("<:: "..StringTable.name.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+30, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
				draw.SimpleText("<:: DISTANCE: "..DistanceFromPly.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+40, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
				if StringTable.msg and StringTable.msg != "" then
					if #StringTable.msg > charlimit then
						StringTable.msg = StringTable.msg:sub(1,charlimit).."..."
					end
					draw.SimpleText("<:: "..StringTable.msg.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+50, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
				end
			end

			hook.Add("HUDPaint", StringTable.name.."WP", MakeWaypoint)
			timer.Simple(time, function()
				hook.Remove("HUDPaint", StringTable.name.."WP")
				timer.Destroy(StringTable.name.."UpdateWPPos")
			end)
		end
	end)

	net.Receive("deathmarker", function()
		if LocalPlayer():IsCP() then
			local WaypointPos = net.ReadVector() + Vector(0,0,50)
			local StringTable = util.JSONToTable(net.ReadString())
			local time =60
			local charlimit=24
			local WaypointPosScreen = WaypointPos:ToScreen()
			local DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			timer.Create(StringTable.name.."UpdateWPPos", 0.01, time*100, function()
				WaypointPosScreen = WaypointPos:ToScreen()
				DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			end)

			function MakeWaypoint()
				draw.TexturedQuad({texture = wptexture, color = Color(255, 0, 0, 255), x = WaypointPosScreen.x-16, y = WaypointPosScreen.y, w = 32, h = 32})
				draw.SimpleText("<:: "..StringTable.name.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+30, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
				draw.SimpleText("<:: DISTANCE: "..DistanceFromPly.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+40, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
				draw.SimpleText("<:: Biosignal Loss ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+50, Color( 255, 0, 0, 255 ), TEXT_ALIGN_CENTER )
			end

			hook.Add("HUDPaint", StringTable.name.."WP", MakeWaypoint)
			timer.Simple(time, function()
				hook.Remove("HUDPaint", StringTable.name.."WP")
				timer.Destroy(StringTable.name.."UpdateWPPos")
			end)
		end
	end)

	net.Receive("requestmarker", function()
		if LocalPlayer():IsCP() then
chat.AddText(Color(100,100,255),"INCOMING REQUEST.")
surface.PlaySound("npc/overwatch/radiovoice/on3.wav")
			local WaypointPos = net.ReadVector() + Vector(0,0,50)
			local StringTable = util.JSONToTable(net.ReadString())
			local time =60
			local charlimit=24
			local WaypointPosScreen = WaypointPos:ToScreen()
			local DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			timer.Create(StringTable.name.."UpdateWPPos", 0.01, time*100, function()
				WaypointPosScreen = WaypointPos:ToScreen()
				DistanceFromPly = tostring(math.Round( WaypointPos:Distance( LocalPlayer():GetPos() ) / 28, 1 ), 1) .. " M"
			end)

			function MakeWaypoint()
				draw.TexturedQuad({texture = wptexture, color = Color(255, 102, 0, 255), x = WaypointPosScreen.x-16, y = WaypointPosScreen.y, w = 32, h = 32})
				draw.SimpleText("<:: Recent Request Signal ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+30, Color( 255, 102, 0, 255 ), TEXT_ALIGN_CENTER )
				draw.SimpleText("<:: DISTANCE: "..DistanceFromPly.." ::>", "BudgetLabel", WaypointPosScreen.x, WaypointPosScreen.y+40, Color( 255, 102, 0, 255 ), TEXT_ALIGN_CENTER )
			end

			hook.Add("HUDPaint", StringTable.name.."WP", MakeWaypoint)
			timer.Simple(time, function()
				hook.Remove("HUDPaint", StringTable.name.."WP")
				timer.Destroy(StringTable.name.."UpdateWPPos")
			end)
		end
	end)

