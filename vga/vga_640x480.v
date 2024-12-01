module vga_640x480(
    input wire pclk, // 25.175 MHz
    input wire reset,
    output wire hsync,
    output wire vsync,
    output wire valid,
    output [9:0] h_cnt,
    output [9:0] v_cnt,
);
parameter h_front_porch = 96;  // 96 pixels
parameter h_active = 144;      // 144 pixels
parameter h_back_porch = 784;  // 784 pixels
parameter h_total = 800;       // 800 pixels
parameter v_front_porch = 2;   // 2 lines
parameter v_active = 35;       // 35 lines
parameter v_back_porch = 515;  // 515 lines
parameter v_total = 525;       // 525 lines
reg [9:0] x_cnt, y_cnt;
wire h_valid, v_valid;

always @ (posedge reset or posedge pclk)begin
    if (reset==1'b1)
        x_cnt <=1;
    else begin
        if (x_cnt==h_total)
            x_cnt <= 1;
        else
            x_cnt <= x_cnt+1;
    end
end

always @ (posedge reset or posedge pclk)begin
    if (reset==1'b1)
        y_cnt <=1;
    else begin
        if (x_cnt==h_total)
            y_cnt <= y_cnt+1;
    end
end

assign hsync = ((x_cnt>h_front_porch))?1'b1:1'b0;
assign vsync = ((y_cnt>v_front_porch))?1'b1:1'b0;
assign h_valid = ((x_cnt>h_active)&(x_cnt<h_back_porch))?1'b1:1'b0;
assign v_valid = ((y_cnt>v_active)&(y_cnt<v_back_porch))?1'b1:1'b0;
assign valid = ((h_valid==1'b1)&(v_valid==1'b1))?1'b1:1'b0;
assign h_cnt = ((h_valid==1'b1))?x_cnt-144:{10{1'b0}};
assign v_cnt = ((v_valid==1'b1))?y_cnt-35:{10{1'b0}};

endmodule