-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Sun Feb 23 13:38:40 2025
-- Host        : hberkal running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/fpga/kitap1b/16_SR_latch/16_SR_latch.sim/sim_1/impl/func/xsim/SR_latch_sim_func_impl.vhd
-- Design      : SR_latch
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity SR_latch is
  port (
    S : in STD_LOGIC;
    R : in STD_LOGIC;
    Q : out STD_LOGIC;
    Qp : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of SR_latch : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of SR_latch : entity is "747cb418";
end SR_latch;

architecture STRUCTURE of SR_latch is
  signal Q_OBUF : STD_LOGIC;
  signal Qp_OBUF : STD_LOGIC;
  signal R_IBUF : STD_LOGIC;
  signal S_IBUF : STD_LOGIC;
begin
Q_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Q_OBUF,
      O => Q
    );
Q_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"0E"
    )
        port map (
      I0 => S_IBUF,
      I1 => Q_OBUF,
      I2 => R_IBUF,
      O => Q_OBUF
    );
Qp_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => Qp_OBUF,
      O => Qp
    );
Qp_OBUF_inst_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Q_OBUF,
      I1 => S_IBUF,
      O => Qp_OBUF
    );
R_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => R,
      O => R_IBUF
    );
S_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => S,
      O => S_IBUF
    );
end STRUCTURE;
