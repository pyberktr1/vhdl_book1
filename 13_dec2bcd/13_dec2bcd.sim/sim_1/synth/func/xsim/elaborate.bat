@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Tue Feb 18 14:49:07 +0300 2025
REM SW Build 3526262 on Mon Apr 18 15:48:16 MDT 2022
REM
REM IP Build 3524634 on Mon Apr 18 20:55:01 MDT 2022
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot dec2bcd_sim_func_synth xil_defaultlib.dec2bcd_sim -log elaborate.log"
call xelab  --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot dec2bcd_sim_func_synth xil_defaultlib.dec2bcd_sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
