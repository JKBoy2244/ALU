library IEEE;
use IEEE.std_logic_1164.all;

entity LIFO is 

  port (

    Enable : in std_logic;
    Reset : in std_logic;
    Push_Popn : in std_logic;
    D_IN : in std_logic_vector(3 downto 0);
    D_OUT : out std_logic_vector(3 downto 0);    --All the inputs and outputs of the entire 4x8 LIFO buffer diagram
    CLK : in std_logic;
    Full : out std_logic;
    Empty : out std_logic
    
  )

end LIFO;

architecture behavioural of LIFO is 

  component ShiftReg8 is 
  
     port  (

       reset : in std_logic;
       shift_holdn : in std_logic;          --The entire 4x8 LIFO buffer diagram is split into 2 main components and ShiftReg8 component is one of them.
       left_rightn : in std_logic;          --For that specific component (ShiftReg8), this component displays all the inputs and outputs of that specific component only.
       CLK : in std_logic;
       I_R : in std_logic;
       I_L : in std_logic;
       Q_0 : out std_logic
    
   )

  end component;
  
  component counter4 is

    port (
     
       up_downn : in std_logic;
       enable : in std_logic;                       --The entire 4x8 LIFO buffer diagram is split into 2 main components and ShiftReg8 component is one of them.
       reset : in std_logic;                        --For that specific component (counter4), this component displays all the inputs and outputs of that specific component only.
       CLK : in std_logic; 
       Q : out std_logic_vector(3 downto 0)
   
 ) 

 end component;
 
 signal Q : std_logic_vector(3 downto 0);            --Here, Q is treated as a signal as in the entire LIFO diagram, it acts as both input and output simultaneously.
  
 begin

   counter4_block1 : counter4 port map (

      up_downn => Push_Popn,
      enable => Enable,                              --There's only 1 counter used/being present in the entire diagram and hence, only block 1 is being used for this.
      reset => Reset,                                --Port map transcribes the specific component inputs and outputs to the entity inputs and outputs respectively (entity - the whole entire 4x8 LIFO buffer diagram)
      CLK => CLK,
      Q => Q
     
   );

  shiftRegister8_block1 : ShiftReg8 port map  (

     reset => Reset,
     shift_holdn => Enable,
     left_rightn => Push_Popn,                              --From D_OUT(0) to D_OUT(3) and also D_IN(0) to D_IN(3) at the same time, there's 4 bit inputs and 4 bit outputs
     CLK => CLK,                                            --Hence, in that case, 4 port maps are being created for ShiftReg8 leading to 4 blocks of Shift Reg 8 being created
     I_R => D_IN(0),                                        --This is port map 1, block 1 where for each port map, where it transcribes the specific component inputs and outputs to the entity inputs and outputs respectively 
     I_L => '0',                                            --For example, port map block 1 contains only D_OUT(0) and D_IN(0), port map block 2 contains only D_OUT(1) and D_IN(1), port map block 3 contains only D_OUT(2) and D_IN(2), etc and so on.
     Q_0 => D_OUT(0)
    
  );

  shiftRegister8_block2 : ShiftReg8 port map  (

     reset => Reset,
     shift_holdn => Enable,
     left_rightn => Push_Popn,
     CLK => CLK,
     I_R => D_IN(1),
     I_L => '0',
     Q_0 => D_OUT(1)
    
  );

 shiftRegister8_block3 : ShiftReg8 port map  (

     reset => Reset,
     shift_holdn => Enable,
     left_rightn => Push_Popn,
     CLK => CLK,
     I_R => D_IN(2),
     I_L => '0',
     Q_0 => D_OUT(2)
    
  );

 shiftRegister8_block4 : ShiftReg8 port map  (

     reset => Reset,
     shift_holdn => Enable,
     left_rightn => Push_Popn,
     CLK => CLK,
     I_R => D_IN(3),
     I_L => '0',
     Q_0 => D_OUT(3)
    
  );

  Full <= Q(3) and (not Q(2)) and (not Q(1)) and (not Q(0));                     --Logic equation for the Full Output
  Empty <= (not Q(3)) and (not Q(2)) and (not Q(1)) and (not Q(0));              --Logic equation for the Empty Output

end behavioural;
