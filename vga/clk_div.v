module clk_div (
    input wire clk_in,    // 100MHz输入时钟
    input wire rst,       // 重置信号
    output reg clk_out    // 25MHz输出时钟
);

reg [1:0] counter;        // 2位计数器

always @(posedge clk_in or posedge rst) begin
    if (rst) begin
        counter <= 2'b00;
        clk_out <= 1'b0;
    end else begin
        counter <= counter + 1;
        if (counter == 2'b11) begin //每当计数器计数到3时, 输出一个时钟脉冲
            clk_out <= ~clk_out;
            counter <= 2'b00;
        end
    end
end

endmodule