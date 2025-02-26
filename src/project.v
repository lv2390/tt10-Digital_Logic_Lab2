/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs (A[7:0])
    output wire [7:0] uo_out,   // Dedicated outputs (C[7:0])
    input  wire [7:0] uio_in,   // IOs: Input path (B[7:0])
    output wire [7:0] uio_out,  // IOs: Output path (Not used)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock (not needed for combinational logic)
    input  wire       rst_n     // reset_n - low to reset (not needed)
);

    assign uo_out = ui_in & uio_in;  // Bitwise AND operation

    assign uio_out = 0; // Unused
    assign uio_oe = 0;  // Unused

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

