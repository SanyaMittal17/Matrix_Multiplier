----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2022 03:38:29 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
generic (WIDTH: integer:=8);
port (clk: in std_logic;
    re:in std_logic;
    we: in std_logic;
    din: in std_logic_vector(WIDTH-1 downto 0);
    dout: out std_logic_vector(WIDTH-1 downto 0));
end reg;

architecture Behavioral of reg is
signal output: std_logic_vector(WIDTH-1 downto 0);
begin
process(clk)
begin
if (re='1') then
output<=din;
end if;
if (rising_edge(clk) and we='1') then
dout<=output;
end if;
end process;
end Behavioral;
