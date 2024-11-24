`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:15:22
// Design Name: 
// Module Name: add_module
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


module add_module (
    input wire [3:0] a,
    input wire [3:0] b,
    output reg [7:0] result
);
    always @(*) begin
        result = a + b;
    end
endmodule

