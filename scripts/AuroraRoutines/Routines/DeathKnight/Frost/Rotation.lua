-- Routines/DeathKnight/Frost/Rotation.lua
return function(RoyDKNamespace)
    -- 获取常用单位
    local target = Aurora.UnitManager:Get("target")
    local player = Aurora.UnitManager:Get("player")
    
    -- 获取技能和配置
    local spells = Aurora.SpellHandler.Spellbooks.deathknight["251"].RoyDKNamespace.spells
    local auras = Aurora.SpellHandler.Spellbooks.deathknight["251"].RoyDKNamespace.auras
    local Utils = RoyDKNamespace.Utils
    
    -- 工具函数
    local function ShouldSkip()
        return player.dead or 
               player.aura("Food") or 
               player.aura("Drink") or
               player.iscasting or
               not target.exists or
               target.dead
    end
    
    local function GetRunes()
        return Utils.GetRunes()
    end
    
    local function GetRunicPower()
        return Utils.GetRunicPower()
    end
    
    local function GetEnemiesInRange(distance)
        return player.enemiesaround(distance)
    end
    
    -- 打断函数
    local function Interrupts()
        if not RoyDKNamespace.Interface.UseInterrupts:GetValue() then
            return false
        end
        
        if target.iscasting and target.casttime > 0.5 then
            if spells.MindFreeze:isready() then
                Utils.DebugPrint("使用思维冻结打断!")
                return spells.MindFreeze:execute()
            end
        end
        
        return false
    end
    
    -- 保命函数
    local function DefensiveCooldowns()
        if player.hp < 0.3 then
            if spells.AntiMagicShell:isready() then
                Utils.DebugPrint("使用反魔法护罩!")
                return spells.AntiMagicShell:execute()
            end
        end
        
        if RoyDKNamespace.Interface.UseDeathStrike:GetValue() then
            local healthThreshold = RoyDKNamespace.Interface.DeathStrikeHealth:GetValue() / 100
            if player.hp < healthThreshold and spells.DeathStrike:isready() then
                Utils.DebugPrint("使用灵界打击保命!")
                return spells.DeathStrike:execute()
            end
        end
        
        return false
    end
    
    -- 疾病管理
    local function DiseaseManagement()
        if not RoyDKNamespace.Interface.AutoDisease:GetValue() then
            return false
        end
        
        if not target.aura(auras.FrostFever) then
            if spells.Outbreak:isready() then
                Utils.DebugPrint("使用爆发上疾病")
                return spells.Outbreak:execute()
            end
            
            if spells.HowlingBlast:isready() then
                Utils.DebugPrint("使用凛风冲击上疾病")
                return spells.HowlingBlast:execute()
            end
        end
        
        return false
    end
    
    -- 冷却技能管理
    local function Cooldowns()
        if not RoyDKNamespace.Interface.UseCooldowns:GetValue() then
            return false
        end
        
        -- 冰霜之柱
        if spells.PillarOfFrost:isready() and not player.aura(auras.PillarOfFrostBuff) then
            Utils.DebugPrint("使用冰霜之柱!")
            return spells.PillarOfFrost:execute()
        end
        
        -- 符文武器增效
        if GetRunes() <= 1 and spells.EmpowerRuneWeapon:isready() then
            Utils.DebugPrint("使用符文武器增效!")
            return spells.EmpowerRuneWeapon:execute()
        end
        
        -- 辛达苟萨之息
        if RoyDKNamespace.Interface.UseBreathOfSindragosa:GetValue() then
            if GetRunicPower() >= 80 and spells.BreathOfSindragosa:isready() then
                Utils.DebugPrint("使用辛达苟萨之息!")
                return spells.BreathOfSindragosa:execute()
            end
        end
        
        return false
    end
    
    -- AOE 循环
    local function AoeRotation()
        if not RoyDKNamespace.Interface.UseAOE:GetValue() then
            return false
        end
        
        local enemyCount = GetEnemiesInRange(8)
        local aoeThreshold = RoyDKNamespace.Interface.AoeEnemies:GetValue()
        
        if enemyCount >= aoeThreshold then
            -- 冷酷严冬
            if spells.RemorselessWinter:isready() then
                Utils.DebugPrint("使用冷酷严冬 - " .. enemyCount .. " 个敌人")
                return spells.RemorselessWinter:execute()
            end
            
            -- 凛风冲击
            if spells.HowlingBlast:isready() then
                Utils.DebugPrint("使用凛风冲击AOE")
                return spells.HowlingBlast:execute()
            end
            
            -- 冰霜镰刀
            if spells.Frostscythe:isready() then
                Utils.DebugPrint("使用冰霜镰刀AOE")
                return spells.Frostscythe:execute()
            end
        end
        
        return false
    end
    
    -- 单目标输出循环
    local function SingleTarget()
        -- 检查符文和符文能量
        local runes = GetRunes()
        local runicPower = GetRunicPower()
        
        -- 湮灭（优先在有杀戮机器时使用）
        if player.aura(auras.KillingMachine) and spells.Obliterate:isready() then
            Utils.DebugPrint("使用湮灭（杀戮机器）")
            return spells.Obliterate:execute()
        end
        
        -- 凛风冲击（有白霜时）
        if player.aura(auras.Rime) and spells.HowlingBlast:isready() then
            Utils.DebugPrint("使用凛风冲击（白霜）")
            return spells.HowlingBlast:execute()
        end
        
        -- 冰霜打击（高符文能量时）
        if runicPower >= 80 and spells.FrostStrike:isready() then
            Utils.DebugPrint("使用冰霜打击")
            return spells.FrostStrike:execute()
        end
        
        -- 湮灭
        if runes >= 1 and spells.Obliterate:isready() then
            Utils.DebugPrint("使用湮灭")
            return spells.Obliterate:execute()
        end
        
        -- 冰霜打击
        if spells.FrostStrike:isready() then
            Utils.DebugPrint("使用冰霜打击")
            return spells.FrostStrike:execute()
        end
        
        return false
    end
    
    -- 非战斗行为
    local function OutOfCombat()
        -- 自动上寒冬号角
        if not player.aura(auras.HornOfWinter) and spells.HornOfWinter:isready() then
            Utils.DebugPrint("使用寒冬号角")
            return spells.HornOfWinter:execute()
        end
        
        -- 自动死亡之握拉怪
        if target.exists and target.distanceto(player) > 8 and target.distanceto(player) <= 30 then
            if spells.DeathGrip:isready() then
                Utils.DebugPrint("使用死亡之握")
                return spells.DeathGrip:execute()
            end
        end
        
        return false
    end
    
    -- 主要战斗循环
    local function CombatRotation()
        if ShouldSkip() then return false end
        
        -- 优先级顺序
        if Interrupts() then return true end
        if DefensiveCooldowns() then return true end
        if DiseaseManagement() then return true end
        if Cooldowns() then return true end
        if AoeRotation() then return true end
        if SingleTarget() then return true end
        
        -- 自动攻击
        if spells.AutoAttack:isready() then
            return spells.AutoAttack:execute()
        end
        
        return false
    end
    
    -- 注册主循环
    Aurora:RegisterRoutine(function()
        if ShouldSkip() then return end
        
        if player.combat then
            CombatRotation()
        else
            OutOfCombat()
        end
    end, "DEATHKNIGHT", 251, "RoyDKNamespace")
    
    Utils.DebugPrint("冰霜死亡骑士循环注册完成!")
end