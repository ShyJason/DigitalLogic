module vga_top (
    input wire clk,
    input wire rst,
    input wire [4:0] game_mode, // 模式选择
    output wire vga_hsync,
    output wire vga_vsync,
    output wire [15:0] rgb
);

    wire [9:0] pix_x;
    wire [9:0] pix_y;
    wire vga_clk;
    wire [15:0] pix_data;

    // 时钟分频器实例
    clk_div clk_div_inst(
        .clk(clk),
        .rst(rst),
        .clk_out(vga_clk)
    );

    // VGA控制器实例
    vga_640x480 vga_controller(
        .pclk(vga_clk),
        .reset(rst),
        .hsync(vga_hsync),
        .vsync(vga_vsync),
        .valid(),
        .h_cnt(pix_x),
        .v_cnt(pix_y)
    );

    // 根据game_mode实例化不同的vga_display_mod模块
    generate
        if (game_mode[0]) begin : mode0
            vga_display_mod0 vga_display_mod_inst(
                .pclk(vga_clk),
                .rst(rst),
                .pix_x(pix_x),
                .pix_y(pix_y),
                .en(game_mode[0]),
                .pix_data(pix_data)
            );
        end else if (game_mode[1]) begin : mode1
            vga_display_mod1 vga_display_mod_inst(
                .pclk(vga_clk),
                .rst(rst),
                .pix_x(pix_x),
                .pix_y(pix_y),
                .en(game_mode[1]),
                .pix_data(pix_data)
            );
        end else if (game_mode[2]) begin : mode2
            vga_display_mod2 vga_display_mod_inst(
                .pclk(vga_clk),
                .rst(rst),
                .pix_x(pix_x),
                .pix_y(pix_y),
                .en(game_mode[2]),
                .pix_data(pix_data)
            );
        end else if (game_mode[3]) begin : mode3
            vga_display_mod3 vga_display_mod_inst(
                .pclk(vga_clk),
                .rst(rst),
                .pix_x(pix_x),
                .pix_y(pix_y),
                .en(game_mode[3]),
                .pix_data(pix_data)
            );
        end else if (game_mode[4]) begin : mode4
            vga_display_mod4 vga_display_mod_inst(
                .pclk(vga_clk),
                .rst(rst),
                .pix_x(pix_x),
                .pix_y(pix_y),
                .en(game_mode[4]),
                .pix_data(pix_data)
            );
        end
    endgenerate

    // 将pix_data连接到rgb输出
    assign rgb = pix_data;

endmodule