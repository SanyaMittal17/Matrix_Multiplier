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

--entity mac is
--  Port ( clk: in std_logic;
--         row: in integer range 0 to 127 ;
--         column: in integer range 0 to 127;
--         cntlr: in std_logic;
--         c: out std_logic_vector(15 downto 0));
         
--end mac;

--architecture Behavioral of mac is
--component dist_mem_gen_0
--  port (
--  spo : out STD_LOGIC_VECTOR ( 7 downto 0 );
--  a : in STD_LOGIC_VECTOR ( 13 downto 0 );
--  clk : in STD_LOGIC
--);
--end component;
--component multiplier
--Port (  a: in std_logic_vector(7 downto 0);
--        b: in std_logic_vector(7 downto 0);
--        c: out std_logic_vector(15 downto 0));
--end component;
----component accumulator
----  Port ( clk: in std_logic;
----       we: in std_logic;
----       cntrl: in std_logic;
----       a: in std_logic_vector(15 downto 0);
----       sum: out std_logic_vector(15 downto 0));
----end component;
--signal y,z:std_logic_vector(7 downto 0);
--signal c1,c2:std_logic_vector(15 downto 0);
--signal flag: std_logic:='1';
--signal me:std_logic_vector:="10000000";
--signal we:std_logic_vector:="00000001";
--signal row_index,column_index: std_logic_vector(13 downto 0);
--begin
--    UUT1: dist_mem_gen_0 port map(spo=>y,a=>row_index,clk=>clk);
--    UUT3: dist_mem_gen_0 port map(spo=>z,a=>column_index,clk=>clk);
--    UUT2: multiplier port map(a=>y,b=>z,c=>c);
--process(clk)
--begin
--if (flag='1' and rising_edge(clk)) then ---"100000000000000"
--row_index<=row_index+me;  ---Check left right
--column_index<=column_index+we;
--c1<=c1+c2;
-----end if;
--if column_index="111111111111111" then
--flag<='0';
--end if;
--end if;
--end process;
--c<=c1;
--end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mac is
--  Port ( );
port(
    a: in std_logic_vector(7 downto 0);
    b: in std_logic_vector(7 downto 0);
    we: in std_logic;
    clk : in std_logic;
    cntrl: in std_logic;
    sum:out unsigned(0 to 15));
--   d3: out std_logic);
end mac;

architecture Behavioral of mac is
component multiplier is
port(a,b : in std_logic_vector(7 downto 0);
    c: out unsigned(15 downto 0));
end component;
--component dist_mem_gen_0 IS
--  PORT (
--    a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
--    spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--  );
--END component;

--signal y,z:std_logic_vector(7 downto 0);
signal temp_sum: unsigned(16 downto 0);
signal product:unsigned(15 downto 0);
signal flag: std_logic:='1';
--signal row_index,column_index: std_logic_vector(13 downto 0):="00000000000001";-----intialize rowindex and column index according to the element to be found
begin

--    UUT1: dist_mem_gen_0 port map(a=>row_index,spo=>y);
--    UUT3: dist_mem_gen_0 port map(a=>column_index,spo=>z);
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
--else 
--if (flag='1' and rising_edge(clk)) then
--row_index<=row_index+"10000000";  ---Check left right
--column_index<=column_index+"00000001";
--c<=c+c2;
-----end if;
--    if column_index="10000000" then
--   flag<='0';
--    end if;
--else 
--end if;
--end if;
end process;
--f<=c;
sum<=temp_sum(15 downto 0);

--d3<=not(flag);
end Behavioral;
