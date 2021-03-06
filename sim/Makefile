# -----------------------------------------------------------------------------------
# Module Name  :
# Date Created : 00:24:14 IST, 16 May, 2021 [ Sunday ]
#
# Author       : k-sva
# Description  :
# -----------------------------------------------------------------------------------
#
# MIT License
#
# Copyright (c) 2021 k-sva
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the Software), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# ----------------------------------------------------------------------------------- */

# **********************
# Arguments Declarations
# **********************

TESTNAME?=NO_TEST

#FILENAME?=./../top/ip_vga_ctlr_v_top.v
#TOP_NAME?=ip_vga_ctlr_v_top

COMPILE_FILELIST?=./comp_filelist/compile_filelist.list


ifdef $(DO_FILE)
DO_CMD= -do $(DO_FILE)
else
DO_CMD= -do "run -all; quit -f"
endif

LINT?=0
WALL?=0
DEBUG?=0
DUMP?=0
#LAN?=V
ASSERT?=0
CHECK?=0
TB?=0

DEBUG_ARGS?=
CHECK_ARGS?=
ASSERT_ARGS?=
DUMP_ARGS?=

# TB = 0 ( Simple RTL top will be simulated )
# TB = 1 ( Testbench top will b simulated and by default SV will be enabled )
ifeq ($(TB),1)
LAN?=SV
FILENAME?=./../top/ip_vga_ctlr_v_tb_top.sv
TOP_NAME?=ip_vga_ctlr_v_tb_top
else
LAN?=V
FILENAME?=./../top/ip_vga_ctlr_v_top.v
TOP_NAME?=ip_vga_ctlr_v_top
endif

ifeq ($(LAN),SV)
LAN_RTL_ARGS=sv
else
LAN_RTL_ARGS=v
endif

ifeq ($(DEBUG),1)
DEBUG_ARGS=+define+ip_vga_ctlr_v_debug_en
endif

ifeq ($(ASSERT),1)
ASSERT_ARGS=+define+ip_vga_ctlr_v_fa_en
endif

ifeq ($(CHECK),1)
CHECK_ARGS=+define+ip_vga_ctlr_v_check_en
endif

ifeq ($(DUMP),1)
ifeq ($(TB),1)
DUMP_ARGS=+define+ip_vga_ctlr_v_tb_dump_en
else
DUMP_ARGS=+define+ip_vga_ctlr_v_dump_en
endif
endif

ifeq ($(WALL),1)
WALL_ARG=-Wall
else
WALL__ARG=
endif

# **********************
# Labels Declarations
# **********************

ifeq ($(LINT),1)
all : clean lint lib comp opt sim
else
all : clean lib comp opt sim
endif

comp_only : clean lib comp

# To Clean Redundant Files and Other Things
# --------------------------------------------
clean:
	@echo "Running Clean Command...";
	@rm -rf *.log *.vcd *.wlf;
	@rm -rf work questa.tops transcript;
	@rm -rf ./debug;
	@rm -rf ./obj_dir;

# Compilation
# --------------------------------------------
comp:
	@echo "Compiling the files...";
	@vlog \
	-64 \
	-work ./work \
	+acc \
	-l compile.log \
	-$(LAN_RTL_ARGS) \
	-vopt \
	-writetoplevels questa.tops \
	$(FILENAME) \
	$(DEBUG_ARGS) \
	$(ASSERT_ARGS) \
	$(CHECK_ARGS) \
	$(DUMP_ARGS) \
	-f $(COMPILE_FILELIST);
	

# Simulation
# --------------------------------------------
sim:
	@echo "Starting Simulation...";
	@vsim \
	top_opt \
	-wlf vsim.wlf \
	$(DO_CMD) \
	-l $(TESTNAME).log \
	-64 \
	-c \
	+define+UVM_NO_DPI \
	+UVM_TESTNAME=$(TESTNAME);

# Library Generation
# --------------------------------------------
lib:
	@echo "Making Work Directory...";
	@vlib work;

# For the Optimization
# --------------------------------------------
opt:
	@echo "Running Optimization...";
	@vopt \
	+acc \
	$(TOP_NAME) \
	-o top_opt;

# Generate WLF from VCD
# --------------------------------------------
wave:
	@echo "Converting dump.vcd file to dump.wlf...";
	@echo "Removing all the redundant dumps...";
	@echo "Complete!";
	@vcd2wlf dump.vcd dump.wlf;
	@rm -rf dump.vcd;

# Move the Geberated Debug Logs
# --------------------------------------------
logs:
	@echo "Creating a new ./debug directory...";
	@mkdir ./debug;
	@mv *debug.log ./debug/;
	@echo "Moved all the logs successfully.";

# For the Qverilog Command
# --------------------------------------------
qv:
	qverilog \
	$(FILENAME);

qvc: clean qv

# Running a Lint using Verilator
# --------------------------------------------
lint:
	@echo "Linting the design..."
	@verilator \
	-f $(COMPILE_FILELIST) \
	$(FILENAME) \
	$(WALL_ARG) \
	--lint-only;
	@echo "Linting Complete!"
