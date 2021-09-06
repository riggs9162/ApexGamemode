local ADJUST_SOUND = SoundDuration("npc/metropolice/pain1.wav") > 0 and "" or "../../hl2/sound/"

function emitQueuedSounds(entity, sounds, delay, spacing, volume, pitch)
	-- Let there be a delay before any sound is played.
	delay = delay or 0
	spacing = spacing or 0.1

	-- Loop through all of the sounds.
	for k, v in ipairs(sounds) do
		local postSet, preSet = 0, 0

		-- Determine if this sound has special time offsets.
		if (type(v) == "table") then
			postSet, preSet = v[2] or 0, v[3] or 0
			v = v[1]
		end

		-- Get the length of the sound.
		local length = SoundDuration(ADJUST_SOUND..v)
		-- If the sound has a pause before it is played, add it here.
		delay = delay + preSet

		-- Have the sound play in the future.
		timer.Simple(delay, function()
			-- Check if the entity still exists and play the sound.
			if (IsValid(entity)) then
				entity:EmitSound(v, volume, pitch)
			end
		end)

		-- Add the delay for the next sound.
		delay = delay + length + postSet + spacing
	end

	-- Return how long it took for the whole thing.
	return delay
end

netstream.Hook("voicePlay", function(sounds, volume, index)
	if (index) then
		local client = Entity(index)

		if (IsValid(client)) then
			emitQueuedSounds(client, sounds, nil, nil, volume)
		end
	else
		emitQueuedSounds(LocalPlayer(), sounds, nil, nil, volume)
	end
end)

netstream.Hook("voicePlay1", function(sounds, volume, index)
if LocalPlayer():Team() == TEAM_CP or LocalPlayer():Team() == TEAM_OVERWATCH or LocalPlayer():Team() == TEAM_ADMINISTRATOR or LocalPlayer():Team() == TEAM_DISPATCH then
	if (index) then
		local client = Entity(index)

		if (IsValid(client)) then
			emitQueuedSounds(client, sounds, nil, nil, volume)
		end
	else
		emitQueuedSounds(LocalPlayer(), sounds, nil, nil, volume)
	end
end
end)