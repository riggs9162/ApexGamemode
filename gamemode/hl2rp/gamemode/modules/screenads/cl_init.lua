-- this code is rushed and messy>watch out>very scare


local NotifyPanel = vgui.Create( "DNotify" )
NotifyPanel:SetPos( 20, 10 )
NotifyPanel:SetSize( 1000, 40 )

-- Text label
local Adlbl = vgui.Create( "DLabel", NotifyPanel )
Adlbl:Dock( FILL )
Adlbl:SetText( "Loading..." )
Adlbl:SetFont( "GModNotify" )
Adlbl:SetTextColor(Color(255,255,255,255))


-- Add the label to the notification and begin fading
NotifyPanel:AddItem( Adlbl )

function ChangeAd(text,col)

local Adlbl = vgui.Create( "DLabel", NotifyPanel )
Adlbl:Dock( FILL )
Adlbl:SetText(text)
Adlbl:SetTextColor(col)
Adlbl:SetFont( "GModNotify" )

NotifyPanel:SetLife(12)
NotifyPanel:AddItem( Adlbl )



end

local screenAds = {
"Join us on Discord by typing discord.apex-roleplay.com into your browser.",
"Connect with us online, goto apex-roleplay.com",
"Want to donate? Type !vip in chat."

}
timer.Create("apex-screen-ads",300,0,function()
ChangeAd(screenAds[math.random(1,3)],Color(255,255,255,255))

end)
