/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example ( // Cambia 'example' por el nombre de tu repo si es necesario
    input  wire [7:0] ui_in,    // Entradas (no las usas, pero deben estar)
    output wire [7:0] uo_out,   // Salidas (aquí irá tu Fibonacci)
    input  wire [7:0] uio_in,   // IOs bidireccionales
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,      // Siempre en 1
    input  wire       clk,      // Reloj
    input  wire       rst_n     // Reset (activo bajo)
);

    reg [7:0] a;
    reg [7:0] b;

    // Asignamos la salida del registro 'a' a los pines físicos de salida
    assign uo_out = a;

    // No usamos los pines bidireccionales, así que los ponemos en 0
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    always @(posedge clk) begin
        if (!rst_n) begin
            a <= 8'd0;
            b <= 8'd1;
        end else begin
            a <= b;
            b <= a + b;
        end
    end

endmodule

