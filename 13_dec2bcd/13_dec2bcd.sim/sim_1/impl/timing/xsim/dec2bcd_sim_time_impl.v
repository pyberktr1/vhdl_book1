// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
// Date        : Tue Feb 18 13:59:07 2025
// Host        : hberkal running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/fpga/kitap1b/13_dec2bcd/13_dec2bcd.sim/sim_1/impl/timing/xsim/dec2bcd_sim_time_impl.v
// Design      : dec2bcd
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "9924d5f5" *) 
(* NotValidForBitStream *)
module dec2bcd
   (X,
    Y);
  input [8:0]X;
  output [3:0]Y;

  wire [8:0]X;
  wire [8:0]X_IBUF;
  wire [3:0]Y;
  wire [3:0]Y_OBUF;
  wire \encode_proc.y_out_reg[0]_i_1_n_0 ;
  wire \encode_proc.y_out_reg[0]_i_2_n_0 ;
  wire \encode_proc.y_out_reg[1]_i_1_n_0 ;
  wire \encode_proc.y_out_reg[1]_i_2_n_0 ;
  wire \encode_proc.y_out_reg[2]_i_1_n_0 ;
  wire \encode_proc.y_out_reg[3]_i_1_n_0 ;
  wire \encode_proc.y_out_reg[3]_i_2_n_0 ;
  wire \encode_proc.y_out_reg[3]_i_3_n_0 ;

initial begin
 $sdf_annotate("dec2bcd_sim_time_impl.sdf",,,,"tool_control");
end
  IBUF \X_IBUF[0]_inst 
       (.I(X[0]),
        .O(X_IBUF[0]));
  IBUF \X_IBUF[1]_inst 
       (.I(X[1]),
        .O(X_IBUF[1]));
  IBUF \X_IBUF[2]_inst 
       (.I(X[2]),
        .O(X_IBUF[2]));
  IBUF \X_IBUF[3]_inst 
       (.I(X[3]),
        .O(X_IBUF[3]));
  IBUF \X_IBUF[4]_inst 
       (.I(X[4]),
        .O(X_IBUF[4]));
  IBUF \X_IBUF[5]_inst 
       (.I(X[5]),
        .O(X_IBUF[5]));
  IBUF \X_IBUF[6]_inst 
       (.I(X[6]),
        .O(X_IBUF[6]));
  IBUF \X_IBUF[7]_inst 
       (.I(X[7]),
        .O(X_IBUF[7]));
  IBUF \X_IBUF[8]_inst 
       (.I(X[8]),
        .O(X_IBUF[8]));
  OBUF \Y_OBUF[0]_inst 
       (.I(Y_OBUF[0]),
        .O(Y[0]));
  OBUF \Y_OBUF[1]_inst 
       (.I(Y_OBUF[1]),
        .O(Y[1]));
  OBUF \Y_OBUF[2]_inst 
       (.I(Y_OBUF[2]),
        .O(Y[2]));
  OBUF \Y_OBUF[3]_inst 
       (.I(Y_OBUF[3]),
        .O(Y[3]));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \encode_proc.y_out_reg[0] 
       (.CLR(1'b0),
        .D(\encode_proc.y_out_reg[0]_i_1_n_0 ),
        .G(\encode_proc.y_out_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(Y_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAE)) 
    \encode_proc.y_out_reg[0]_i_1 
       (.I0(X_IBUF[8]),
        .I1(\encode_proc.y_out_reg[0]_i_2_n_0 ),
        .I2(X_IBUF[7]),
        .O(\encode_proc.y_out_reg[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hBABBBABABABBBABB)) 
    \encode_proc.y_out_reg[0]_i_2 
       (.I0(X_IBUF[6]),
        .I1(X_IBUF[5]),
        .I2(X_IBUF[4]),
        .I3(X_IBUF[3]),
        .I4(X_IBUF[2]),
        .I5(X_IBUF[1]),
        .O(\encode_proc.y_out_reg[0]_i_2_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \encode_proc.y_out_reg[1] 
       (.CLR(1'b0),
        .D(\encode_proc.y_out_reg[1]_i_1_n_0 ),
        .G(\encode_proc.y_out_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(Y_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \encode_proc.y_out_reg[1]_i_1 
       (.I0(\encode_proc.y_out_reg[1]_i_2_n_0 ),
        .I1(X_IBUF[7]),
        .I2(X_IBUF[8]),
        .O(\encode_proc.y_out_reg[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFF1FFF1FFF1FFF0)) 
    \encode_proc.y_out_reg[1]_i_2 
       (.I0(X_IBUF[3]),
        .I1(X_IBUF[4]),
        .I2(X_IBUF[6]),
        .I3(X_IBUF[5]),
        .I4(X_IBUF[2]),
        .I5(X_IBUF[1]),
        .O(\encode_proc.y_out_reg[1]_i_2_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \encode_proc.y_out_reg[2] 
       (.CLR(1'b0),
        .D(\encode_proc.y_out_reg[2]_i_1_n_0 ),
        .G(\encode_proc.y_out_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(Y_OBUF[2]));
  LUT6 #(
    .INIT(64'h000000000000FFFE)) 
    \encode_proc.y_out_reg[2]_i_1 
       (.I0(X_IBUF[6]),
        .I1(X_IBUF[5]),
        .I2(X_IBUF[3]),
        .I3(X_IBUF[4]),
        .I4(X_IBUF[8]),
        .I5(X_IBUF[7]),
        .O(\encode_proc.y_out_reg[2]_i_1_n_0 ));
  (* XILINX_LEGACY_PRIM = "LD" *) 
  (* XILINX_TRANSFORM_PINMAP = "VCC:GE GND:CLR" *) 
  LDCE #(
    .INIT(1'b0)) 
    \encode_proc.y_out_reg[3] 
       (.CLR(1'b0),
        .D(\encode_proc.y_out_reg[3]_i_1_n_0 ),
        .G(\encode_proc.y_out_reg[3]_i_2_n_0 ),
        .GE(1'b1),
        .Q(Y_OBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \encode_proc.y_out_reg[3]_i_1 
       (.I0(X_IBUF[8]),
        .I1(X_IBUF[7]),
        .O(\encode_proc.y_out_reg[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \encode_proc.y_out_reg[3]_i_2 
       (.I0(X_IBUF[5]),
        .I1(\encode_proc.y_out_reg[3]_i_3_n_0 ),
        .I2(X_IBUF[0]),
        .I3(X_IBUF[7]),
        .O(\encode_proc.y_out_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \encode_proc.y_out_reg[3]_i_3 
       (.I0(X_IBUF[6]),
        .I1(X_IBUF[1]),
        .I2(X_IBUF[2]),
        .I3(X_IBUF[3]),
        .I4(X_IBUF[4]),
        .I5(X_IBUF[8]),
        .O(\encode_proc.y_out_reg[3]_i_3_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
