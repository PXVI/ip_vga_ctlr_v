/* -----------------------------------------------------------------------------------
 * Module Name  :
 * Date Created : 00:24:14 IST, 16 May, 2021 [ Sunday ]
 *
 * Author       : k-sva
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

// ----------------------
// Declaration Parameters
// ----------------------
`define IP_VGA_CTLR_V_PARAM_DECL #( \
                                        parameter ADDRESS_WIDTH = 32, \
                                        parameter DATA_WIDTH = 32, /* Supported - 8/16/32/64 */ \
                                        parameter SEL_WIDTH = 4, /* $clog2( DATA_WIDTH ) */ \
                                        parameter WIDTH = 640, \
                                        parameter HEIGHT = 480, \
                                        parameter HSYNC_WIDTH = 2, \
                                        parameter VSYNC_WIDTH = 2, \
                                        parameter HFP = 2, \
                                        parameter HBP = 2, \
                                        parameter VFP = 2, \
                                        parameter VBP = 2, \
                                        parameter BUF_COUNT = 2, /* Frame buffer count */ \
                                        parameter IP_CS_BASE_ADDR = 32'b0, /* Config space base address : FIXED ( Pre determined by the designer ) */ \
                                        parameter IP_CS_OFFS_SIZE = 16, /* Config space size in bytes : FIXED */ \
                                        parameter IP_DS_BASE_ADDR = IP_CS_BASE_ADDR + IP_CS_OFFS_SIZE, /* Data space base address */ \
                                        parameter IP_DS_OFFS_SIZE = 4 /* Config space size in bytes : FIXED */ \
                                        )
