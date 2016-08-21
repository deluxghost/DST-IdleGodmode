local require = GLOBAL.require
local Builder = require "components/builder"

GLOBAL.goidle = function()
    IdleGodmode()
end

function IdleGodmode()
    for k,v in pairs(GLOBAL.AllPlayers) do
        if v ~= nil then
            if v:HasTag("playerghost") then
                v.components.sanity.ignore = false
                v:PushEvent("respawnfromghost")
            end
            if v.components.beaverness ~= nil then
                v.components.beaverness:SetPercent(1)
            end
            v.components.health:SetPercent(1)
            v.components.hunger:SetPercent(1)
            v.components.sanity:SetPercent(1)
            v.components.temperature:SetTemperature(25)
            v.components.moisture:SetPercent(0)
            v.components.health:SetInvincible(true)
            v.components.builder.freebuildmode = true
            v:PushEvent("unlockrecipe")
        end
    end
    print("<IdleGodmode>Ready to idle!")
end

AddPrefabPostInit("world", function(inst)
    inst:ListenForEvent("ms_playerjoined", function(inst, player)
        IdleGodmode()
    end)
end)