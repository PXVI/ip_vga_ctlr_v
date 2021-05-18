/* -----------------------------------------------------------------------------------
 * Module Name  :
 * Date Created : 23:12:09 IST, 18 May, 2021 [ Tuesday ]
 *
 * Author       : pxvi
 * Description  :
 * -----------------------------------------------------------------------------------

   MIT License

   Copyright (c) 2021 k-sva

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the Software), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.

 * ----------------------------------------------------------------------------------- */

`include "mem_inst_mod.v"

module mem_inst_mod_tb;

    // Simulate this with SystemVerilog only

    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter TOTAL_SIZE_IN_BYTES = 640*480

    // Global Inputs
    reg clk_r_t;
    reg resetn_r_t;

    // Inputs
    reg [DATA_WIDTH-1:0] data_in_r_t;
    reg [ADDR_WIDTH-1:0] addr_in_r_t;
    reg [ADDR_WIDTH-1:0] addr_out_r_t;
    reg we_r_t;

    // Outputs
    wire [DATA_WIDTH-1:0] data_out_w_t;

    // IP Instance
    mem_inst_mod mem    (
        .clk(),
        .resetn(),
        .data_in(),
        .addr_in(),
        .addr_out(),
        .we(),
        .data_out()
    );

endmodule
