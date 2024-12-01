module char_gen(
    input wire [3:0] digit,
    input wire [3:0] row,
    input wire [2:0] col,
    output reg pixel
);
    reg [7:0] char_rom [0:15][0:7];

    initial begin
        // Initialize character ROM with 7-segment font
        char_rom[0] = 8'b11111100;
        char_rom[1] = 8'b01100000;
        char_rom[2] = 8'b11011010;
        char_rom[3] = 8'b11110010;
        char_rom[4] = 8'b01100110;
        char_rom[5] = 8'b10110110;
        char_rom[6] = 8'b10111110;
        char_rom[7] = 8'b11100000;
        char_rom[8] = 8'b11111110;
        char_rom[9] = 8'b11110110;
        // Add other digits if needed
    end

    always @(*) begin
        pixel = char_rom[digit][row][col];
    end
endmodule