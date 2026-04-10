library IEEE;
use IEEE.std_logic_1164.all;

entity LIFO_testbench is
end LIFO_testbench;

architecture behavioural of LIFO_testbench is 

  component LIFO is 

    port (

      Enable : in std_logic;
      Reset : in std_logic;
      Push_Popn : in std_logic;
      D_IN : in std_logic_vector(3 downto 0);
      D_OUT : out std_logic_vector(3 downto 0);    --All the inputs and outputs of the entire 4x8 LIFO buffer diagram
      CLK : in std_logic;
      Full : out std_logic;
      Empty : out std_logic
      
   );

   end component;
   signal Enable, Reset, Push_Popn, CLK, Full, Empty : std_logic;
   signal D_IN : std_logic_vector(3 downto 0);
   signal D_OUT : std_logic_vector(3 downto 0); 

   begin

    uut: ALU port map(Enable => Enable, Reset => Reset, Push_Popn => Push_Popn, D_IN => D_IN, D_OUT => D_OUT, CLK => CLK, Full => Full, Empty => Empty);
    stimulate_process: process

    begin
      
       Enable <= '0'; Reset <= '0'; Push_Popn <= '0'; CLK <= '0'; D_IN <= "0000"; wait for 10 ns;
       assert false report "Simulation Finished" severity note;
       wait for 10 ns;

    end process;
end behavioural;
