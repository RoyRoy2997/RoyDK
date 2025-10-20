-- Routines/DeathKnight/Frost/Spellbook.lua
return function(RoyDKNamespace)
    -- 创建法术书
    local NewSpell = Aurora.SpellHandler.NewSpell
    
    Aurora.SpellHandler.PopulateSpellbook({
        spells = {
            -- 主要输出技能
            FrostStrike = NewSpell(49143),          -- 冰霜打击
            Obliterate = NewSpell(49020),           -- 湮灭
            HowlingBlast = NewSpell(49184),         -- 凛风冲击
            RemorselessWinter = NewSpell(196770),   -- 冷酷严冬
            Frostscythe = NewSpell(207230),         -- 冰霜镰刀
            HornOfWinter = NewSpell(57330),         -- 寒冬号角
            
            -- 疾病技能
            Outbreak = NewSpell(77575),             -- 爆发
            FrostFever = NewSpell(55095),           -- 冰霜热疫
            
            -- 冷却技能
            PillarOfFrost = NewSpell(51271),        -- 冰霜之柱
            EmpowerRuneWeapon = NewSpell(47568),    -- 符文武器增效
            BreathOfSindragosa = NewSpell(152279),  -- 辛达苟萨之息
            
            -- 工具技能
            DeathGrip = NewSpell(49576),            -- 死亡之握
            MindFreeze = NewSpell(47528),           -- 思维冻结
            AntiMagicShell = NewSpell(48707),       -- 反魔法护罩
            DeathStrike = NewSpell(49998),          -- 灵界打击（保命）
            RaiseDead = NewSpell(46584),            -- 复活死者
            
            -- 自动攻击
            AutoAttack = NewSpell(6603)
        },
        auras = {
            -- 增益效果
            PillarOfFrostBuff = 51271,
            KillingMachine = 51124,
            Rime = 59052,
            
            -- 疾病效果
            FrostFever = 55095,
            
            -- 其他效果
            HornOfWinter = 57330
        },
        talents = {
            -- 这里可以添加天赋检测
        }
    }, "DEATHKNIGHT", 251, "RoyDKNamespace")
    
    RoyDKNamespace.Utils.DebugPrint("冰霜DK技能书加载完成!")
end