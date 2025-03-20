// Frequency Counter Module based on Verilog Tutorial Fall 2024 and Professor Tarter
module Frequency_Counter(
    input clk, signal,
    output reg ledone, ledtwo, ledthree, db1, db2, db3
);

reg [3:0] cone;
reg [3:0] ctwo;
reg [3:0] cthree;
reg [11:0] frequency;
reg [26:0] counter = 0;
reg [11:0] frequency_internal = 0;
reg prev_signal = 0;
reg prev_prev_signal = 0;

initial begin
    cone = 0;
    ctwo = 0;
    cthree = 0;
    frequency = 0;
    ledone    = 0;
    ledtwo    = 0;
    ledthree  = 0;
    db1 = 0;
    db2 = 0;
    db3 = 0;
end
always@(posedge clk) begin
    prev_signal <= signal;
    prev_prev_signal <= prev_signal;

    frequency_internal = frequency_internal + (prev_signal && ~prev_prev_signal);

    //increment counter
    counter = counter + 1;
    //check if @ 1 second
    if(counter >= 10000) begin //test 10_000, run 100_000_000
        counter = 0;
        frequency = frequency_internal;
        frequency_internal = 0;
        // test 10000 and check for 15 for "3KHz" 10 for "2KHz" 5 for "1KHz"
    end
    if(frequency == 5) begin
        if(cone > 10) begin
            ledone = 1;
            ledtwo = 0;
            ledthree = 0;
        end
        else begin
            cone = cone + 1;
            ctwo = 0;
            cthree = 0;
        end
    end
    if(frequency == 10) begin
        if(ctwo > 10) begin
            ledone = 0;
            ledtwo = 1;
            ledthree = 0;
        end
        else begin
            cone = 0;
            ctwo = ctwo + 1;
            cthree = 0;
        end
    end
    if(frequency == 15) begin
        if(cthree > 10) begin
            ledone = 0;
            ledtwo = 0;
            ledthree = 1;
        end
        else begin
            cone = 0;
            ctwo = 0;
            cthree = cthree + 1;
        end
    end
    {db1, db2, db3} = {ledone, ledtwo, ledthree};
end

endmodule
