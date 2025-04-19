-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
-- Date        : Thu Mar  6 16:25:42 2025
-- Host        : hberkal running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               D:/fpga/kitap1b/31_bcd_module/31_bcd_module.sim/sim_1/impl/func/xsim/bcd_module_sim_func_impl.vhd
-- Design      : bcd_module
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bcd_counter_mod is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    c_1 : out STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    resetn_IBUF : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
end bcd_counter_mod;

architecture STRUCTURE of bcd_counter_mod is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \cnt[3]_i_1_n_0\ : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute \PinAttr:I1:HOLD_DETOUR\ : integer;
  attribute \PinAttr:I1:HOLD_DETOUR\ of \cnt[1]_i_1\ : label is 192;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt[1]_i_1\ : label is "soft_lutpair1";
  attribute \PinAttr:I1:HOLD_DETOUR\ of \cnt[2]_i_1\ : label is 192;
  attribute SOFT_HLUTNM of \cnt[2]_i_1\ : label is "soft_lutpair1";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => plusOp(0)
    );
\cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => plusOp(1)
    );
\cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => plusOp(2)
    );
\cnt[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA80000FFFFFFFF"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(1),
      I4 => E(0),
      I5 => resetn_IBUF,
      O => \cnt[3]_i_1_n_0\
    );
\cnt[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => plusOp(3)
    );
\cnt[3]_i_2__2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(1),
      I4 => E(0),
      O => c_1
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => plusOp(0),
      Q => \^q\(0),
      R => \cnt[3]_i_1_n_0\
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => plusOp(1),
      Q => \^q\(1),
      R => \cnt[3]_i_1_n_0\
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => plusOp(2),
      Q => \^q\(2),
      R => \cnt[3]_i_1_n_0\
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => plusOp(3),
      Q => \^q\(3),
      R => \cnt[3]_i_1_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bcd_counter_mod_0 is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \eqOp__0\ : out STD_LOGIC;
    c_1 : in STD_LOGIC;
    resetn_IBUF : in STD_LOGIC;
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bcd_counter_mod_0 : entity is "bcd_counter_mod";
end bcd_counter_mod_0;

architecture STRUCTURE of bcd_counter_mod_0 is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \cnt[3]_i_1__2_n_0\ : STD_LOGIC;
  signal \plusOp__0\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt[0]_i_1__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \cnt[1]_i_1__0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \cnt[2]_i_1__0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \cnt[3]_i_3\ : label is "soft_lutpair3";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\cnt[0]_i_1__0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \plusOp__0\(0)
    );
\cnt[1]_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \plusOp__0\(1)
    );
\cnt[2]_i_1__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \plusOp__0\(2)
    );
\cnt[3]_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAA80000FFFFFFFF"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(1),
      I4 => c_1,
      I5 => resetn_IBUF,
      O => \cnt[3]_i_1__2_n_0\
    );
\cnt[3]_i_2__1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00080000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(1),
      I4 => c_1,
      O => E(0)
    );
\cnt[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \plusOp__0\(3)
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => c_1,
      D => \plusOp__0\(0),
      Q => \^q\(0),
      R => \cnt[3]_i_1__2_n_0\
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => c_1,
      D => \plusOp__0\(1),
      Q => \^q\(1),
      R => \cnt[3]_i_1__2_n_0\
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => c_1,
      D => \plusOp__0\(2),
      Q => \^q\(2),
      R => \cnt[3]_i_1__2_n_0\
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => c_1,
      D => \plusOp__0\(3),
      Q => \^q\(3),
      R => \cnt[3]_i_1__2_n_0\
    );
co_OBUF_inst_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(3),
      O => \eqOp__0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bcd_counter_mod_1 is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \eqOp__1\ : out STD_LOGIC;
    c_1 : in STD_LOGIC;
    \eqOp__0\ : in STD_LOGIC;
    resetn_IBUF : in STD_LOGIC;
    \cnt_reg[3]_0\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bcd_counter_mod_1 : entity is "bcd_counter_mod";
end bcd_counter_mod_1;

architecture STRUCTURE of bcd_counter_mod_1 is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \cnt[3]_i_1__1_n_0\ : STD_LOGIC;
  signal \geqOp__1\ : STD_LOGIC;
  signal \plusOp__1\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt[0]_i_1__1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \cnt[1]_i_1__1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \cnt[2]_i_1__1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \cnt[3]_i_3__0\ : label is "soft_lutpair6";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\cnt[0]_i_1__1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \plusOp__1\(0)
    );
\cnt[1]_i_1__1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \plusOp__1\(1)
    );
\cnt[2]_i_1__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \plusOp__1\(2)
    );
\cnt[3]_i_1__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"80FF"
    )
        port map (
      I0 => \geqOp__1\,
      I1 => \eqOp__0\,
      I2 => c_1,
      I3 => resetn_IBUF,
      O => \cnt[3]_i_1__1_n_0\
    );
\cnt[3]_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0008000000000000"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(1),
      I4 => c_1,
      I5 => \eqOp__0\,
      O => E(0)
    );
\cnt[3]_i_3__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \plusOp__1\(3)
    );
\cnt[3]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(1),
      O => \geqOp__1\
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \cnt_reg[3]_0\(0),
      D => \plusOp__1\(0),
      Q => \^q\(0),
      R => \cnt[3]_i_1__1_n_0\
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \cnt_reg[3]_0\(0),
      D => \plusOp__1\(1),
      Q => \^q\(1),
      R => \cnt[3]_i_1__1_n_0\
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \cnt_reg[3]_0\(0),
      D => \plusOp__1\(2),
      Q => \^q\(2),
      R => \cnt[3]_i_1__1_n_0\
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => \cnt_reg[3]_0\(0),
      D => \plusOp__1\(3),
      Q => \^q\(3),
      R => \cnt[3]_i_1__1_n_0\
    );
co_OBUF_inst_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(3),
      O => \eqOp__1\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bcd_counter_mod_2 is
  port (
    Q : out STD_LOGIC_VECTOR ( 3 downto 0 );
    co_OBUF : out STD_LOGIC;
    \eqOp__0\ : in STD_LOGIC;
    c_1 : in STD_LOGIC;
    \eqOp__1\ : in STD_LOGIC;
    resetn_IBUF : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of bcd_counter_mod_2 : entity is "bcd_counter_mod";
end bcd_counter_mod_2;

architecture STRUCTURE of bcd_counter_mod_2 is
  signal \^q\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \cnt[3]_i_1__0_n_0\ : STD_LOGIC;
  signal \eqOp__2\ : STD_LOGIC;
  signal \geqOp__2\ : STD_LOGIC;
  signal \plusOp__2\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \cnt[0]_i_1__2\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \cnt[1]_i_1__2\ : label is "soft_lutpair10";
begin
  Q(3 downto 0) <= \^q\(3 downto 0);
\cnt[0]_i_1__2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(0),
      O => \plusOp__2\(0)
    );
\cnt[1]_i_1__2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      O => \plusOp__2\(1)
    );
\cnt[2]_i_1__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"78"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(1),
      I2 => \^q\(2),
      O => \plusOp__2\(2)
    );
\cnt[3]_i_1__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8000FFFF"
    )
        port map (
      I0 => \geqOp__2\,
      I1 => \eqOp__1\,
      I2 => c_1,
      I3 => \eqOp__0\,
      I4 => resetn_IBUF,
      O => \cnt[3]_i_1__0_n_0\
    );
\cnt[3]_i_3__1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7F80"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(0),
      I2 => \^q\(2),
      I3 => \^q\(3),
      O => \plusOp__2\(3)
    );
\cnt[3]_i_4__0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA8"
    )
        port map (
      I0 => \^q\(3),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(1),
      O => \geqOp__2\
    );
\cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => \plusOp__2\(0),
      Q => \^q\(0),
      R => \cnt[3]_i_1__0_n_0\
    );
\cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => \plusOp__2\(1),
      Q => \^q\(1),
      R => \cnt[3]_i_1__0_n_0\
    );
\cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => \plusOp__2\(2),
      Q => \^q\(2),
      R => \cnt[3]_i_1__0_n_0\
    );
\cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK,
      CE => E(0),
      D => \plusOp__2\(3),
      Q => \^q\(3),
      R => \cnt[3]_i_1__0_n_0\
    );
co_OBUF_inst_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \eqOp__2\,
      I1 => \eqOp__0\,
      I2 => c_1,
      I3 => \eqOp__1\,
      O => co_OBUF
    );
co_OBUF_inst_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \^q\(1),
      I1 => \^q\(2),
      I2 => \^q\(0),
      I3 => \^q\(3),
      O => \eqOp__2\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bcd_module is
  port (
    q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    ci : in STD_LOGIC;
    co : out STD_LOGIC;
    resetn : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of bcd_module : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of bcd_module : entity is "e0789490";
  attribute num_digits : integer;
  attribute num_digits of bcd_module : entity is 4;
end bcd_module;

architecture STRUCTURE of bcd_module is
  signal c_1 : STD_LOGIC;
  signal c_2 : STD_LOGIC;
  signal c_3 : STD_LOGIC;
  signal ci_IBUF : STD_LOGIC;
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal co_OBUF : STD_LOGIC;
  signal \eqOp__0\ : STD_LOGIC;
  signal \eqOp__1\ : STD_LOGIC;
  signal q_OBUF : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal resetn_IBUF : STD_LOGIC;
begin
\bcd_gen[0].bcd_counter_mod_inst\: entity work.bcd_counter_mod
     port map (
      CLK => clk_IBUF_BUFG,
      E(0) => ci_IBUF,
      Q(3 downto 0) => q_OBUF(3 downto 0),
      c_1 => c_1,
      resetn_IBUF => resetn_IBUF
    );
\bcd_gen[1].bcd_counter_mod_inst\: entity work.bcd_counter_mod_0
     port map (
      CLK => clk_IBUF_BUFG,
      E(0) => c_2,
      Q(3 downto 0) => q_OBUF(7 downto 4),
      c_1 => c_1,
      \eqOp__0\ => \eqOp__0\,
      resetn_IBUF => resetn_IBUF
    );
\bcd_gen[2].bcd_counter_mod_inst\: entity work.bcd_counter_mod_1
     port map (
      CLK => clk_IBUF_BUFG,
      E(0) => c_3,
      Q(3 downto 0) => q_OBUF(11 downto 8),
      c_1 => c_1,
      \cnt_reg[3]_0\(0) => c_2,
      \eqOp__0\ => \eqOp__0\,
      \eqOp__1\ => \eqOp__1\,
      resetn_IBUF => resetn_IBUF
    );
\bcd_gen[3].bcd_counter_mod_inst\: entity work.bcd_counter_mod_2
     port map (
      CLK => clk_IBUF_BUFG,
      E(0) => c_3,
      Q(3 downto 0) => q_OBUF(15 downto 12),
      c_1 => c_1,
      co_OBUF => co_OBUF,
      \eqOp__0\ => \eqOp__0\,
      \eqOp__1\ => \eqOp__1\,
      resetn_IBUF => resetn_IBUF
    );
ci_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => ci,
      O => ci_IBUF
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
co_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => co_OBUF,
      O => co
    );
\q_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(0),
      O => q(0)
    );
\q_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(10),
      O => q(10)
    );
\q_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(11),
      O => q(11)
    );
\q_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(12),
      O => q(12)
    );
\q_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(13),
      O => q(13)
    );
\q_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(14),
      O => q(14)
    );
\q_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(15),
      O => q(15)
    );
\q_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(1),
      O => q(1)
    );
\q_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(2),
      O => q(2)
    );
\q_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(3),
      O => q(3)
    );
\q_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(4),
      O => q(4)
    );
\q_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(5),
      O => q(5)
    );
\q_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(6),
      O => q(6)
    );
\q_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(7),
      O => q(7)
    );
\q_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(8),
      O => q(8)
    );
\q_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => q_OBUF(9),
      O => q(9)
    );
resetn_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => resetn,
      O => resetn_IBUF
    );
end STRUCTURE;
