`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:34:21
// Design Name: 
// Module Name: signed_add_sub
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


module signed_add_sub(
    input signed [7:0] a,       // Input signed 8-bit number a (in 2's complement)
    input signed [7:0] b,       // Input signed 8-bit number b (in 2's complement)
    output signed [7:0] sum,    // Output result of a + b
    output signed [7:0] diff    // Output result of a - b
);
    // Compute signed addition and subtraction
    assign sum = a + b;         // Addition result
    assign diff = a - b;        // Subtraction result
endmodule


