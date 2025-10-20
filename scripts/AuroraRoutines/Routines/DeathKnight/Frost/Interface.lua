-- Routines/DeathKnight/Frost/Interface.lua
return function(RoyDKNamespace)
    -- 创建配置界面
    RoyDKNamespace.Interface = {
        -- AOE 设置
        UseAOE = Aurora.Interface:CreateCheckbox("启用AOE", true),
        AoeEnemies = Aurora.Interface:CreateSlider("AOE敌人数量", 2, 1, 5, 1),
        
        -- 冷却技能设置
        UseCooldowns = Aurora.Interface:CreateCheckbox("使用冷却技能", true),
        UseBreathOfSindragosa = Aurora.Interface:CreateCheckbox("使用辛达苟萨之息", true),
        
        -- 保命设置
        UseDeathStrike = Aurora.Interface:CreateCheckbox("自动灵界打击", true),
        DeathStrikeHealth = Aurora.Interface:CreateSlider("灵界打击血量%", 50, 30, 80, 5),
        
        -- 打断设置
        UseInterrupts = Aurora.Interface:CreateCheckbox("使用打断", true),
        
        -- 疾病设置
        AutoDisease = Aurora.Interface:CreateCheckbox("自动保持疾病", true)
    }
    
    RoyDKNamespace.Utils.DebugPrint("用户界面加载完成!")
end