/* -----------------------------------------------------------------------------------
 * Module Name  : ip_frame_buf_v
 * Date Created : 12:50:55 IST, 17 May, 2021 [ Monday ]
 *
 * Author       : pxvi
 * Description  : Frame buffer ( Dual ) { Simply a FIFO }
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

`include "mem_inst_v_top.v"

module ip_frame_buf_v_top   #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter TOTAL_SIZE_IN_PIXELS = 640*480
                            )(
    // Global Inputs
    input clk,
    input resetn,

    // Inputs
    input [DATA_WIDTH-1:0] data_in,
    input flush, // Flushes the current frame that was being loaded TODO
    input flush_all, // Flushes all the frames TODO
    input we, // Write data to the frame
    input re, // Read data from the frame

    // Outputs
    output [DATA_WIDTH-1:0] data_out,
    output frames_empty, // High if even one frame is avialable to be loaded
    output frames_full, // High if all frames are full and pending either reading or flushing
    output frame_ready // Atleast one frame is avialable to be read
                            );


    /* verilator lint_off MULTITOP */

    reg [1:0] frames_fe_r; // Tells if a frame is empty or not. Toggles only if a frame has been loaded completely. [ F1 , F0 ]
    reg [32-1:0] read_counter_r, write_counter_r;
    reg p_write_frame_r, p_read_frame_r;
    reg [ADDR_WIDTH-1:0] data_in_r, data_out_r;

    wire [1:0] frames_fe_w;
    wire local_f0_we_w, local_f1_we_w;
    wire f0_we_w;
    wire f1_we_w;
    wire p_write_frame_w, p_read_frame_w; // Present read frame number and write frame number
    wire [32-1:0] read_counter_w, write_counter_w;
    wire [DATA_WIDTH-1:0] data_in_w, data_out_w;
    wire [DATA_WIDTH-1:0] data_out_f0_w, data_out_f1_w;
    wire [ADDR_WIDTH-1:0] addr_in_w, addr_out_w;
    wire frames_empty_w; 

    assign local_f1_we_w = ( p_write_frame_r ) ? we : 1'b0;
    assign local_f0_we_w = ( !p_write_frame_r ) ? 1'b0 : we;
    assign p_read_frame_w = p_read_frame_r;
    assign p_write_frame_w = p_write_frame_r;
    assign read_counter_w = read_counter_r;
    assign write_counter_w = write_counter_r;
    assign frames_fe_w = frames_fe_r;
    assign data_in_w = data_in_r;
    assign data_out_w = data_out_r;
    assign data_out = ( !(|frames_fe_w) ) ? 32'd0 : ( !p_read_frame_w ) ? data_out_f0_w : data_out_f1_w;
    assign frames_empty = !(|frames_fe_w);
    assign frames_full = &frames_fe_w;
    assign frame_ready = |frames_fe_w;
    
    // -------------
    // Control Logic
    // -------------
    
    always@( posedge clk or negedge resetn )
    begin
        read_counter_r <= read_counter_r;
        write_counter_r <= write_counter_r;
        frames_fe_r <= frames_fe_r;
        p_write_frame_r <= p_write_frame_r;
        p_read_frame_r <= p_read_frame_r;

        if( !resetn )
        begin
            read_counter_r <= 0;
            write_counter_r <= 0;
            p_write_frame_r <= 0;
            p_read_frame_r <= 0;
            frames_fe_r <= 0;
        end
        else if( flush_all == 1'b1 )
        begin
            read_counter_r <= 0;
            write_counter_r <= 0;
            p_write_frame_r <= 0;
            p_read_frame_r <= 0;
            frames_fe_r <= 0;
        end
        else
        begin
            if( flush == 1'b1 )
            begin
                write_counter_r <= 0;
            end

            if( re && frames_fe_w[p_read_frame_w] )
            begin
                if( read_counter_w == TOTAL_SIZE_IN_PIXELS-1 )
                begin
                    frames_fe_r[p_read_frame_w] <= ~frames_fe_w[p_read_frame_w];
                    p_read_frame_r <= p_read_frame_w + 1'b1;
                    read_counter_r <= 0;
                end
                else
                begin
                    read_counter_r <= read_counter_w + 1'b1;
                end
            end

            if( we && !( frames_fe_w[p_write_frame_w] ) )
            begin
                if( write_counter_w == TOTAL_SIZE_IN_PIXELS-1 )
                begin
                    frames_fe_r[p_write_frame_w] <= ~frames_fe_w[p_write_frame_w];
                    p_write_frame_r <= p_write_frame_w + 1'b1;
                    write_counter_r <= 0;
                end
                else
                begin
                    write_counter_r <= write_counter_w + 1'b1;
                end
            end
        end
    end


    // Memory #1 Instance ( Frame 1 )
    mem_inst_v_top frame0   (
        .clk( clk ),
        .resetn( resetn ),
        .data_in( data_in ),
        .addr_in( addr_in_w ),
        .addr_out( addr_out_w ),
        .we( local_f0_we_w ),
        .data_out( data_out_f0_w )
    );

    // Memory #2 Instance ( Frame 2 )
    mem_inst_v_top frame1   (
        .clk( clk ),
        .resetn( resetn ),
        .data_in( data_in ),
        .addr_in( addr_in_w ),
        .addr_out( addr_out_w ),
        .we( local_f1_we_w ),
        .data_out( data_out_f1_w )
    );

endmodule
