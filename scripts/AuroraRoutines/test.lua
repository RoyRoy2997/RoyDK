-- Test.lua
return function(TestNamespace)
    print("[Test] 测试模块已加载!")
    
    -- 注册一个简单的循环
    Aurora:RegisterRoutine(function()
        print("[Test] 循环运行中...")
    end, "DEATHKNIGHT", 251, "TestNamespace")
    
    print("[Test] 测试模块注册完成!")
end