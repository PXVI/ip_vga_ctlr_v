/* -----------------------------------------------------------------------------------
 * Module Name  : ip_vga_ctlr_v
 * Date Created : 00:24:14 IST, 16 May, 2021 [ Sunday ]
 *
 * Author       : k-sva
 * Description  : VGA Controller
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

`include "ip_vga_ctlr_v_top_defines.vh"
`include "ip_vga_ctlr_v_top_parameters.vh"

// ++++++++++++++++++
// Module Description
// ++++++++++++++++++
//
// 1. Support for basic 640x480 ( 640px Horizontal, 480px Vertical ) - Clock ( 25 MHz )
// 2. Supports parameterized HSYNC width, VSYNC width, H Front Porch, H Back
//    Porch, V Front Porch, Back Porch
// 3. Supports Wishbone slave interface

module ip_vga_ctlr_v_top `IP_VGA_CTLR_V_PARAM_DECL (  

    // Global Inputs
    input clk,
    input resetn,
    
    // Inputs
    // Wishbone Slave TODO
    
    // Outputs
    output HSYNC, // Horizontal Sync
    output VSYNC, // Vertical Sync
    output [7:0] R, // Red
    output [7:0] G, // Green
    output [7:0] B // Blue
);

    
    // ---------------
    // Dump Generation
    // ---------------
    
    `ip_vga_ctlr_v_dump

endmodule
