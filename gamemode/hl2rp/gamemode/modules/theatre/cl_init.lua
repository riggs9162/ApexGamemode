local function TheatreUI()
    local theatrePanel = vgui.Create( "DFrame" )
    theatrePanel:SetSize( 300, 400 )
    theatrePanel:Center()
    theatrePanel:SetSkin("Cortex")
    theatrePanel:SetTitle( "Theatre Control" )
    theatrePanel:SetDraggable( true )
    theatrePanel:MakePopup()

    local theatreButton = vgui.Create( "DButton", theatrePanel ) // Create the button and parent it to the frame
    theatreButton:SetText( "Toggle curtain" )	   	   	   	   	         // Set the text on the button
    theatreButton:SetPos( 25, 50 )	   	   	   	   	         // Set the position on the frame
    theatreButton:SetSize( 250, 30 )	   	   	   	   	         // Set the size
    theatreButton.DoClick = function()	   	   	   	         // A custom function run when clicked ( note the . instead of : )
	                RunConsoleCommand("hl2rp_theatre_curtaintoggle")	   	   	         // Run the console command "say hi" when you click it ( command, args )
    end
    local theatreButton = vgui.Create( "DButton", theatrePanel ) // Create the button and parent it to the frame
    theatreButton:SetText( "Turn on stage lights" )	   	   	   	   	         // Set the text on the button
    theatreButton:SetPos( 25, 80 )	   	   	   	   	         // Set the position on the frame
    theatreButton:SetSize( 250, 30 )	   	   	   	   	         // Set the size
    theatreButton.DoClick = function()	   	   	   	         // A custom function run when clicked ( note the . instead of : )
	                RunConsoleCommand("hl2rp_theatre_lightson")	   	   	         // Run the console command "say hi" when you click it ( command, args )
    end
    local theatreButton = vgui.Create( "DButton", theatrePanel ) // Create the button and parent it to the frame
    theatreButton:SetText( "Turn off stage lights" )	   	   	   	   	         // Set the text on the button
    theatreButton:SetPos( 25, 110 )	   	   	   	   	         // Set the position on the frame
    theatreButton:SetSize( 250, 30 )	   	   	   	   	         // Set the size
    theatreButton.DoClick = function()	   	   	   	         // A custom function run when clicked ( note the . instead of : )
	                RunConsoleCommand("hl2rp_theatre_lightsoff")	   	   	         // Run the console command "say hi" when you click it ( command, args )
    end

    local theatreMusicBox = vgui.Create("DComboBox", theatrePanel)
    theatreMusicBox:SetPos(25,250)
    theatreMusicBox:SetSize(250,30)
    theatreMusicBox:SetValue("Nothing Selcted")
    theatreMusicBox:AddChoice("CP Violation")
    theatreMusicBox:AddChoice("Triage at Dawn")
    theatreMusicBox:AddChoice("Beautiful Creature")
    theatreMusicBox:AddChoice("Blue Collar Citizen")
    theatreMusicBox:AddChoice("Carpenter Tribute")
    theatreMusicBox:AddChoice("Metro 5-0")
    theatreMusicBox:AddChoice("Rust Belt")

    local theatreButtonPlay = vgui.Create( "DButton", theatrePanel ) // Create the button and parent it to the frame
    theatreButtonPlay:SetText( "Play music" )	   	   	   	   	         // Set the text on the button
    theatreButtonPlay:SetPos( 25, 300 )	   	   	   	   	         // Set the position on the frame
    theatreButtonPlay:SetSize( 250, 30 )	   	   	   	   	         // Set the size
    theatreButtonPlay.DoClick = function()	   	   	   	         // A custom function run when clicked ( note the . instead of : )
	                RunConsoleCommand("hl2rp_theatre_play", theatreMusicBox:GetValue())	   	   	         // Run the console command "say hi" when you click it ( command, args )
    end

    local theatreButtonStop = vgui.Create( "DButton", theatrePanel ) // Create the button and parent it to the frame
    theatreButtonStop:SetText( "Stop music" )	   	   	   	   	         // Set the text on the button
    theatreButtonStop:SetPos( 25, 330 )	   	   	   	   	         // Set the position on the frame
    theatreButtonStop:SetSize( 250, 30 )	   	   	   	   	         // Set the size
    theatreButtonStop.DoClick = function()	   	   	   	         // A custom function run when clicked ( note the . instead of : )
	                RunConsoleCommand("hl2rp_theatre_stop")	   	   	         // Run the console command "say hi" when you click it ( command, args )
    end

end
net.Receive("APEX-THEATRE-PANEL",TheatreUI)
