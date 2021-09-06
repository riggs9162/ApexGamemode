hook.Add("CalcView","APEX-SPEC-RAPPEL",function(ply,pos,angles,fov)

if LocalPlayer():GetNWEntity("sh_Eyes") and IsValid(LocalPlayer():GetNWEntity("sh_Eyes")) then
local ent =  LocalPlayer():GetNWEntity("sh_Eyes")
	local view = {}

	view.origin = ent:GetPos()-(angles:Forward()*100)
	view.angles = angles
	view.fov = fov
	view.drawviewer = true

	return view


end


end)
