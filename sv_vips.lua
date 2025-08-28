local QBCore = exports['qb-core']:GetCoreObject()

local VipTbCooldown = {} -- tabela de controle de pagamentos vips
local VipCooldownTime = 30 -- minutos 

local founderdonater = exports.Badger_Discord_API:GetRoleIdFromRoleName("Founder Donater")
local flamingo = exports.Badger_Discord_API:GetRoleIdFromRoleName("Flamingo") 
local hollywood = exports.Badger_Discord_API:GetRoleIdFromRoleName("Hollywood") 
local walkoffame = exports.Badger_Discord_API:GetRoleIdFromRoleName("Walk Of Fame") 
local rockstar = exports.Badger_Discord_API:GetRoleIdFromRoleName("Rock Star") 
local subcelebrity = exports.Badger_Discord_API:GetRoleIdFromRoleName("Sub Celebrity") 
local plus = exports.Badger_Discord_API:GetRoleIdFromRoleName("+")
local officialcreator = exports.Badger_Discord_API:GetRoleIdFromRoleName("Official Creator")
local booster = exports.Badger_Discord_API:GetRoleIdFromRoleName("Server Booster")     

function CheckVips(source, cb)
    local src = source
    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
    local check = false

    if not (roleIDs == false) then
        for i = 1, #roleIDs do
            if exports.Badger_Discord_API:CheckEqual(roleIDs[i], founderdonater) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], flamingo) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], hollywood) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], walkoffame) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], rockstar) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], subcelebrity) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], plus) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], officialcreator) then
                check = true
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], booster) then
                check = true
            end
        end
        cb(check)
    else
        cb(false)
    end
end

QBCore.Functions.CreateCallback('Cali-Vips:Server:CheckVips', function(source, cb)
    CheckVips(source, cb)
end)

exports("CheckVips", CheckVips)

RegisterServerEvent('Cali-Vips:Server:PagamentoVip', function()
    local src = source
    local Player =  QBCore.Functions.GetPlayer(src)
    if not Player then return false end
    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
    local VipMoney = 0
    local VipNome = ""

    if not (roleIDs == false) then
        for i = 1, #roleIDs do
            if exports.Badger_Discord_API:CheckEqual(roleIDs[i], founderdonater) then
                VipMoney = VipMoney + Config.ValorVip.FounderDonater
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  💎 Founder Donater  \n"
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], flamingo) then
                VipMoney = VipMoney + Config.ValorVip.Flamingo
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  🦩 Flamingo   \n"  
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], hollywood) then
                VipMoney = VipMoney + Config.ValorVip.Hollywood
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  👑 Hollywood  \n"  
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], walkoffame) then
                VipMoney = VipMoney + Config.ValorVip.WalkOfFame
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  📀 Walk Of Fame  \n"
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], rockstar) then
                VipMoney = VipMoney + Config.ValorVip.RockStar
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  🎸 Rock Star  \n"
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], subcelebrity) then
                VipMoney = VipMoney + Config.ValorVip.SubCelebrity
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  🎙️ Sub Celebrity  \n"
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], plus) then
                VipMoney = VipMoney + Config.ValorVip.Plus
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  ➕ +  \n"
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], officialcreator) then
                VipMoney = VipMoney + Config.ValorVip.OfficialCreator
                VipMoney = VipMoney + 500 -- semana buff
                VipNome = ""..VipNome.."  🟣 Official Creator \n "
            elseif exports.Badger_Discord_API:CheckEqual(roleIDs[i], booster) then
                VipMoney = VipMoney + Config.ValorVip.Booster
                VipNome = ""..VipNome.."  🔵 Booster  \n"
            end
        end
    

        local DName = exports.Badger_Discord_API:GetDiscordName(src) 
        local DFoto = exports.Badger_Discord_API:GetDiscordAvatar(src)
        local license = QBCore.Functions.GetIdentifier(src, 'license') 
        


        if not VipTbCooldown[src] then
            VipTbCooldown[src] = os.time() + (VipCooldownTime * 60)
        else
            if VipTbCooldown[src] and VipTbCooldown[src] <= os.time() then
                Player.Functions.AddMoney("bank", VipMoney)
                
                local VBankAntigo = Player.PlayerData.money['bank']
                local VBankNovo = (Player.PlayerData.money['bank'] + VipMoney)
                PagamentoVipLog( "**🧍‍♂️ [Player Information]** " .. "\n" ..  "**Player Name:** "..Player.PlayerData.name.. "\n" ..  "**Player ID:** "..Player.PlayerData.citizenid.. "\n" ..  "**Player License:** "..license.. "\n" ..  "**Nome do Discord:** "..DName.. "\n" ..  "**Valor Pago:** $"..VipMoney.. "\n" ..  "**Valor Antigo do Banco:** $"..VBankAntigo.. "\n" ..  "**Valor Novo do Banco:** $"..VBankNovo.. "\n" ..  "**Tags Vips:** \n"..VipNome)

                TriggerClientEvent('okokNotify:Alert', src, 'Salário', "Você recebeu um salário de $"..VipMoney.." pelo seu vip "..VipNome.."!", 5000, "success")

                -- renova o cooldown
                VipTbCooldown[src] = os.time() + (VipCooldownTime * 60)
            end
        end
    end
end)

-- LOGS

function PagamentoVipLog(message)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- Verde = 65280 --- Vermelho = 16711680
            ["title"] = "Pagamento Vips | Logs",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["text"] = 'Caso exista alguém com salário de vip sem ter | Avise aos DEVs',
            },
        }
    }
    PerformHttpRequest(Config.Webhook, 
    function(err, text, headers) end, 'POST', json.encode({username = 'Pagamento Vips - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end