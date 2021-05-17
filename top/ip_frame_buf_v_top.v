/* -----------------------------------------------------------------------------------
 * Module Name  : ip_frame_buf_v
 * Date Created : 12:50:55 IST, 17 May, 2021 [ Monday ]
 *
 * Author       : pxvi
 * Description  : Frame buffer ( Dual )
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

module ip_frame_buf_v_top   #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
                            )(
    // Global Inputs
    input clk,
    input resetn,

    // Inputs
    input [DATA_WIDTH-1:0] data_in,
    input [ADDR_WIDTH-1:0] addr_in,
    input [ADDR_WIDTH-1:0] addr_out,
    input flush,

    // Outputs
    output [DATA_WIDTH-1:0] data_out,
    output buffer_empty,
    output buffer_full
                            );

endmodule
