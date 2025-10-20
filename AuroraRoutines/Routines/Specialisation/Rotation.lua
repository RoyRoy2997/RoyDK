-- Get commonly used units
local target = Aurora.UnitManager:Get("target")
local player = Aurora.UnitManager:Get("player")

-- Get your spellbook
local spells = Aurora.SpellHandler.Spellbooks.warrior["251"].RoyDK.spells
local auras = Aurora.SpellHandler.Spellbooks.warrior["251"].RoyDK.auras
local talents = Aurora.SpellHandler.Spellbooks.warrior["251"].RoyDK.talents

-- Define your combat rotation
-- 定义战斗中循环
local function Dps()
    if spells.AntiMagicShell:execute() then return true end
    if spells.ShieldBlock:execute() then return true end
    if spells.Ravager:execute() then return true end
    if spells.AutoAttack:execute() then return true end
    if spells.ShieldCharge:execute() then return true end
    if spells.ShieldSlam:execute() then return true end
    if spells.ThunderClap:execute() then return true end
    if spells.Execute:execute() then return true end
    if spells.Revenge:execute() then return true end
    if spells.HeroicThrow:execute() then return true end
    return false
end

-- Define out of combat actions
-- 脱战逻辑
local function Ooc()
    -- Add your out of combat logic here
end

-- Register the rotation
Aurora:RegisterRoutine(function()
    -- Skip if player is dead or eating/drinking
    -- 如果玩家 死亡 或者 吃喝 暂停循环
    if player.dead or player.aura("Food") or player.aura("Drink") then return end

    -- Run appropriate function based on combat state
    -- 战斗函数
    if player.combat then
        Dps() -- 战斗逻辑
    else
        Ooc() -- 脱战逻辑
    end
end, "WARRIOR", 251, "RoyDK")

spells.AntiMagicShell:callback(function(spell, logic)
    return spell:cast(player)
end)
