-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Tue Feb 25 16:25:46 2025
-- Host        : hberkal running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/fpga/kitap1b/20_JK_FF_wpc/20_JK_FF_wpc.sim/sim_1/impl/func/xsim/JK_FF_wpc_sim_func_impl.vhd
-- Design      : JK_FF_wpc
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity JK_FF_wpc is
  port (
    pre : in STD_LOGIC;
    clr : in STD_LOGIC;
    J : in STD_LOGIC;
    K : in STD_LOGIC;
    clk : in STD_LOGIC;
    Q : out STD_LOGIC;
    Qp : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of JK_FF_wpc : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of JK_FF_wpc : entity is "ce387e3b";
end JK_FF_wpc;

architecture STRUCTURE of JK_FF_wpc is
  signal J_IBUF : STD_LOGIC;
  signal K_IBUF : STD_LOGIC;
  signal \QQp[0]_i_1_n_0\ : STD_LOGIC;
  signal \QQp[1]_i_1_n_0\ : STD_LOGIC;
  signal Q_OBUF : STD_LOGIC;
  signal Qp_OBUF : STD_LOGIC;
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal clr_IBUF : STD_LOGIC;
  signal pre_IBUF : STD_LOGIC;
begin
J_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => J,
      O => J_IBUF
    );
K_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => K,
      O => K_IBUF
    );
\QQp[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"50F0C0F0"
    )
        port map (
      I0 => J_IBUF,
      I1 => K_IBUF,
      I2 => pre_IBUF,
      I3 => clr_IBUF,
      I4 => Qp_OBUF,
      O => \QQp[0]_i_1_n_0\
    );
\QQp[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3F0FAF0F"
    )
        port map (
      I0 => J_IBUF,
      I1 => K_IBUF,
      I2 => pre_IBUF,
      I3 => clr_IBUF,
      I4 => Q_OBUF,
      O => \QQp[1]_i_1_n_0\
    );
\QQp_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1',
      IS_C_INVERTED => '1'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \QQp[0]_i_1_n_0\,
      Q => Qp_OBUF,
      R => '0'
    );
\QQp_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1',
      IS_C_INVERTED => '1'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \QQp[1]_i_1_n_0\,
      Q => Q_OBUF,
      R => '0'
    );
Q_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Q_OBUF,
      O => Q
    );
Qp_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Qp_OBUF,
      O => Qp
    );
clk_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => clk_IBUF,
      O => clk_IBUF_BUFG
    );
clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clk,
      O => clk_IBUF
    );
clr_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clr,
      O => clr_IBUF
    );
pre_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => pre,
      O => pre_IBUF
    );
end STRUCTURE;
