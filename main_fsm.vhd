----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2022 12:34:13 PM
-- Design Name: 
-- Module Name: main_fsm - Behavioral
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

entity main_fsm is
port ( input_addr: in std_logic_vector(13 downto 0):=(others=>'0');
        clock: in std_logic;
        q: out std_logic_vector(6 downto 0);
        an: out std_logic_vector(3 downto 0));
end main_fsm;

architecture Behavioral of main_fsm is
component main
Port (a : in std_logic_vector(3 downto 0);
  b : in std_logic_vector(3 downto 0);
  c : in std_logic_vector(3 downto 0);
  d: in std_logic_vector(3 downto 0);
  clk : in std_logic ;
  q: out std_logic_vector(6 downto 0);
  an : out std_logic_vector(3 downto 0)); 
end component;
component fsm 
Port (clk: in std_logic;
    RAM1_we: out std_logic;
    Input_register_re:out std_logic;
    Input_register_we:out std_logic;
    Output_register_re:out std_logic;
    Output_register_we:out std_logic; 
    we_mac: out std_logic;      
    cntrl: out std_logic;
    address_rom1:inout integer:=0;
    address_rom2:inout integer:=0;
    address_ram:out integer:=0
    );  
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
component multiplier 
Port (  a: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        c: out unsigned(15 downto 0));
end component;
component dist_mem_gen_0 
PORT (
    a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    clk : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;
component dist_mem_gen_1 
PORT (
    a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;
component reg 
generic (WIDTH: integer:=8);
port (clk: in std_logic;
    re:in std_logic;
    we: in std_logic;
    din: in std_logic_vector(WIDTH-1 downto 0);
    dout: out std_logic_vector(WIDTH-1 downto 0));
end component;
signal addr_rom1,addr_rom2,addr_ram: std_logic_vector(13 downto 0);
signal data1,data2,a,b: std_logic_vector(7 downto 0);
signal output,c,final_output,to_be_displayed: std_logic_vector(15 downto 0);
signal data3: unsigned(15 downto 0);
signal RAM1_we,Input_register_re,Input_register_we,Output_register_re,Output_register_we,cntrl,we_mac: std_logic;
signal rom1,rom2,ram: integer;
signal clk: std_logic:='0';
constant clock_period:time:=1 ns;
begin
    uut1: fsm port map (clk=>clk, 
                        RAM1_we=>RAM1_we,
                        Input_register_re=>Input_register_re,
                        Input_register_we=>Input_register_we,
                        Output_register_re=>Output_register_re,
                        Output_register_we=>Output_register_we,
                        we_mac=>we_mac,
                        cntrl=>cntrl,
                        address_rom1=>rom1,
                        address_rom2=>rom2,
                        address_ram=>ram);
    addr_rom1<=std_logic_vector(to_signed(rom1,addr_rom1'length));
    addr_rom2<=std_logic_vector(to_signed(rom2,addr_rom2'length));
    uut2: dist_mem_gen_0 port map (a=>addr_rom1,
                                    clk=>clk,
                                    spo=>data1);
    uut3: dist_mem_gen_0 port map (a=>addr_rom2,
                                    clk=>clk,
                                    spo=>data2);
    uut4: reg 
            generic map( WIDTH=>8)
            port map (  clk=>clk,
                        re=>Input_register_re,
                        we=>Input_register_we,
                        din=>data1,
                        dout=>a);
    uut5: reg 
             generic map( WIDTH=>8)
             port map (  clk=>clk,
                         re=>Input_register_re,
                         we=>Input_register_we,
                         din=>data2,
                         dout=>b);                   
    uut6: mac port map (a=>a,
                        b=>b,
                        we=>we_mac,
                        clk=>clk,
                        cntrl=>cntrl,
                        sum=>data3);
    output<=std_logic_vector(data3);
    uut7: reg 
              generic map( WIDTH=>16)
              port map (  clk=>clk,
            re=>Input_register_re,
                we=>Input_register_we,
                din=>output,
            dout=>c);
     addr_ram<=std_logic_vector(to_signed(ram,addr_ram'length));
     uut8: dist_mem_gen_1  
                        port map 
                            (a=>addr_ram,
                            d=>c,
                            clk=>clk,
                            we=>RAM1_we,
                            spo=>final_output);
     uut9: dist_mem_gen_1
            port map 
            (a=>input_addr,
            d=>c,
            clk=>clock,
            we=>'0',
            spo=>to_be_displayed);
        
       uut10: main port map 
                    (a=>to_be_displayed(3 downto 0),
                    b=>to_be_displayed(7 downto 4),
                    c=>to_be_displayed(11 downto 8),
                    d=>to_be_displayed(15 downto 12),
                    clk=>clock,
                    q=>q,
                    an=>an);
      clk_process: process
                                begin
                                    clk<='0';
                                    wait for clock_period;
                                    clk<='1';
                                    wait for clock_period;
                                end process;
end Behavioral;
