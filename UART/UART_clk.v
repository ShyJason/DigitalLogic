module uart_clk (
    input wire clk,       // 100MHz系统时钟
    input wire rst,       // 复位信号
    output reg baud_clk   // 9600波特率时钟
);

    // 计算分频系数
    // 100MHz / 9600 = 10416.67
    // 取整为10417
    localparam integer DIVISOR = 10417;

    reg [13:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            baud_clk <= 0;
        end else if (counter == DIVISOR - 1) begin
            counter <= 0;
            baud_clk <= ~baud_clk;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule