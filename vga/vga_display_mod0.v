module vga_display_mod1(
    input wire pclk,
    input wire rst,
    input wire [9:0] pix_x,
    input wire [9:0] pix_y,
    input wire en,
    output wire [15:0] pix_data
);
    parameter mod_begin_x = 192;
    parameter mod_begin_y = 208;

    parameter char_width = 10'd128;
    parameter char_height = 96;

    parameter black = 16'h0000;
    parameter gold = 16'hFFD700;

    wire [9:0] char_x;
    wire [9:0] char_y;

    reg [127:0] char[0:95];
    if (en) begin
        assign char_x = (((pix_x>=mod_begin_x)&&(pix_x<mod_begin_x+char_width)))
                            &&(((pix_y>=mod_begin_y)&&(pix_y<mod_begin_y+char_height)))
                            ?pix_x-mod_begin_x:10'h3FF;
        
        assign char_y = (((pix_x>=mod_begin_x)&&(pix_x<mod_begin_x+char_width)))
                            &&(((pix_y>=mod_begin_y)&&(pix_y<mod_begin_y+char_height)))
                            ?pix_y-mod_begin_y:10'h3FF;

        always @ (posedge pclk) begin
            char[0] <= 128'h00000000000000000000000000000000,
            char[1] <= 128'h01c01e00000780000781e3c0000078c0,
            char[2] <= 128'h03e01e00000780000781e3c000007bc0,
            char[3] <= 128'h03c01e000007c0000781e3c000007be0,
            char[4] <= 128'h07cffffc3ffffffc07bffffe000079f0,
            char[5] <= 128'h0f8ffffc3ffffffc07bffffe000078f0,
            char[6] <= 128'h1f0ffffc3ffffffc07bffffe000078f0,
            char[7] <= 128'h3f0ffffc3ffffffc3ff1e3c07ffffffe,
            char[8] <= 128'h7ec01e003c00003c7ff1e3c07ffffffe,
            char[9] <= 128'h7cf01e003c00003c7ffffff87ffffffe,
            char[10] <= 128'h79fffffe3dfffffc3ffffff800007800,
            char[11] <= 128'h73fffffe3ffffffc078ffff800007800,
            char[12] <= 128'h03dffffe3fffffc00f8f007800007800,
            char[13] <= 128'h07dffffe03ffffc00fcffff800003800,
            char[14] <= 128'h0f8001e00003c0000feffff83fffbc00,
            char[15] <= 128'h1f8001e00183c0001ffffff83fffbc00,
            char[16] <= 128'h3f8001e001c3c0001fff00783fffbc00,
            char[17] <= 128'h7f9ffffe03c3c0003ffffff83fffbc00,
            char[18] <= 128'h7f9ffffe03c3fff07ffffff800e03c00,
            char[19] <= 128'h7f9ffffe03c3fff07fbffff800e03e00,
            char[20] <= 128'h778381e007c3fff0ff801c0000e01e00,
            char[21] <= 128'h0787c1e00783fff077bffffe00e01e00,
            char[22] <= 128'h0787c1e007c3c00067bffffe00e01e08,
            char[23] <= 128'h0783e1e00fe3c00067bffffe00e0cf1e,
            char[24] <= 128'h0781f1e00ff3c00007bffffe00ffcf1e,
            char[25] <= 128'h0780f1e01ffbc0000781ff8007ffcf9e,
            char[26] <= 128'h078071e03effc0000783f7e07fffc79e,
            char[27] <= 128'h078001e07e7ffc06078fe3f87ffe07fc,
            char[28] <= 128'h07803fe07c1ffffe07bfc1fe3f8003fc,
            char[29] <= 128'h07803fe07807fffe07bf80fe300001f8,
            char[30] <= 128'h07803fc070007ffe07bc003e000001f8,
            char[31] <= 128'h070000003000000003b0000c00000020,
        end
    end
endmodule