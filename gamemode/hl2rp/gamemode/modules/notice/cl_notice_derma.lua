surface.CreateFont( "NoticeFont", {
	font = "BITSTREAM VERA SANS", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 16.2,
	weight = 2000,
	antialias = true
} )


local PANEL = {}

	function PANEL:Init()
		self:SetSize(256, 30)
		self:SetContentAlignment(5)
		self:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self:SetFont("NoticeFont")
		self:SetTextColor(color_white)
	end

	function PANEL:Paint(w, h)

		surface.SetDrawColor(230, 230, 230, 10)
		surface.DrawRect(0, 0, w, h)

		if (self.start) then
			local w2 = math.TimeFraction(self.start, self.endTime, CurTime()) * w

			surface.SetDrawColor(Color( 0, 0, 0, 230 ))
			surface.DrawRect(0, 0, w, h)
			surface.SetDrawColor(Color(255,255,255))
			surface.DrawRect(w2, h-2, w - w2, 2)
		end

		surface.SetDrawColor(0, 0, 0, 45)
		surface.DrawOutlinedRect(0, 0, w, h)
	end
vgui.Register("DNotice", PANEL, "DLabel")