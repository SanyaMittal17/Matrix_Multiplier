library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FSM IS
Port (clk: in std_logic;
    RAM1_we: out std_logic;
    Input_register_re:out std_logic;
    Input_register_we:out std_logic;
    Output_register_re:out std_logic;
    Output_register_we:out std_logic; 
    we_mac:out std_logic;      
    cntrl: out std_logic;
    address_rom1:inout integer:=0;
    address_rom2:inout integer:=0;
    address_ram:out integer:=0
    );  
end FSM;
architecture machine of FSM IS
type state_type is (Reg1,MACin,MACout,final);
signal   cur_state : state_type := Reg1;
signal   next_state: state_type := Reg1;
begin
---Write in ram address
process (clk)begin
if (clk'EVENT AND clk = '1') then
cur_state <= next_state;
end if;
end process;
process (cur_state)
variable  counter,count:integer:=-1;
variable MAC_iter_count:integer:=0;
variable j:integer:=0;
variable i:integer:=0;
begin
next_state <= cur_state;
case cur_state is
when Reg1=>
we_mac<='0';
    RAM1_we<='0';
Input_register_we<='0';
Output_register_re<='0';
Output_register_we<='0';       
Input_register_re<='1';
counter:=counter+1;
count:=count+1;
if counter=0 then
cntrl<='1';
else 
cntrl<='0';
end if;
address_rom1<= 128+address_rom1;
address_rom2<= 1+address_rom2;


next_state <= MACin;                                                                           
when MACin =>
Input_register_re<='0';
Input_register_we<='1';
we_mac<='1' after 3 ns;
next_state <= MACout;  
when MACout=>
if counter<128 then
next_state<=Reg1;
else
output_register_re<='1';
cntrl<='1';
counter:=0;
next_state <=final; 
end if;
when final=>
output_register_we<='1';
i:=address_rom1 mod 128;
j:=(address_rom2 -(address_rom2 mod 128))/128;
address_ram<=128*j+i;
next_state <= Reg1;
RAM1_we<='1';
Input_register_re<='0';
Input_register_we<='0';
Output_register_re<='0';
cntrl<='0';
we_mac<='0';
end case;
end process;
end machine;