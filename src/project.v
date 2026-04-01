/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module fibonacci_8bit (
    input  wire clk,    // Dedicated inputs
    output reg[7:0] fib,   // Dedicated outputs
   
);
    reg[7:0] a=0;
    reg[7:0] b=1;

    always@(posedge clk) begin
        a <= b;
        b <= a+b;
        fib <=a;
    end

endmodule
