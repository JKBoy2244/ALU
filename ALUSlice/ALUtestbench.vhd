library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_testbench is 
end ALU_testbench;

architecture behavioural of ALU_testbench is 
  component ALU is

    port (

      A : in std_logic;                          --A is an input
      B : in std_logic;                          --B is an input
      C_in : in std_logic;                       --C_in is an input
      En : in std_logic;                         --En is an input
      F : in std_logic_vector(1 downto 0);       --F is a select input (2-bit)

      C_out : out std_logic;                     --C_out is an output
      Y : out std_logic                          --Y is an output
    );

 end component;
 signal A, B, C_in, En, C_out, Y : std_logic;
 signal F : std_logic_vector(1 downto 0);

 begin 

    uut: ALU port map(A => A, B => B, C_in => C_in, En => En, F => F, C_out => C_out, Y => Y);
    stimulate_process: process

    begin 

        A <= '0'; B <= '0'; C_in <= '0'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: En=0, A=0, B=0, Cin=0" severity error;

        A <= '0'; B <= '0'; C_in <= '1'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: En=0, A=0, B=0, Cin=1" severity error;

        A <= '0'; B <= '1'; C_in <= '0'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: En=0, A=0, B=1, Cin=0" severity error;

        A <= '0'; B <= '1'; C_in <= '1'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: En=0, A=0, B=1, Cin=1" severity error;

        A <= '1'; B <= '0'; C_in <= '0'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: En=0, A=1, B=0, Cin=0" severity error;
                                                                                                                  --Enable 0 means Y should always be 0 regardless. 
        A <= '1'; B <= '0'; C_in <= '1'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: En=0, A=1, B=0, Cin=1" severity error;

        A <= '1'; B <= '1'; C_in <= '0'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: En=0, A=1, B=1, Cin=0" severity error;

        A <= '1'; B <= '1'; C_in <= '1'; En <= '0'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: En=0, A=1, B=1, Cin=1" severity error;



        A <= '0'; B <= '0'; C_in <= '0'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '1' and C_out = '0') report "Err: NOR 000" severity error;

        A <= '0'; B <= '0'; C_in <= '1'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '1' and C_out = '0') report "Err: NOR 001" severity error;

        A <= '0'; B <= '1'; C_in <= '0'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: NOR 010" severity error;

        A <= '0'; B <= '1'; C_in <= '1'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: NOR 011" severity error;
                                                                                                                  --Y = A NOR B
        A <= '1'; B <= '0'; C_in <= '0'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '0') report "Err: NOR 100" severity error;

        A <= '1'; B <= '0'; C_in <= '1'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: NOR 101" severity error;

        A <= '1'; B <= '1'; C_in <= '0'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: NOR 110" severity error;

        A <= '1'; B <= '1'; C_in <= '1'; En <= '1'; F <= "00"; wait for 10 ns;
        assert (Y = '0' and C_out = '1') report "Err: NOR 111" severity error;
      
      wait;
   end process;
 end behavioural;

