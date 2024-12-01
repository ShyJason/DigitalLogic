module time_gen(
    input wire clk,
    input wire reset,
    output reg [3:0] hours_tens,
    output reg [3:0] hours_units,
    output reg [3:0] minutes_tens,
    output reg [3:0] minutes_units,
    output reg [3:0] seconds_tens,
    output reg [3:0] seconds_units
);
    reg [25:0] counter = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            hours_tens <= 0;
            hours_units <= 0;
            minutes_tens <= 0;
            minutes_units <= 0;
            seconds_tens <= 0;
            seconds_units <= 0;
        end else begin
            if (counter == 25000000) begin // 1 second at 25 MHz
                counter <= 0;
                if (seconds_units == 9) begin
                    seconds_units <= 0;
                    if (seconds_tens == 5) begin
                        seconds_tens <= 0;
                        if (minutes_units == 9) begin
                            minutes_units <= 0;
                            if (minutes_tens == 5) begin
                                minutes_tens <= 0;
                                if (hours_units == 9) begin
                                    hours_units <= 0;
                                    hours_tens <= hours_tens + 1;
                                end else begin
                                    hours_units <= hours_units + 1;
                                end
                            end else begin
                                minutes_tens <= minutes_tens + 1;
                            end
                        end else begin
                            minutes_units <= minutes_units + 1;
                        end
                    end else begin
                        seconds_tens <= seconds_tens + 1;
                    end
                end else begin
                    seconds_units <= seconds_units + 1;
                end
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule