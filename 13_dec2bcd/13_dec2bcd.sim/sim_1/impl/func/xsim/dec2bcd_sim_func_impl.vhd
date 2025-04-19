-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Tue Feb 18 17:32:49 2025
-- Host        : hberkal running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/fpga/kitap1b/13_dec2bcd/13_dec2bcd.sim/sim_1/impl/func/xsim/dec2bcd_sim_func_impl.vhd
-- Design      : dec2bcd
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dec2bcd is
  port (
    X : in STD_LOGIC_VECTOR ( 8 downto 0 );
    Y : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of dec2bcd : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of dec2bcd : entity is "584b40e6";
end dec2bcd;

architecture STRUCTURE of dec2bcd is
  signal X_IBUF : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal Y_OBUF : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \Y_OBUF[0]_inst_i_2_n_0\ : STD_LOGIC;
  signal \Y_OBUF[1]_inst_i_2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Y_OBUF[0]_inst_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \Y_OBUF[3]_inst_i_1\ : label is "soft_lutpair0";
begin
\X_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(0),
      O => X_IBUF(0)
    );
\X_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(1),
      O => X_IBUF(1)
    );
\X_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(2),
      O => X_IBUF(2)
    );
\X_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(3),
      O => X_IBUF(3)
    );
\X_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(4),
      O => X_IBUF(4)
    );
\X_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(5),
      O => X_IBUF(5)
    );
\X_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(6),
      O => X_IBUF(6)
    );
\X_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(7),
      O => X_IBUF(7)
    );
\X_IBUF[8]_inst\: unisim.vcomponents.IBUF
     port map (
      I => X(8),
      O => X_IBUF(8)
    );
\Y_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(0),
      O => Y(0)
    );
\Y_OBUF[0]_inst_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAEEFE"
    )
        port map (
      I0 => X_IBUF(8),
      I1 => X_IBUF(6),
      I2 => \Y_OBUF[0]_inst_i_2_n_0\,
      I3 => X_IBUF(5),
      I4 => X_IBUF(7),
      O => Y_OBUF(0)
    );
\Y_OBUF[0]_inst_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BABBBABA"
    )
        port map (
      I0 => X_IBUF(4),
      I1 => X_IBUF(3),
      I2 => X_IBUF(2),
      I3 => X_IBUF(1),
      I4 => X_IBUF(0),
      O => \Y_OBUF[0]_inst_i_2_n_0\
    );
\Y_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(1),
      O => Y(1)
    );
\Y_OBUF[1]_inst_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \Y_OBUF[1]_inst_i_2_n_0\,
      I1 => X_IBUF(8),
      I2 => X_IBUF(7),
      O => Y_OBUF(1)
    );
\Y_OBUF[1]_inst_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEEFEEEFEEEFEEEE"
    )
        port map (
      I0 => X_IBUF(6),
      I1 => X_IBUF(5),
      I2 => X_IBUF(4),
      I3 => X_IBUF(3),
      I4 => X_IBUF(2),
      I5 => X_IBUF(1),
      O => \Y_OBUF[1]_inst_i_2_n_0\
    );
\Y_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(2),
      O => Y(2)
    );
\Y_OBUF[2]_inst_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1111111111111110"
    )
        port map (
      I0 => X_IBUF(7),
      I1 => X_IBUF(8),
      I2 => X_IBUF(6),
      I3 => X_IBUF(5),
      I4 => X_IBUF(4),
      I5 => X_IBUF(3),
      O => Y_OBUF(2)
    );
\Y_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => Y_OBUF(3),
      O => Y(3)
    );
\Y_OBUF[3]_inst_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => X_IBUF(8),
      I1 => X_IBUF(7),
      O => Y_OBUF(3)
    );
end STRUCTURE;
