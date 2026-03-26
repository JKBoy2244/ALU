library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_slice is

    port (

      A : in std_logic;                          --A is an input
      B : in std_logic;                          --B is an input
      C_in : in std_logic;                       --C_in is an input
      En : in std_logic;                         --En is an input
      F : in std_logic_vector(1 downto 0);       --F is a select input (2-bit)

      C_out : out std_logic;                     --C_out is an output
      Y : out std_logic                          --Y is an output
    );

end ALU_slice;

architecture behavioural of ALU_slice is 

   signal S1, S2, S3, S4, S5, B_extra : std_logic;

begin  

   B_extra <= B xor F(0);              --Logic equation for B_extra (signal)
   S1 <= A nor B;                      --Logic equation for S1 (signal)
   S2 <= A nand B;                     --Logic equation for S2 (signal)
   S3 <= A xor B_extra xor C_in;       --Logic equation for S3 (signal)
   S4 <= A xor B_extra xor C_in;       --Logic equation for S4 (signal)

   C_out <= (A and B_extra) or (C_in and (A xor B_extra));      --Logic equation for C_out


   with F select           --The F component selection occurs

      S5 <= S1 when "00",         --S5 equates to S1 if 00
            S2 when "01",         --S5 equates to S2 if 01
            S3 when "10",         --S5 equates to S3 if 10
            S4 when "11",         --S5 equates to S4 if 11
            '0' when others;      --other if not corresponding

   Y <= S5 and En;                --Final equation for Y combining all inputs plus signals together

end behavioural;
