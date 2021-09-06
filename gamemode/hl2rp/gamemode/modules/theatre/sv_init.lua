sound.Add( {
	            name = "CP Violation",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "music/HL2_song20_submix4.mp3"
} )

sound.Add( {
	            name = "Triage at Dawn",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "music/hl2_song23_suitsong3.mp3"
} )

sound.Add( {
	            name = "Beautiful Creature",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "industrial17/namtran_beautifulcreature.mp3"
} )

sound.Add( {
	            name = "Blue Collar Citizen",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "industrial17/namtran_bluecollarcitizen.mp3"
} )

sound.Add( {
	            name = "Carpenter Tribute",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "industrial17/namtran_jctribute.mp3"
} )

sound.Add( {
	            name = "Metro 5-0",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "industrial17/namtran_metro.mp3"
} )

sound.Add( {
	            name = "Rust Belt",
	            channel = CHAN_AUTO,
	            volume = 1.0,
	            level = 72,
	            sound = "industrial17/namtran_rustbelt.mp3"
} )






local theatreLights = {}
local theatreLightProps = {}
local theatreLightEffects = {}


hook.Add("InitPostEntity","APEX-THEATRE-REGISTER-ENTS",function()
    for v,k in pairs(ents.GetAll()) do
        if k:GetName()=="Theatre_Speaker1" then
            Theatre_Speaker1 = k
        elseif k:GetName()=="Theatre_Speaker2" then
            Theatre_Speaker2 = k
        elseif k:GetName()=="Theatre_Lights_Prop" then
            table.insert(theatreLightProps,k)
        elseif k:GetName()=="Theatre_Lights_Spot" then
            table.insert(theatreLightEffects,k)
        elseif k:GetName()=="Theatre_Lights" then
            table.insert(theatreLights,k)
        elseif k:GetName()=="Theatre_Curtain" then
            Theatre_Curtain1 = k
        end
    end
end)

local function onStage(player)
    for v,k in pairs(ents.FindInBox(Vector(2180.750977, 971.955078, 581.941895),Vector(3128.532227, 719.656250, 46.481113))) do
        if k==player then
            return true
        end
    end
    return false
end

local function nearConsole(player)
    local console = ents.FindByClass("hl2rp_theatreconsole")[1]
    if console:GetPos():Distance(player:GetPos()) > 600 then
        return false
    else
        return true
    end

end

local function inSeats(player)
    for v,k in pairs(ents.FindInBox(Vector(2966.668701, 1104.794678, 4.784004),Vector(2468.991455, 1658.309448, 549.744568))) do
        if k==player then
            return true
        end
    end
    return false
end

local validSounds = {
    ["CP Violation"] = true,
    ["Rust Belt"] = true,
    ["Metro 5-0"] = true,
    ["Carpenter Tribute"] = true,
    ["Blue Collar Citizen"] = true,
    ["Triage at Dawn"] = true,
    ["Beautiful Creature"] = true
}

--Speaker1:EmitSound("song4")
--Speaker2:EmitSound("song4")

concommand.Add("hl2rp_theatre_play", function(ply,cmd,args)
    if not nearConsole(ply) then return end

    Theatre_Speaker1:StopSound(Theatre_Speaker1.soundscript or "")
    Theatre_Speaker2:StopSound(Theatre_Speaker2.soundscript or "")
    if validSounds[args[1]] then
        Theatre_Speaker1:EmitSound(args[1])
        Theatre_Speaker1.soundscript = args[1]
        Theatre_Speaker2:EmitSound(args[1])
        Theatre_Speaker2.soundscript = args[1]
    end

end)

concommand.Add("hl2rp_theatre_stop", function(ply,cmd,args)
    if not nearConsole(ply) then return end
    Theatre_Speaker1:StopSound(Theatre_Speaker1.soundscript or "")
    Theatre_Speaker2:StopSound(Theatre_Speaker2.soundscript or "")
end)

concommand.Add("hl2rp_theatre_curtaintoggle", function(ply,cmd,args)
    if not nearConsole(ply) then return end
    Theatre_Curtain1:Fire("toggle")
end)

concommand.Add("hl2rp_theatre_lightsoff", function(ply,cmd,args)
    if not nearConsole(ply) then return end

    for v,k in pairs(theatreLights) do
        k:Fire("turnoff")
    end
    for v,k in pairs(theatreLightProps) do
        k:SetSkin(1)
    end
    for v,k in pairs(theatreLightEffects) do
        k:Fire("lightoff")
    end

end)

concommand.Add("hl2rp_theatre_lightson", function(ply,cmd,args)
    if not nearConsole(ply) then return end

    for v,k in pairs(theatreLights) do
        k:Fire("turnon")
    end
    for v,k in pairs(theatreLightProps) do
        k:SetSkin(0)
    end
    for v,k in pairs(theatreLightEffects) do
        k:Fire("lighton")
    end

end)

hook.Add("PlayerCanHearPlayersVoice","APEX-THEATRE-VOICE",function(recip,trans)
    if onStage(trans) and inSeats(recip) then
        return true
    end
end)

print("Loaded Vins Theatre System")

