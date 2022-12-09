----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2022 01:31:20 PM
-- Design Name: 
-- Module Name: tb_reg - tb
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

entity tb_multiplier is
--  Port ( );
end tb_multiplier;

architecture tb of tb_multiplier is
component dist_mem_gen_0
port (
    a: in std_logic_vector(13 downto 0);
    clk: in std_logic;
    spo: out std_logic_vector(7 downto 0));
end component;
component reg
generic (WIDTH: integer:=8);
port (clk: in std_logic;
    we: in std_logic;
    din: in std_logic_vector(WIDTH-1 downto 0);
    dout: out std_logic_vector(WIDTH-1 downto 0));
end component;
component multiplier
port ( a: in std_logic_vector(7 downto 0);
       b: in std_logic_vector(7 downto 0);
       c: out unsigned(15 downto 0));
end component;
signal clk: std_logic:='0';
signal en: std_logic:='1';
signal a,b,c,d: std_logic_vector(13 downto 0);
signal data1,data2: std_logic_vector(7 downto 0);
signal product: unsigned(15 downto 0);
constant clock_period:time:=5 ns;
begin
    uut1:  reg 
            generic map (
                WIDTH=>14
            )
            port map (
                clk=>clk,
                we=>en,
                din=>a,
                dout=>b
            ); 
    uut2 : dist_mem_gen_0 port map (
            a=>b,
            clk=>clk,
            spo=>data1
         );
    uut3:  reg 
              generic map (
                   WIDTH=>14
                )
              port map (
                   clk=>clk,
                   we=>en,
                   din=>c,
                   dout=>d
                ); 
              uut4 : dist_mem_gen_0 port map (
                    a=>d,
                    clk=>clk,
                    spo=>data2
                );
              uut5: multiplier port map (
                    a=>data1,
                    b=>data2,
                    c=>product
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
            for i in 0 to 127 loop
                a<=std_logic_vector(to_unsigned(i,14));
                c<=std_logic_vector(to_unsigned(i*128+(i-(i mod 128))/128,14));
            wait for 10 ns;
            end loop;
        end process;
end tb;
