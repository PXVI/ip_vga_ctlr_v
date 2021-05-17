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
// 1. Support for basic 640x480 ( 640px Horizontal, 480px Vertical ) - Clock ( 25 MHz ) - ~2.3 MB of frame buffer ( double buffer )
// 2. Supports parameterized HSYNC width, VSYNC width, H Front Porch, H Back
//    Porch, V Front Porch, Back Porch
// 3. Supports Wishbone slave interface
//      - 32bit data bus
//      - 32bit address bus
//      - 8bit granularity
// 4. Supports double frame buffers

module ip_vga_ctlr_v_top `IP_VGA_CTLR_V_PARAM_DECL (  

    // Global Inputs
    input clk,
    input resetn,
    
    // Wishbone Slave Interface
    input CLK_I,
    input RST_I,
    input [DATA_WIDTH-1:0] DAT_I,
    output [DATA_WIDTH-1:0] DAT_O,
    input TGI_I,
    output TGI_O,

    output ACK_O,
    input [ADDRESS_WIDTH-1:0] ADR_I,
    input CYC_I,
    output STALL_O,
    output ERR_O,
    input LOCK_I,
    input [SEL_WIDTH-1:0] SEL_I,
    input STB_I,
    input TGA_I, // Optional
    input TGC_I, // Optional
    input WE_I, // Write Enable ( 0/Read, 1/Write )
    
    // VGA Interface
    output HSYNC, // Horizontal Sync
    output VSYNC, // Vertical Sync
    output [7:0] R, // Red
    output [7:0] G, // Green
    output [7:0] B // Blue
);

    reg [BUF_COUNT-1:0] loading_frame_r;
    reg [BUF_COUNT-1:0] frame_loaded_r;

    wire [BUF_COUNT-1:0] loading_frame_w; // Frame is being loaded using wishbone
    wire [BUF_COUNT-1:0] frame_loaded_w; // Frame/s have been loaded using WB
    wire frame_ready_w; // Empty frame buffers are avialable to be loaded by WB

    assign frame_loaded_w = frame_loaded_r;
    assign loading_frame_w = loading_frame_r;
    assign frame_ready_w = |loading_frame_w; // Frame aviallable to be loaded

    // -------------
    // Address Space
    // -------------
    
    /* 32 bit Address * ( Byte addressable )
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * ============== *
     * = DS  Reg 1 == * +4 ( Reprogrammable on the fly )
     * = CFG Reg 4 == * +3
     * = CFG Reg 3 == * +2
     * = CFG Reg 2 == * +1
     * = CFG Reg 1 == * 32'h0000_0000 ( CFG Reg 1 Address is fixed by the designer ) ( Holds the base address of the DS base address in the data address space )
     */

    // -------------------
    // Wishbone Data Space
    // -------------------
    reg [32-1:0] IP_DS_REG_r;

    always@( posedge CLK_I or posedge RST_I )
    begin
        IP_DS_REG_r <= IP_DS_REG_r;

        if( ~RST_I )
        begin
            IP_DS_REG_r <= 0;
        end
        else
        begin
            // WB write of data has been written on CFG Reg 1
        end
    end

    // ------------------------------------
    // Frames Declaration / Memory Instance
    // ------------------------------------
    reg [32-1:0] FRAME_r[BUF_COUNT-1:0][(WIDTH*HEIGHT)-1:0]; // Layout - 32bits ( 8b(R), 8b(G), 8b(B), 8b(N/A) ) * ( Heigth x Width ) * BUF_COUNT

    // -------------
    // Frame Loading
    // -------------
    always@( posedge CLK_I or posedge RST_I )
    begin : frame_loading
        integer i,j;

        for( i = 0; i < (BUF_COUNT); i = i + 1 )
        begin
            for( j = 0; j < (WIDTH*HEIGHT); j = j + 1 )
            begin
                FRAME_r[i][j] = FRAME_r[i][j];
            end
        end

        if( ~RST_I )
        begin
            // No need to initialize any values in the FRAME memory
        end
        else
        begin
        end
    end : frame_loading

    // ----------------------
    // Frame Buffer Selection
    // ----------------------


    // ----------------
    // VGA Driver Block
    // ----------------
    
    // ---------------
    // Dump Generation
    // ---------------
    
    `ip_vga_ctlr_v_dump

endmodule
