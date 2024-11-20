`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/19 16:22:02
// Design Name: 
// Module Name: data_initialiser
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


module data_initializer (
    input wire clk,
    input wire rst_n,
    input wire init_trigger,
    output reg [31:0] data_out [3:0]  // 输出4个32位寄存器
);

    integer i;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 4; i = i + 1) begin
                data_out[i] <= 32'b0;
            end
        end else if (init_trigger) begin
            for (i = 0; i < 4; i = i + 1) begin
                data_out[i] <= 32'h12345678 + i; // 每个寄存器设置不同默认值
            end
        end
    end

endmodule

