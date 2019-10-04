library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
  port (clk,rst,go: in std_logic;
        i: in std_logic_vector(3 downto 0);
        fib: out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is
  component datapath
          port (clk,rst,b_sel, a_sel, b_ld, a_ld, c_ld, count_en, count_ld : in std_logic;
          i_in: in std_logic_vector(3 downto 0);
          fib: out std_logic_vector(7 downto 0);
          n: out std_logic_vector(3 downto 0)
          );
  end component;
  component tlc
         port(clk,rst,go_i: std_logic;
       a_sel,b_sel,a_ld,b_ld,c_ld,count_ld,count_en: out std_logic;
       n : in std_logic_vector (3 downto 0)
       );
  end component;
  signal b_sel,a_sel, b_ld, a_ld, c_ld, count_en, count_ld: std_logic;
   signal nn: std_logic_vector (3 downto 0);
begin 
  u0: datapath port map(clk,rst,b_sel,a_sel, b_ld, a_ld, c_ld, count_en, count_ld,i,fib,nn);
  u1: tlc port map(clk,rst,go,a_sel,b_sel,a_ld,b_ld,c_ld,count_ld,count_en,nn);
end rtl;