`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 21:54:13
// Design Name: 
// Module Name: main_controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module main_controller_tb;

    // 测试信号
    reg clk;
    reg rst_n;
    reg power_button;
    reg mode_select;
    wire [2:0] mode;
    wire system_on;

    // 实例化主控制模块
    main_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .power_button(power_button),
        .mode_select(mode_select),
        .mode(mode),
        .system_on(system_on)
    );

    // 时钟信号生成
    always #5 clk = ~clk; // 10ns 时钟周期

    // 初始测试逻辑
    initial begin
        // 初始化信号
        clk = 0;
        rst_n = 0;
        power_button = 0;
        mode_select = 0;

        // 系统复位
        #10 rst_n = 1; // 释放复位
        #10;

        // 测试短按开机
        power_button = 1;
        #10 power_button = 0; // 模拟短按
        #100; // 等待系统进入开机状态
        $display("System On: %b, Mode: %b", system_on, mode);

        // 模式切换测试
        mode_select = 1;
        #10 mode_select = 0; // 切换到计算模式
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // 切换到学习模式
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // 切换到竞赛模式
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // 切换到演示模式
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // 回到待机模式
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        // 测试长按关机
        power_button = 1;
        #1000 power_button = 0; // 长按模拟
        #100; // 等待关机
        $display("System On: %b, Mode: %b", system_on, mode);

        // 测试复位
        rst_n = 0; // 复位信号拉低
        #10 rst_n = 1; // 释放复位
        #100;
        $display("After Reset - System On: %b, Mode: %b", system_on, mode);

        // 延长仿真时间，避免自动结束
        #5000; 
        $finish;
    end
endmodule



