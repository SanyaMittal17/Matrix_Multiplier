----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2022 11:34:48 AM
-- Design Name: 
-- Module Name: tb_ROM_block - tb
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ROM_block is
end tb_ROM_block;

architecture tb of tb_ROM_block is
component dist_mem_gen_0
port (
    a: in std_logic_vector(13 downto 0);
    clk: in std_logic;
    spo: out std_logic_vector(7 downto 0));
end component;
signal clk: std_logic:='0';
signal rdaddress: std_logic_vector(13 downto 0):=(others=>'0');
signal data: std_logic_vector(7 downto 0):=(others=>'0');
constant clock_period:time:=10 ns;
signal i: integer;
begin
    uut : dist_mem_gen_0 port map (
            a=>rdaddress,
            clk=>clk,
            spo=>data
         );
    clk_process: process
    begin
        clk<='0';
        wait for clock_period/2;
        clk<='1';
        wait for clock_period/2;
    end process;
    stim_proc: process
    begin
        for i in 0 to 16383 loop
            rdaddress<=std_logic_vector(to_unsigned(i,14));
        wait for 20 ns;
        end loop;
    end process;

end tb;
