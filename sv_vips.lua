local QBCore = exports['qb-core']:GetCoreObject()

local vipCooldowns = {}
local vipCooldownTime = 30 -- minutos

-- Tabela de cargos e suas configs (id será preenchido pela API)
local vipRoles = {
    ["Founder Donater"] = { id = nil, value = Config.ValorVip.FounderDonater, buff = 500, icon = "💎" },
    ["Flamingo"] = { id = nil, value = Config.ValorVip.Flamingo, buff = 500, icon = "🦩" },
    ["Hollywood"] = { id = nil, value = Config.ValorVip.Hollywood, buff = 500, icon = "👑" },
    ["Walk Of Fame"] = { id = nil, value = Config.ValorVip.WalkOfFame, buff = 500, icon = "📀" },
    ["Rock Star"] = { id = nil, value = Config.ValorVip.RockStar, buff = 500, icon = "🎸" },
    ["Sub Celebrity"] = { id = nil, value = Config.ValorVip.SubCelebrity, buff = 500, icon = "🎙️" },
    ["+"] = { id = nil, value = Config.ValorVip.Plus, buff = 500, icon = "➕" },
    ["Official Creator"] = { id = nil, value = Config.ValorVip.OfficialCreator, buff = 500, icon = "🟣" },
    ["Server Booster"] = { id = nil, value = Config.ValorVip.Booster, buff = 0, icon = "🔵" },
}

for roleName, data in pairs(vipRoles) do
    vipRoles[roleName].id = exports.Badger_Discord_API:GetRoleIdFromRoleName(roleName)
end

local function CheckVips(src, cb)
    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roleIDs or roleIDs == false then return cb(false) end

    for _, roleId in ipairs(roleIDs) do
        for _, data in pairs(vipRoles) do
            if exports.Badger_Discord_API:CheckEqual(roleId, data.id) then
                return cb(true)
            end
        end
    end
    cb(false)
end

QBCore.Functions.CreateCallback('Cali-Vips:Server:CheckVips', function(source, cb)
    CheckVips(source, cb)
end)

exports("CheckVips", CheckVips)


RegisterServerEvent('Cali-Vips:Server:PagamentoVip', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
    if not roleIDs or roleIDs == false then return end

    local vipMoney, vipNames = 0, ""

    for _, roleId in ipairs(roleIDs) do
        for roleName, data in pairs(vipRoles) do
            if exports.Badger_Discord_API:CheckEqual(roleId, data.id) then
                vipMoney = vipMoney + data.value + (data.buff or 0)
                vipNames = vipNames .. string.format("  %s %s\n", data.icon, roleName)
            end
        end
    end

    if vipMoney > 0 then
        if not vipCooldowns[src] then
            vipCooldowns[src] = os.time() + (vipCooldownTime * 60)
        elseif vipCooldowns[src] <= os.time() then
            Player.Functions.AddMoney("bank", vipMoney)

            local bankAntigo = Player.PlayerData.money['bank']
            local bankNovo = bankAntigo + vipMoney

            local license = QBCore.Functions.GetIdentifier(src, 'license')
            local discordName = exports.Badger_Discord_API:GetDiscordName(src)
            local discordAvatar = exports.Badger_Discord_API:GetDiscordAvatar(src)


            PagamentoVipLog(string.format([[
            **🧍‍♂️ [Player Information]**
            **Player Name:** %s
            **Player ID:** %s
            **Player License:** %s
            **Nome do Discord:** %s
            **Valor Pago:** $%d
            **Valor Antigo do Banco:** $%d
            **Valor Novo do Banco:** $%d
            **Tags Vips:**
            %s
            ]], Player.PlayerData.name, Player.PlayerData.citizenid, license, discordName, vipMoney, bankAntigo, bankNovo, vipNames))

            TriggerClientEvent('okokNotify:Alert', src, 'Salário', ("Você recebeu um salário de $%d pelo seu VIP:\n%s"):format(vipMoney, vipNames), 5000, "success")

            vipCooldowns[src] = os.time() + (vipCooldownTime * 60)
        end
    end
end)


function PagamentoVipLog(message)
    local embed = {
        {
            ["color"] = 65280, -- Verde
            ["title"] = "Pagamento Vips | Logs",
            ["description"] = message,
            ["footer"] = { ["text"] = "Caso exista alguém recebendo salário sem VIP, avise os DEVs" },
        }
    }
    PerformHttpRequest(Config.Webhook, function() end, 'POST', json.encode({username = 'Pagamento Vips - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end
