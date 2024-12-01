module ps2_scan(
    input wire clk,
    input wire rst,
    input wire ps2_clk,
    input wire ps2_data,
    output reg [8:0] crt_data
);
reg [1:0] ps2_clk_state;
wire ps2_clk_neg;
assign ps2_clk_neg = ~ps2_clk_state[0]&ps2_clk_state[1];
reg [3:0] read_state;
reg [8:0] read_data;
reg is_f0, is_e0;
always @ (posedge clk or negedge rst)begin
    if(!rst)begin
        read_data<=4'b0;
        read_state<=8'b0;
        is_f0<=1'b0;
        is_e0<=1'b0;
        crt_data<=9'b0;
    end
    else if (ps2_clk_neg) begin
        if(read_state>=4'b1001)
            read_data<=4'b0;
        else begin
            if(read_state>4'b0&&read_state<4'b1001)
                read_data[read_state-1]=ps2_data;
            read_state<=read_state+1'b1;
        end
    end
    else if (read_state==4'b1010&&|read_data)begin
        if(read_data==8'hf0)
            is_f0<=1'b1;
        else if(read_data==8'he0)
            is_e0<=1'b1;
        else if(is_f0)begin
            is_f0<=1'b0;
            is_e0<=1'b0;
            crt_data<=9'b0;
        end
        else if(is_e0)begin
            is_e0<=1'b0;
            crt_data<=9'b0;
        end
        else begin
            crt_data<=(1'b0,read_data);
            read_data<=8'b0;
        end
    end
end
endmodule