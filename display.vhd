----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 08:15:55 PM
-- Design Name: 
-- Module Name: display - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
--Port ( );
end display;

architecture Behavioral of display is
component main
Port (a : in std_logic_vector(3 downto 0);
  b : in std_logic_vector(3 downto 0);
  c : in std_logic_vector(3 downto 0);
  d: in std_logic_vector(3 downto 0);
  clk : in std_logic ;
  q: out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0)); 
end component;
component main_fsm
end component;
begin


end Behavioral;
