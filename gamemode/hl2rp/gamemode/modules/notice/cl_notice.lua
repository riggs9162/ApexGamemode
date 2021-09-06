
net.Receive( "ClientNotice", function( len, ply )
	 print( "I got it!" )
end )


	-- List of notice panels.
	notices = notices or {}

	-- Create a notification panel.
	function clientnotify(message)
		local notice = vgui.Create("DNotice")
		local i = table.insert(notices, notice)
		local scrW = ScrW()

		-- Set up information for the notice.
		notice:SetText(message)
		notice:SetPos(ScrW(), ScrH() - (i - 1) * (notice:GetTall() + 4) + 4)
		notice:SizeToContentsX()
		notice:SetWide(notice:GetWide() + 16)
		notice.start = CurTime() + 0.25
		notice.endTime = CurTime() + 7.75

		-- Move all notices to their proper positions.
		local function OrganizeNotices()
			for k, v in ipairs(notices) do
				v:MoveTo(scrW - (v:GetWide()), ScrH() - 40 - ( k - i ) * ( v:GetTall() + 12 ) - i * ( v:GetTall() + 12 ), 0.15, (k / #notices) * 0.25, nil)
			end
		end

		-- Add the notice we made to the list.
		OrganizeNotices()

		-- Show the notification in the console.
		MsgC(Color(0, 255, 255), message.."\n")

		-- Once the notice appears, make a sound and message.
		timer.Simple(0.15, function()
			surface.PlaySound("buttons/lightswitch2.wav")
		end)

		-- After the notice has displayed for 7.5 seconds, remove it.
		timer.Simple(7.75, function()
			if (IsValid(notice)) then
				-- Search for the notice to remove.
				for k, v in ipairs(notices) do
					if (v == notice) then
						-- Move the notice off the screen.
						notice:MoveTo(ScrW(), notice.y, 0.15, 0.1, nil, function()
							notice:Remove()
						end)

						-- Remove the notice from the list and move other notices.
						table.remove(notices, k)
						OrganizeNotices()

						break
					end
				end
			end
		end)
	end

net.Receive( "ClientNotice", function()
	 local string = net.ReadString()
	 clientnotify(string)
end )