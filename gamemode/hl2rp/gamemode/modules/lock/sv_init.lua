local DoorPos =
{
   Vector( 2030.031250, 4033.666016, -239.968750),
   Vector( 2029.031250, 3836.281982, -239.968750),
   Vector( 2570.968750, 3701.518311, -239.968750),
   Vector( -7802.000000, -5313.919922, 60.250000),
   Vector( 2570.968750, 4099.169922, -239.968750),

}

local DoorName =
{
   [ "prop_door_rotating" ] = true,
}

local SearchRadius = 40

hook.Add( "InitPostEntity", "LockDoors", function()
   for _, vec in ipairs( DoorPos ) do
      for _, door in ipairs( ents.FindInSphere( vec, SearchRadius ) ) do
         if ( IsValid( door ) and DoorName[ door:GetClass() ] ) then
            door:Fire( "lock" )
         end
      end
   end
end )











--[[local DoorGroup =
{
   "Civil Protection"
}

hook.Add( "InitPostEntity", "LockDoors", function()
    for _, door(ents.GetAll()) do
        if ( IsValid( door ) and door.getKeysDoorGroup and door:getKeysDoorGroup() == table.HasValue(DoorGroup)  ) then
            door:Fire( "lock" )
        end
    end
end )]]--