local entityMeta = FindMetaTable("Entity")
local playerMeta = FindMetaTable("Player")

hl2rp.net = hl2rp.net or {}
hl2rp.net.globals = hl2rp.net.globals or {}

netstream.Hook("nVar", function(index, key, value)
	hl2rp.net[index] = hl2rp.net[index] or {}
	hl2rp.net[index][key] = value
end)

netstream.Hook("nDel", function(index)
	hl2rp.net[index] = nil
end)

netstream.Hook("nLcl", function(key, value)
	hl2rp.net[LocalPlayer():EntIndex()] = hl2rp.net[LocalPlayer():EntIndex()] or {}
	hl2rp.net[LocalPlayer():EntIndex()][key] = value
end)

netstream.Hook("gVar", function(key, value)
	hl2rp.net.globals[key] = value
end)

function getNetVar(key, default)
	local value = hl2rp.net.globals[key]

	return value != nil and value or default
end

function entityMeta:getNetVar(key, default)
	local index = self:EntIndex()

	if (hl2rp.net[index] and hl2rp.net[index][key] != nil) then
		return hl2rp.net[index][key]
	end

	return default
end

playerMeta.getLocalVar = entityMeta.getNetVar