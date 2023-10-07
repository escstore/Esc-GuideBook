
function checkVersion() 
    local versionUrl = "https://raw.githubusercontent.com/escstore/Check-Version/main/Esc-GuideBook.json"
    local fxVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)
    PerformHttpRequest(versionUrl, function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            local data = json.decode(resultData)
            if data and data.version and data.version > fxVersion then
				print("^5=======================================")
                print("^2[Esc-LoadingScreen] - New update available now!")
                print("^7Current version: ^5" .. fxVersion)
                print("^7New version: ^5" .. data.version) 
                print("^7What does the latest version Contains: ^5" .. data.New)
				print("^0\n^5Download it now on your keymaster.fivem.net")
				print("^5=======================================")
            else
                print("^2You have the latest version of the script!^2")
            end
        else
            print("^1Error checking for new version: ^1" .. tostring(errorCode))
        end
    end, "GET", "", {})
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
        checkVersion()
        Citizen.Wait(800000)
    end
end)
