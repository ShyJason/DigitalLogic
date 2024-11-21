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
    input wire clk,               // Clock signal
    input wire rst_n,             // Reset signal (active low)
    input wire power_button,      // Power button input
    input wire mode_select,       // Mode select button input
    output reg [2:0] mode,        // Current mode output
    output reg system_on          // System power state (on/off)
);

    // State encoding
    localparam OFF      = 3'b000; // System OFF state
    localparam STANDBY  = 3'b001; // Standby mode
    localparam CALC     = 3'b010; // Calculation mode
    localparam LEARN    = 3'b011; // Learning mode
    localparam COMPETE  = 3'b100; // Competition mode
    localparam DEMO     = 3'b101; // Demonstration mode

    // State registers
    reg [2:0] state, next_state; // Current state and next state

    // Sequential block: Update the current state on the rising edge of the clock
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= OFF;        // Reset: Initialize to OFF state
            system_on <= 0;      // System is OFF after reset
        end else begin
            state <= next_state; // Transition to the next state
        end
    end

    // Combinational block: Determine the next state based on current state and inputs
    always @(*) begin
        // Default: Remain in the current state
        next_state = state;

        // State transition logic
        case (state)
            OFF: begin
                if (power_button) begin
                    next_state = STANDBY; // Short press: Turn ON and enter STANDBY
                    system_on = 1;       // System is now ON
                end else begin
                    system_on = 0;       // System remains OFF
                end
            end

            STANDBY: begin
                if (!power_button) begin
                    if (mode_select) begin
                        next_state = CALC; // Mode select: Go to Calculation mode
                    end
                end else if (power_button) begin
                    next_state = OFF;     // Long press: Turn OFF system
                    system_on = 0;        // System OFF
                end
            end

            CALC: begin
                if (mode_select) begin
                    next_state = LEARN;   // Mode select: Go to Learning mode
                end else if (power_button) begin
                    next_state = OFF;     // Long press: Turn OFF system
                    system_on = 0;
                end
            end

            LEARN: begin
                if (mode_select) begin
                    next_state = COMPETE; // Mode select: Go to Competition mode
                end else if (power_button) begin
                    next_state = OFF;     // Long press: Turn OFF system
                    system_on = 0;
                end
            end

            COMPETE: begin
                if (mode_select) begin
                    next_state = DEMO;    // Mode select: Go to Demonstration mode
                end else if (power_button) begin
                    next_state = OFF;     // Long press: Turn OFF system
                    system_on = 0;
                end
            end

            DEMO: begin
                if (mode_select) begin
                    next_state = STANDBY; // Mode select: Return to Standby mode
                end else if (power_button) begin
                    next_state = OFF;     // Long press: Turn OFF system
                    system_on = 0;
                end
            end

            default: begin
                next_state = OFF;         // Default: Go to OFF state
                system_on = 0;            // Ensure system is OFF
            end
        endcase
    end

    // Output logic: Update the mode based on the current state
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mode <= OFF; // Reset: Set mode to OFF
        end else begin
            mode <= state; // Mode equals the current state
        end
    end

endmodule





