`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 15:39:03
// Design Name: 
// Module Name: main_controller
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


module main_controller (
    input wire clk,               // ʱ���ź�
    input wire rst_n,             // ��λ�źţ��͵�ƽ��Ч��
    input wire power_button,      // ���ػ�����
    input wire mode_select,       // ģʽѡ�񰴼�
    output reg [2:0] mode,        // ��ǰģʽ���
    output reg system_on          // ϵͳ����״̬
);

    // ״̬����
    localparam OFF      = 3'b000; // ϵͳ�ػ�״̬
    localparam STANDBY  = 3'b001; // ����ģʽ
    localparam CALC     = 3'b010; // ����ģʽ
    localparam LEARN    = 3'b011; // ѧϰģʽ
    localparam COMPETE  = 3'b100; // ����ģʽ
    localparam DEMO     = 3'b101; // ��ʾģʽ

    // ���ػ��߼�
    reg [23:0] power_counter;
    reg power_pressed;

// ���ػ��߼�����
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        power_counter <= 0;
        power_pressed <= 0;
        system_on <= 0;
    end else if (power_button) begin
        if (system_on) begin
            power_counter <= power_counter + 1;
            if (power_counter >= 24'hFFFFFF) begin
                system_on <= 0; // �����ػ�
                power_counter <= 0; // ���ü�����
            end
        end else begin
            power_counter <= power_counter + 1;
            if (power_counter < 24'h10000) begin
                system_on <= 1; // �̰�����
            end
        end
    end else begin
        power_counter <= 0; // �����ͷ�ʱ���ü�����
        power_pressed <= 0;
    end
end


    // ģʽ�л��߼�
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mode <= OFF;
        end else if (!system_on) begin
            mode <= OFF; // ϵͳ�ػ�
        end else if (system_on && mode_select) begin
            case (mode)
                STANDBY: mode <= CALC;    // ���� -> ����
                CALC:    mode <= LEARN;   // ���� -> ѧϰ
                LEARN:   mode <= COMPETE; // ѧϰ -> ����
                COMPETE: mode <= DEMO;    // ���� -> ��ʾ
                DEMO:    mode <= STANDBY; // ��ʾ -> ����
                default: mode <= STANDBY;
            endcase
        end
    end

    // ��λ�߼�
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mode <= OFF;
            system_on <= 0;
        end
    end

endmodule



