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

    // �����ź�
    reg clk;
    reg rst_n;
    reg power_button;
    reg mode_select;
    wire [2:0] mode;
    wire system_on;

    // ʵ����������ģ��
    main_controller uut (
        .clk(clk),
        .rst_n(rst_n),
        .power_button(power_button),
        .mode_select(mode_select),
        .mode(mode),
        .system_on(system_on)
    );

    // ʱ���ź�����
    always #5 clk = ~clk; // 10ns ʱ������

    // ��ʼ�����߼�
    initial begin
        // ��ʼ���ź�
        clk = 0;
        rst_n = 0;
        power_button = 0;
        mode_select = 0;

        // ϵͳ��λ
        #10 rst_n = 1; // �ͷŸ�λ
        #10;

        // ���Զ̰�����
        power_button = 1;
        #10 power_button = 0; // ģ��̰�
        #100; // �ȴ�ϵͳ���뿪��״̬
        $display("System On: %b, Mode: %b", system_on, mode);

        // ģʽ�л�����
        mode_select = 1;
        #10 mode_select = 0; // �л�������ģʽ
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // �л���ѧϰģʽ
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // �л�������ģʽ
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // �л�����ʾģʽ
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        mode_select = 1;
        #10 mode_select = 0; // �ص�����ģʽ
        #100;
        $display("System On: %b, Mode: %b", system_on, mode);

        // ���Գ����ػ�
        power_button = 1;
        #1000 power_button = 0; // ����ģ��
        #100; // �ȴ��ػ�
        $display("System On: %b, Mode: %b", system_on, mode);

        // ���Ը�λ
        rst_n = 0; // ��λ�ź�����
        #10 rst_n = 1; // �ͷŸ�λ
        #100;
        $display("After Reset - System On: %b, Mode: %b", system_on, mode);

        // �ӳ�����ʱ�䣬�����Զ�����
        #5000; 
        $finish;
    end
endmodule



