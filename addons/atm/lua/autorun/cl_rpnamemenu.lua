local CommunityName = "crowNetwork"



//properties
properties.Add( "forcename", 
{
	MenuLabel	=	"Force Namechange",
	Order		=	1,
	MenuIcon	=	"icon16/comment_edit.png",
	
	Filter		=	function( self, ent, ply ) 
				
						if ( !IsValid( ent ) || !IsValid( ply ) ) then return false end
						if ( !ent:IsPlayer() ) then return false end
						if ( !ply:IsAdmin() ) then return false end
						
						return true 

					end,
					
	Action		=	function( self, ent )
	
						self:MsgStart()
							net.WriteEntity( ent )
						self:MsgEnd()
						
					end,
					
	Receive		=	function( self, length, player )
					
						local ent = net.ReadEntity()
						
						umsg.Start("_Notify", ent)
							umsg.String("Your name violates our rules. Change it.")
							umsg.Short(1)
							umsg.Long(10)
						umsg.End()
						ent.ForcedNameChange = true
						umsg.Start("openRPNameMenu", ent)
						umsg.End()

						umsg.Start("_Notify", player)
							umsg.String("Forced.")
							umsg.Short(1)
							umsg.Long(10)
						umsg.End()
						
					end	

})
if SERVER then AddCSLuaFile() return end
	
local IconCorrect, IconIncorrect = Material("icon16/accept.png"), Material("icon16/cross.png")
local NameMenu
local function OpenRPNameMenu()
	local DTextEntry1, DTextEntry2, DButton1
	if NameMenu and NameMenu:IsValid() then NameMenu:Remove() end
	NameMenu = vgui.Create("DFrame")
	NameMenu:SetSize(550, 300)
	NameMenu:SetTitle("Set your RP Name")
	NameMenu:Center()
	NameMenu:ShowCloseButton(false)
	NameMenu:MakePopup()
	NameMenu.Paint = function(self, w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
		draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame
		draw.SimpleText("Before you can continue you have to set a name.", "DermaDefault", self:GetWide()*0.5, 90, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Be sure the name does not break any rules.", "DermaDefault", self:GetWide()*0.5, 100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
		
		draw.SimpleText("First Name", "DermaDefault", NameMenu:GetWide()*0.5, 137, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		draw.SimpleText("Last Name", "DermaDefault", NameMenu:GetWide()*0.5, 187, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
		
		surface.SetDrawColor(255, 255, 255, 255)
		if DTextEntry1.Correct then
			surface.SetMaterial(IconCorrect)
			surface.DrawTexturedRect(333, 157, 16, 16)
		else
			surface.SetMaterial(IconIncorrect)
			surface.DrawTexturedRect(333, 157, 16, 16)
		end
		if DTextEntry2.Correct then
			surface.SetMaterial(IconCorrect)
			surface.DrawTexturedRect(333, 207, 16, 16)
		else
			surface.SetMaterial(IconIncorrect)
			surface.DrawTexturedRect(333, 207, 16, 16)
		end
		
		surface.SetDrawColor(175, 175, 175, 255)
		surface.DrawRect(self:GetWide()*0.5-56, 154, 112, 22)
		surface.DrawRect(self:GetWide()*0.5-56, 204, 112, 22)
		
	end

	local allowed, correct = {"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m", " "}

	DTextEntry1 = vgui.Create("DTextEntry", NameMenu)
	DTextEntry1:SetSize(110, 20)
	DTextEntry1:SetPos(NameMenu:GetWide()*0.5-55, 155)
	DTextEntry1.Think = function(self)
	local text = self:GetValue()

	correct = true
	if text:len() < 3 then correct = false end
	for k in string.gmatch(text, ".") do
		if not table.HasValue(allowed, string.lower(k)) then

			correct = false
			break
		end
	end
	self.Correct = (text != " " and text != "") and correct or false



	end

	DTextEntry2 = vgui.Create("DTextEntry", NameMenu)
	DTextEntry2:SetSize(110, 20)
	DTextEntry2:SetPos(NameMenu:GetWide()*0.5-55, 205)
	DTextEntry2.Think = function(self)
	local text = self:GetValue()

	correct = true
	if text:len() < 3 then correct = false end
	for k in string.gmatch(text, ".") do
		if not table.HasValue(allowed, string.lower(k)) then

			correct = false
			break
		end
	end
	self.Correct = (text != " " and text != "") and correct or false



	end

	DButton1 = vgui.Create("DButton", NameMenu)
	DButton1:SetSize(80, 25)
	DButton1:SetPos(NameMenu:GetWide()*0.5-DButton1:GetWide()*0.5, NameMenu:GetTall()*0.85)
	DButton1:SetText("Done")

	DButton1.DoClick = function(self)
		if !DTextEntry1.Correct or !DTextEntry2.Correct then return end
		local text = DTextEntry1:GetValue().." "..DTextEntry2:GetValue()
		RunConsoleCommand("c_rpname", text)
		NameMenu:Remove()
	end
	DButton1.Think = function(self)
		local textlower = string.lower(DTextEntry1:GetValue().." "..DTextEntry2:GetValue())
		if textlower:len() > 30 or !DTextEntry1.Correct or !DTextEntry2.Correct or string.match(textlower, "nigger") or string.match(textlower, "fag") or string.match(textlower, "brony") or string.match(textlower, "owner") or string.match(textlower, "admin") or string.match(textlower, "ben dover") or string.match(textlower, "bend over") then
			self:SetDisabled(true)
			return
		else
			self:SetDisabled(false)
		end
	end
	DButton1.OnCursorEntered = function(self)
		self.MouseOver = true
	end
	DButton1.OnCursorExited = function(self)
		self.MouseOver = false
	end
end
usermessage.Hook("openRPNameMenu", OpenRPNameMenu)
//©Tomasas 2013