`include "vga_char_params.vh"
`include "Constant.v"

module vga_top (
    input wire clk,
    input wire rst,
    input wire [14:0] timingup, // 4位0-9999正计时 单位:s
    input wire [14:0] timingdown, // 4位0-9999倒计时 单位:s
    input wire script[7:0], // 8位输入器
    input wire [7:0] bcd, // 8位BCD
    input wire [7:0] led, // 8位LED
    input wire [1:0] is_correct, // 2位正确性 
    
    input wire [4:0] game_mode, // 模式选择
    output hsync,   // line synchronization signal
    output vsync,   // vertical synchronization signal
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);

    wire [9:0] pix_x;
    wire [9:0] pix_y;
    wire vga_clk; //25MHz
    wire [15:0] pix_data;

    clk_wiz_0 clk_inst(   // clk_wiz_0 used ip core
        .clk_in1(clk),
        .clk_out1(vga_clk)
    );

    // horizontal counter
    reg [9:0] hc;
    always @(posedge vga_clk) begin
        if (~rst_n) hc <= 0;
        else if (hc == `H_LINE_PERIOD - 1) hc <= 0;
        else hc <= hc + 1;
    end

    // vertical counter
    reg [9:0] vc;
    always @(posedge vga_clk) begin
        if (~rst_n) vc <= 0;
        else if (vc == `V_FRAME_PERIOD - 1) vc <= 0;
        else if (hc == `H_LINE_PERIOD - 1) vc <= vc + 1;
        else vc <= vc;
    end

    wire [9:0] hc0, vc0;
    assign hsync = (hc < `H_SYNC_PULSE) ? 0 : 1;
    assign vsync = (vc < `V_SYNC_PULSE) ? 0 : 1;
    assign hc0 = hc - `H_SYNC_PULSE - `H_BACK_PORCH;
    assign vc0 = vc - `V_SYNC_PULSE - `V_BACK_PORCH;

    wire active;  // is the point active
    assign active = (hc >= `H_SYNC_PULSE + `H_BACK_PORCH) &&
                    (hc < `H_SYNC_PULSE + `H_BACK_PORCH + `H_ACTIVE_TIME) &&
                    (vc >= `V_SYNC_PULSE + `V_BACK_PORCH) &&
                    (vc < `V_SYNC_PULSE + `V_BACK_PORCH + `V_ACTIVE_TIME) ? 1 : 0;

    reg [10:0] idx;
    

    always @(*) begin
        if (~rst_n) begin
            red = 0;
            green = 0;
            blue = 0;
        end
        else if (active) begin
            ///正计时///
            if (hc0 >= 96 + 0*`char_width && hc0 < 96 + 1*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 96 + 32 * (vc0 - 32);
                case (timingup / 1000) //正计时千位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 96 + 1*`char_width && hc0 < 96 + 2*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 96 - `char_width + 32 * (vc0 - 32);
                case (timingup % 1000 / 100) //正计时百位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 96 + 2*`char_width && hc0 < 96 + 3*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 96 - 2*`char_width + 32 * (vc0 - 32);
                case (timingup % 100 / 10) //正计时十位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 96 + 0*`char_width && hc0 < 96 + 1*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 96 - 3*`char_width + 32 * (vc0 - 32);
                case (timingup % 10) //正计时个位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            ///倒计时///
            else if (hc0 >= 256 + 0*`char_width && hc0 < 256 + 1*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 256 + 32 * (vc0 - 32);
                case (timingdown / 1000) //倒计时千位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 256 + 1*`char_width && hc0 < 256 + 2*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 256 - `char_width + 32 * (vc0 - 32);
                case (timingdown % 1000 / 100) //倒计时百位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 256 + 2*`char_width && hc0 < 256 + 3*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 256 - 2*`char_width + 32 * (vc0 - 32);
                case (timingdown % 100 / 10) //倒计时十位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red ,green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            else if (hc0 >= 256 + 0*`char_width && hc0 < 256 + 1*`char_width && vc0 >= 32 && vc0 < 32 + `char_width &&game_mode==JingSai) begin
                idx = hc0 - 256 - 3*`char_width + 32 * (vc0 - 32);
                case (timingdown % 10) //倒计时个位
                    0: begin
                        if (num_zero[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    1: begin
                        if (num_one[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    2: begin
                        if (num_two[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    3: begin
                        if (num_three[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    4: begin
                        if (num_four[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    5: begin
                        if (num_five[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    6: begin
                        if (num_six[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    7: begin
                        if (num_seven[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    8: begin
                        if (num_eight[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    9: begin
                        if (num_nine[idx] == 1) {red, green, blue} = WHITE;
                        else {red, green, blue} = BLACK;
                    end
                    default: begin
                        {red, green, blue} = BLACK;
                    end
                endcase
            end
            ///模式显示///
            else if (hc0 >= 480 + 0*`char_width && hc0 < 480 + 1*`char_width && vc0 >= 32 && vc0 < 32 + `char_width) begin
                idx = hc0 - 480 + 32 * (vc0 - 32);
                if (game_mode ==DaiDing) begin
                    if (char_dai[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode ==JiSuan) begin
                    if (char_ji[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode ==XueXi) begin
                    if (char_xue[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode ==JingSai) begin
                    if (char_jing[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode ==YanShi) begin
                    if (char_yan[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
            end
            else if (hc0 >= 480 + 1*`char_width && hc0 < 480 + 2*`char_width && vc0 >= 32 && vc0 < 32 + `char_width) begin
                idx = hc0 - 480 -`char_width + 32 * (vc0 - 32);
                if (game_mode==DaiDing) begin
                    if(char_ding[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode==JiSuan) begin
                    if(char_suan[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode==XueXi) begin
                    if(char_xi[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode==JingSai) begin
                    if(char_sai[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
                else if (game_mode==YanShi) begin
                    if(char_shi2[idx] == 1) {red, green, blue} = WHITE;
                    else {red, green, blue} = BLACK;
                end
            end
            else if (hc0 >= 480 + 2*`char_width && hc0 < 480 + 3*`char_width && vc0 >= 32 && vc0 < 32 + `char_width) begin
                idx = hc0 - 480 - 2*`char_width + 32 * (vc0 - 32);
                if (char_mo[idx] == 1) {red, green, blue} = WHITE;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 480 + 3*`char_width && hc0 < 480 + 4*`char_width && vc0 >= 32 && vc0 < 32 + `char_width) begin
                idx = hc0 - 480 - 3*`char_width + 32 * (vc0 - 32);
                if (char_shi[idx] == 1) {red, green, blue} = WHITE;
                else {red, green, blue} = BLACK;
            end
            ///八位输入器///
            else if (hc0 >= 96 + 0*`char_width && hc0<96 + 1*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 1*`char_width && hc0<96 + 2*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - `char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 2*`char_width && hc0<96 + 3*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 2*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 3*`char_width && hc0<96 + 4*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 3*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 4*`char_width && hc0<96 + 5*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 4*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} =GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 5*`char_width && hc0<96 + 6*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 5*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 6*`char_width && hc0<96 + 7*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 6*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 7*`char_width && hc0<96 + 8*`char_width && vc0 >= 128 && vc0 < 128 + `char_width) begin
                idx = hc0 - 96 - 7*`char_width + 32 * (vc0 - 128);
                if (script[idx] == 1) {red, green, blue} = GREEN;
                else {red, green, blue} = BLACK;
            end
            ///八位led///
            else if (hc0 >= 96 + 0*`char_width && hc0<96 + 1*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 1*`char_width && hc0<96 + 2*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - `char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 2*`char_width && hc0<96 + 3*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 2*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 3*`char_width && hc0<96 + 4*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 3*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 4*`char_width && hc0<96 + 5*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 4*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 5*`char_width && hc0<96 + 6*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 5*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 6*`char_width && hc0<96 + 7*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 6*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            else if (hc0 >= 96 + 7*`char_width && hc0<96 + 8*`char_width && vc0 >= 256 && vc0 < 256 + `char_width) begin
                idx = hc0 - 96 - 7*`char_width + 32 * (vc0 - 256);
                if (led[idx] == 1) {red, green, blue} = GOLDEN;
                else {red, green, blue} = BLACK;
            end
            ///8位BCD///
            


            ///对错///
            else if (hc0 >= 96 + 0*`char_width && hc0<96 + 1*`char_width && vc0 >= 96 && vc0 < 96 + `char_width) begin
                idx = hc0 - 96 + 32 * (vc0 - 96);
                if(is_correct==correct) begin
                    if(char_dui[idx] == 1) {red, green, blue} = GREEN;
                    else {red, green, blue} = BLACK;
                end
                else begin
                    if(char_cuo[idx] == 1) {red, green, blue} = RED;
                    else {red, green, blue} = BLACK;
                end
            end
            ///defult///
            else begin
                {red, green, blue} = BLACK;
            end
        end
        else begin
            {red, green, blue} = BLACK;
        end
    end
            

endmodule