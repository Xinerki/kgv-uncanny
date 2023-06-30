CreateThread(function()
	local boneId = 31086

	RequestStreamedTextureDict("uhhh")

	while not HasStreamedTextureDictLoaded("uhh") do
		Wait(0)
	end
	
	while true do
		local playerPed = PlayerPedId()
		local pool = GetGamePool("CPed")
		local camCoord = GetFinalRenderedCamCoord()

		table.sort(pool, function(a, b) return #(GetEntityCoords(a) - camCoord) > #(GetEntityCoords(b) - camCoord) end)
		
		for i,v in pairs(pool) do
			local pos = GetWorldPositionOfEntityBone(v, GetPedBoneIndex(v, boneId))
			local dist = #(camCoord - pos)
			local visible = IsEntityVisible(v)
			local los = HasEntityClearLosToEntity(playerPed, v, 17) or v == playerPed
			
			if dist < 50.0 and los and visible then
				local ratio = GetAspectRatio()
				local scale = (1.0/dist) * (1.0/GetFinalRenderedCamFov()) * 12.0

				SetDrawOrigin(pos)
				DrawSprite("uhhh", IsPedAPlayer(v) and "canny" or "uncanny", 0.0, 0.0, scale, scale * ratio, 0.0, 255, 255, 255, 255)
				ClearDrawOrigin()
			end
		end

		Wait(0)
	end

	SetStreamedTextureDictAsNoLongerNeeded("uhhh")
end)
