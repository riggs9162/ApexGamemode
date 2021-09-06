local plyMeta = FindMetaTable("Player")

/*---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------*/
function plyMeta:isArrested()
	return self:getDarkRPVar("Arrested")
end