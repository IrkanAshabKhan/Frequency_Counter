`timescale 1ns/1ns
`include "Frequency_Counter\\Frequency_Counter.v"
module Frequency_Counter_tb();
    reg clk, signal;
    wire [11:0] frequency;

    // Instantiate the Frequency Counter module
    Frequency_Counter uut(
        .clk(clk),
        .signal(signal),
        .ledone(ledone),
        .ledtwo(ledtwo),
        .ledthree(ledthree),
        .db1(db1),
        .db2(db2),
        .db3(db3)
    );

    initial begin

        $dumpfile("Frequency_Counter.vcd");
        $dumpvars(0, Frequency_Counter_tb);
        {clk, signal} = 0;

        #1000000;

        $finish();
    end

    always begin
        clk = ~clk;
        #5;
    end
    always begin
        signal = ~signal;
        #3333; //3333 for 3KHz, 5000 for 2KHz, 10000 for 1KHz
        end
endmodule