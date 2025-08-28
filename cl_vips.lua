local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function() -- Pagamento Vip
    while true do
        Citizen.Wait(60000) -- 1 minuto... 
        if LocalPlayer.state.isLoggedIn then -- statebag de verificação do qb-core
            QBCore.Functions.TriggerCallback('Cali-Vips:Server:CheckVips', function(result)
                if result == true then
                    TriggerServerEvent("Cali-Vips:Server:PagamentoVip")
                end
            end)
        end
    end
end)