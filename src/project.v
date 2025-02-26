/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs (A[7:0] from spec)
    output wire [7:0] uo_out,   // Dedicated outputs (C[7:0])
    input  wire [7:0] uio_in,   // IOs: Input path (B[7:0] from spec)
    output wire [7:0] uio_out,  // IOs: Output path (Not used in this design)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock (not needed for combinational logic)
    input  wire       rst_n     // reset_n - low to reset (not needed for combinational logic)
);

    wire [15:0] In;  // Combined input from A[7:0] and B[7:0]
    assign In = {ui_in, uio_in};  // Combine inputs

    reg [7:0] C;  // Output register

    always @(*) begin
        integer i;
        C = 8'hF0; // Default case: If all bits are 0, output 0xF0
        
        for (i = 15; i >= 0; i = i - 1) begin
            if (In[i]) begin
                C = i; // Store the position of the first `1` bit found
                break;
            end
        end
    end

    assign uo_out = C;  // Output assignment
    assign uio_out = 0; // Unused
    assign uio_oe = 0;  // Unused

    // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule

