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

entity tb_mac is
--  Port ( );
end tb_mac;

architecture tb of tb_mac is
component dist_mem_gen_0
port (
    a: in std_logic_vector(13 downto 0);
    clk: in std_logic;
    spo: out std_logic_vector(7 downto 0));
end component;
component reg
generic (WIDTH: integer:=8);
port (clk: in std_logic;
    re: in std_logic;
    we: in std_logic;
    din: in std_logic_vector(WIDTH-1 downto 0);
    dout: out std_logic_vector(WIDTH-1 downto 0));
end component;
component mac
port(
    a: in std_logic_vector(7 downto 0);
    b: in std_logic_vector(7 downto 0);
    we: in std_logic;
    clk : in std_logic;
    cntrl: in std_logic;
    sum:out unsigned(0 to 15));
end component;
signal clk: std_logic:='0';
signal r_en: std_logic:='1';
signal en: std_logic:='1';
signal cntrl: std_logic:='1';
signal we: std_logic:='1';
signal a,c: std_logic_vector(13 downto 0);
signal data1,data2,b,d: std_logic_vector(7 downto 0);
signal sum: unsigned(15 downto 0);
constant clock_period:time:=10 ns;
begin
    uut1 : dist_mem_gen_0 port map (
            a=>a,
            clk=>clk,
            spo=>data1
         );
    uut2:  reg 
            generic map (
                WIDTH=>8
            )
            port map (
                clk=>clk,
                re=>r_en,
                we=>en,
                din=>data1,
                dout=>b
            ); 
    uut3 : dist_mem_gen_0 port map (
                a=>c,
                clk=>clk,
                spo=>data2
            );
    uut4:  reg 
              generic map (
                   WIDTH=>8
                )
              port map (
                   clk=>clk,
                   re=>r_en,
                   we=>en,
                   din=>data2,
                   dout=>d
                ); 
              
     uut5: mac port map (
                a=>b,
                b=>d,
                we=>we,
                clk=>clk,
                cntrl=>cntrl,
                sum=>sum);
--                );
--     ren: process
--     begin
--        r_en<='0';
--        wait for 10 ns;
--        r_en<='1';
--    end process
    clk_process: process
    begin
        clk<='0';
        wait for clock_period;
        clk<='1';
        wait for clock_period;
    end process;
    stim_proc: process
        begin
            for i in 0 to 127 loop
                a<=std_logic_vector(to_unsigned(i,14));
                c<=std_logic_vector(to_unsigned(i*128+(i-(i mod 128))/128,14));
                if i=0 then
                    cntrl<='1';
                    r_en<='0';
                else
                    cntrl<='0';
                    r_en<='1';
                end if;
            wait for 20 ns;
            end loop;
        end process;
end tb;
