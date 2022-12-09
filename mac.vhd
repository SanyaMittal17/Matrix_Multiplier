------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 11/10/2022 03:36:55 PM
---- Design Name: 
---- Module Name: mac - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mac is

port(
    a: in std_logic_vector(7 downto 0);
    b: in std_logic_vector(7 downto 0);
    we: in std_logic;
    clk : in std_logic;
    cntrl: in std_logic;
    sum:out unsigned(0 to 15));

end mac;

architecture Behavioral of mac is
component multiplier is
port(a,b : in std_logic_vector(7 downto 0);
    c: out unsigned(15 downto 0));
end component;

signal temp_sum: unsigned(16 downto 0);
signal product:unsigned(15 downto 0);
signal flag: std_logic:='1';

begin
        uut1: multiplier port map(a=>a,b=>b,c=>product);
process(clk)
variable count: integer :=0;
begin
if (rising_edge(clk) and we='1') then
    count:=count+1;
    if (cntrl='1') then
        temp_sum<=unsigned(to_unsigned(to_integer(unsigned(product)),temp_sum'length));
    else
        temp_sum<=unsigned(to_unsigned(to_integer(unsigned(product))+to_integer(unsigned(temp_sum)),temp_sum'length));
    end if;

end if;
end process;
--f<=c;
sum<=temp_sum(15 downto 0);

--d3<=not(flag);
end Behavioral;
