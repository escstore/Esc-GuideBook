local display = false

function OpenUI()
    display = true
    SetNuiFocus(true, true)
    SendNUIMessage({ showUI = true })
    Citizen.Wait(0)
    DisplayRadar(false)
end

RegisterNUICallback("CloseUi",function(data, cb)
    display = false
    SetNuiFocus(false, false)
    Citizen.Wait(0)
    DisplayRadar(true)
end)

RegisterCommand(Config.OpenMenuCommand, function()
    if not display then
        OpenUI()
    end
end)


RegisterKeyMapping(Config.OpenMenuCommand, 'Open the UI', 'keyboard', Config.OpenMenuKeyBind)


Citizen.CreateThread(function()
	if Config.ShowBlips then
		Citizen.Wait(2000)
		for k,v in ipairs(Config.Locations)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipScale)
			SetBlipColour (blip, v.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

function NearGuide()
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for k, v in pairs(Config.Locations) do
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)

        if dist <= v.Distance then
            return true
        elseif dist <= v.Distance + 5 then
        	return "update"
        end
    end
end

Citizen.CreateThread(function()
	local inRange = false
	local shown = false

    while true do
    	inRange = false
        Citizen.Wait(0)
        if NearGuide() and not isBankOpened and NearGuide() ~= "update" then
            inRange = true

            if IsControlJustReleased(0, 38) then
                SetNuiFocus(true, true)
                OpenUI()
            end
        elseif NearGuide() == "update" then
        	Citizen.Wait(300)
            
        else
        	Citizen.Wait(1000)
        end

        if inRange and not shown then
        	shown = true
        	if Config.EscTextUI then
        		exports['EscTextUI']:Open('[E] To access the GuideBook', 'darkblue', 'left')
            else
        		TriggerEvent('QBCore:Notify', "Press E to access the GuideBook", "success")
        	end
        elseif not inRange and shown then
        	shown = false
        	if Config.EscTextUI then
        		exports['EscTextUI']:Close()
        	end
        end
    end
end)

