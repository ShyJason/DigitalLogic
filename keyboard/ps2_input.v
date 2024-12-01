module ps2_input(
    input wire clk_slow,
    input wire clk_fast,
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
    output wire [9:0] key_num, // 0-9 keys
    output wire key_w,
    output wire key_a,
    output wire key_s,
    output wire key_d,
    output wire key_b,
    output wire key_c,
    output wire key_enter // Enter key
);

wire [8:0] crt_data;
reg [1:0] key_w_state, key_a_state, key_s_state, key_d_state, key_b_state, key_c_state, key_enter_state;
reg [1:0] key_num_state [9:0]; // States for 0-9 keys

assign key_w = key_w_state[0]&~key_w_state[1];
assign key_a = key_a_state[0]&~key_a_state[1];
assign key_s = key_s_state[0]&~key_s_state[1];
assign key_d = key_d_state[0]&~key_d_state[1];
assign key_b = key_b_state[0]&~key_b_state[1];
assign key_c = key_c_state[0]&~key_c_state[1];
assign key_enter = key_enter_state[0]&~key_enter_state[1];
assign key_num = {key_num_state[9][0]&~key_num_state[9][1], key_num_state[8][0]&~key_num_state[8][1], key_num_state[7][0]&~key_num_state[7][1], key_num_state[6][0]&~key_num_state[6][1], key_num_state[5][0]&~key_num_state[5][1], key_num_state[4][0]&~key_num_state[4][1], key_num_state[3][0]&~key_num_state[3][1], key_num_state[2][0]&~key_num_state[2][1], key_num_state[1][0]&~key_num_state[1][1], key_num_state[0][0]&~key_num_state[0][1]};

ps2_scan scanner(
    .clk(clk_fast),
    .rst(rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .crt_data(crt_data)
);

always @ (posedge clk_slow or negedge rst)
if (!rst) begin
    key_w_state <= 2'b00;
    key_a_state <= 2'b00;
    key_s_state <= 2'b00;
    key_d_state <= 2'b00;
    key_b_state <= 2'b00;
    key_c_state <= 2'b00;
    key_enter_state <= 2'b00;
    key_num_state[0] <= 2'b00;
    key_num_state[1] <= 2'b00;
    key_num_state[2] <= 2'b00;
    key_num_state[3] <= 2'b00;
    key_num_state[4] <= 2'b00;
    key_num_state[5] <= 2'b00;
    key_num_state[6] <= 2'b00;
    key_num_state[7] <= 2'b00;
    key_num_state[8] <= 2'b00;
    key_num_state[9] <= 2'b00;
end
else begin
    key_w_state <= {key_w_state[0], crt_data[0]==9'h01d};
    key_a_state <= {key_a_state[0], crt_data[0]==9'h01c};
    key_s_state <= {key_s_state[0], crt_data[0]==9'h01b};
    key_d_state <= {key_d_state[0], crt_data[0]==9'h023};
    key_b_state <= {key_b_state[0], crt_data[0]==9'h032};
    key_c_state <= {key_c_state[0], crt_data[0]==9'h021};
    key_enter_state <= {key_enter_state[0], crt_data[0]==9'h05a}; // Enter key scan code
    key_num_state[0] <= {key_num_state[0][0], crt_data[0]==9'h045};
    key_num_state[1] <= {key_num_state[1][0], crt_data[0]==9'h016};
    key_num_state[2] <= {key_num_state[2][0], crt_data[0]==9'h01e};
    key_num_state[3] <= {key_num_state[3][0], crt_data[0]==9'h026};
    key_num_state[4] <= {key_num_state[4][0], crt_data[0]==9'h025};
    key_num_state[5] <= {key_num_state[5][0], crt_data[0]==9'h02e};
    key_num_state[6] <= {key_num_state[6][0], crt_data[0]==9'h036};
    key_num_state[7] <= {key_num_state[7][0], crt_data[0]==9'h03d};
    key_num_state[8] <= {key_num_state[8][0], crt_data[0]==9'h03e};
    key_num_state[9] <= {key_num_state[9][0], crt_data[0]==9'h046};
end
endmodule