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
    input wire clk,                   // Clock signal
    input wire rst_n,                 // Reset signal (active low)
    input wire init_trigger,          // Initialization trigger signal
    output reg [31:0] data_out [3:0]  // Output: 4 registers, each 32-bit wide
);

    // Integer variable for the loop
    integer i;

    // Sequential logic for initialization
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: set all registers in the array to 0
            for (i = 0; i < 4; i = i + 1) begin
                data_out[i] <= 32'b0; // Clear each 32-bit register
            end
        end else if (init_trigger) begin
            // On init_trigger: assign default values to the registers
            for (i = 0; i < 4; i = i + 1) begin
                data_out[i] <= 32'h12345678 + i; // Set different values for each register
            end
        end
    end

endmodule


