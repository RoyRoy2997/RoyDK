
-- Main.lua
return function(RoyDKNamespace)
    -- 初始化命名空间
    RoyDKNamespace.Config = {}
    RoyDKNamespace.Spells = {}
    RoyDKNamespace.Auras = {}
    RoyDKNamespace.Utils = {}
    
    -- 基础配置
    RoyDKNamespace.Config.DebugMode = true
    RoyDKNamespace.Config.Version = "1.0.0"
    RoyDKNamespace.Config.Class = "Specialisation"
    RoyDKNamespace.Config.Spec = 251
    
    -- 工具函数
    RoyDKNamespace.Utils.DebugPrint = function(message)
        if RoyDKNamespace.Config.DebugMode then
            print("[RoyDK] " .. message)
        end
    end
    
    -- 符文工具函数
    RoyDKNamespace.Utils.GetRunes = function()
        return player.runes or 0
    end
    
    RoyDKNamespace.Utils.GetRunicPower = function()
        return player.runicpower or 0
    end
    
    -- 初始化完成消息
    RoyDKNamespace.Utils.DebugPrint("冰霜死亡骑士 RoyDK v" .. RoyDKNamespace.Config.Version .. " 初始化完成!")
end