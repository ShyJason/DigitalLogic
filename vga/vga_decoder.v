`include "vga_char_params.vh"
module vga_decoder_8 (
    input [7:0] seg,       // 输入七段数码管段码
    output reg [1023:0] vga     // 输出VGA显示码
);
    always @(*) begin
        case (seg)
            8'b01111110: vga = num_zero // 显示 "0"
            8'b00001100: vga = num_one // 显示 "1"
            8'b10110110: vga = num_two // 显示 "2"
            8'b10011110: vga = num_three // 显示 "3"
            8'b11001100: vga = num_four // 显示 "4"
            8'b11011010: vga = num_five // 显示 "5"
            8'b11111010: vga = num_six // 显示 "6"
            8'b00001110: vga = num_seven // 显示 "7"
            8'b11111110: vga = num_eight // 显示 "8"
            8'b11011110: vga = num_nine // 显示 "9"
            8'b11101110: vga = char_A // 显示 "A"
            8'b00111110: vga = char_B // 显示 "B"
            8'b10011100: vga = char_C // 显示 "C"
            8'b01111010: vga = char_D // 显示 "D"
            8'b10011110: vga = char_E // 显示 "E"
            8'b10001110: vga = char_F // 显示 "F"
            8'b10000000: vga = char_neg // 显示 "-"
            8'b00000000: vga = char_none // 显示 " "
            default: vga = char_none //默认全黑
        endcase
    end
endmodule