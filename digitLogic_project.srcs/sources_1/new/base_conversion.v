`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/24 22:33:14
// Design Name: 
// Module Name: base_conversion
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


module base_conversion (
    input wire [7:0] binary,  
    output reg [11:0] octal,  
    output reg [15:0] decimal,
    output reg [7:0] hex      
);
    always @(*) begin
        octal = {4'b0, binary[7:6]} * 8 + binary[5:3] * 4 + binary[2:0]; // °Ë½øÖÆ¼ÆËã
        decimal = binary;  
        hex = binary;      
    end
endmodule

