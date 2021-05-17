/* -----------------------------------------------------------------------------------
 * Module Name  : mem_inst_v
 * Date Created : 13:35:42 IST, 17 May, 2021 [ Monday ]
 *
 * Author       : pxvi
 * Description  : Simply memory instance
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

module mem_inst_v_top   #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter TOTAL_SIZE_IN_BYTES = 640*480
                        )(
    // Global Inputs
    input clk,
    input resetn,

    // Inputs
    input [DATA_WIDTH-1:0] data_in,
    input [ADDR_WIDTH-1:0] addr_in,
    input [ADDR_WIDTH-1:0] addr_out,
    input we,

    // Outputs
    output [DATA_WIDTH-1:0] data_out
                        );

    // ------------------------
    // Basic Memory Declaration
    // ------------------------
    reg [DATA_WIDTH-1:0] MEMORY_r[480*640-1:0];

    always@( posedge clk or negedge resetn )
    begin : memory_wr
        `ifdef ip_vga_ctlr_v_check_en
            if( !resetn )
            begin
                // Do nothing
                for( j = 0; j < 640*480; j = j + 1 )
                begin
                    MEMORY_r[j] <= MEMORY_r[j];
                end
                $display( "%d - RESETN in mem_inst_v is asserted", $time );
            end
            else
        `endif
        begin
            if( we )
            begin
                MEMORY_r[addr_in] <= data_in;
                `ifdef ip_vga_ctlr_v_check_en
                    $display( "%d - Writing data into the MEMORY_r : %h ( Addr - %h [ %d ] )", $time, data_in, addr_in, addr_in );
                `endif
            end
        end
    end : memory_wr

    assign data_out = MEMORY_r[addr_out];

endmodule
