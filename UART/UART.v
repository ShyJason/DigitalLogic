`include "Constant.v"
//使用蓝牙的UART通信//
module UART_Reciever(
    input wire clk, //9600Hz
    input wire rst,
    input rx,  //接蓝牙的BT_TX串口L3
    
    output valid,
    output [7:0] recieve_data
)
    reg [3:0] current_state;
    reg [3:0] next_state;
    reg [4:0] count;

    always @(posedge clk)
        current_state <= next_state;

    always @(negedge rst)
        begin
            current_state <= IDLE;
            count <= 0;
            recieve_data <= 8'b0;
        end
    always @(*)
        begin
            next_state = current_state;
            case(current_state)
                IDLE: if (!rx) next_state = RECEIVE;
                RECEIVE: begin  if (count == 7) next_state = RECEIVE_END; end
                RECEIVE_END: begin next_state = IDLE; end
                default: next_state = IDLE;
            endcase
        end
    
    always @(posedge clk)
    begin
        if (current_state == RECEIVE)
            count <= count + 1;
        else if (current_state == IDLE | current_state == RECEIVE_END)
            count <= 0;
        else
            count <= count;
    end
    
    always @(posedge clk)
    begin
        if (current_state == RECEIVE | current_state == RECEIVE_END) begin
            recieve_data <= {recieve_data[6:0], rx};
            end
        else 
        else begin
            recieve_data <= 8'b0;
        end

    end

    assign valid = (current_state == RECEIVE_END)? 1'b1 : 1'b0;

endmodule
