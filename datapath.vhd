library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity datapath is
  port (clk,rst,b_sel, a_sel, b_ld, a_ld, c_ld, count_en, count_ld : in std_logic;
        i_in: in std_logic_vector(3 downto 0);
        fib: out std_logic_vector(7 downto 0);
        n: out std_logic_vector(3 downto 0)
        );
end datapath;

architecture rtl of datapath is
component count_dec
  port (clk,rst,en,ld: in std_logic;
       d: in std_logic_vector(3 downto 0);
       count: out std_logic_vector(3 downto 0));
end component;


component reg
  port (clk,rst,load: in std_logic;
        d: in std_logic_vector(7 downto 0);
        q: out std_logic_vector(7 downto 0));
end component;
component adder_8bit 
  port (a,b: in std_logic_vector (7 downto 0);
       y: out std_logic_vector(7 downto 0));
end component;
  signal a_in,a_out,b_in,b_out,sum,s_out : std_logic_vector(7 downto 0);
begin
  
process(a_sel,b_out)
begin
    if a_sel = '0' then
        a_in <= "00000000";
    else
        a_in <= b_out;
    end if ;
end process;
process(b_sel,s_out)
begin
    if a_sel = '0' then
        b_in <= "00000001";
    else
        b_in <= s_out;
    end if ;
end process;

u0: reg port map (clk,rst,a_ld,a_in,a_out);
u1: reg port map (clk,rst,b_ld,b_in,b_out);
u2: reg port map (clk,rst,c_ld,sum,s_out);
u3: count_dec port map (clk,rst,count_en,count_ld,i_in,n);
u4: adder_8bit port map (a_out,b_out,sum);
 fib <= s_out;
end rtl;
