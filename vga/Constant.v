//game_mode constant
`define DaiDing 5'b00001
`define JiSuan 5'b00010
`define XueXi 5'b00100
`define JingSai 5'b01000
`define YanShi 5'b10000

//correct constant
`define unjudge 2'b00
`define correct 2'b01
`define wrong 2'b10


// VGA constant
`define H_SYNC_PULSE 10'd96
`define H_BACK_PORCH 10'd48
`define H_ACTIVE_TIME 10'd640
`define H_FRONT_PORCH 10'd16
`define H_LINE_PERIOD 10'd800
`define V_SYNC_PULSE 10'd2
`define V_BACK_PORCH 10'd33
`define V_ACTIVE_TIME 10'd480
`define V_FRONT_PORCH 10'd10
`define V_FRAME_PERIOD 10'd525
`define char_width 6'd32

// VGA color constant
`define BLACK 12'h000
`define WHITE 12'hfff
`define RED   12'hf00
`define GREEN 12'h0f0
`define BLUE  12'h00f
`define YELLOW 12'hff0
`define GOLDEN 12'hfc0
