-- Main.lua
return function(RoyDK)
    -- 框架加载时自动执行
    RoyDK.Debug = true -- 定义一个全局调试开关

    -- 可以在这里打印初始化信息
    if RoyDK.Debug then
        print("Aurora Warrior Routine Initialized!")
    end
end