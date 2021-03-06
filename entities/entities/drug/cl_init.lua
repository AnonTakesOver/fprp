include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or fprp.getPhrase("unknown")

	surface.SetFont("HUDNumber5")
	local text = fprp.getPhrase("drugs")
	local text2 = fprp.getPhrase("priceTag", fprp.formatMoney(self:Getprice()), "")
	local TextWidth = surface.GetTextSize(text)
	local TextWidth2 = surface.GetTextSize(text2)

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang

	TextAng:RotateAroundAxis(TextAng:Right(), CurTime() * -180)

	cam.Start3D2D(Pos + Ang:Right() * -15, TextAng, 0.1)
		draw.WordBox(2, -TextWidth*0.5 + 5, -30, text, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(2, -TextWidth2*0.5 + 5, 18, text2, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
end

function ENT:Think()
end

local function drugEffects(um)
	local toggle = um:ReadBool()

	if toggle then
		hook.Add("RenderScreenspaceEffects", "drugged", function()
			DrawSharpen(-1, 2)
			DrawMaterialOverlay("models/props_lab/Tank_Glass001", 0)
			DrawMotionBlur(0.13, 1, 0.00)
		end)
	else
		hook.Remove("RenderScreenspaceEffects", "drugged")
	end
end
usermessage.Hook("DrugEffects", drugEffects)