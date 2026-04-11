<img width="878" height="648" alt="image" src="https://github.com/user-attachments/assets/baaafc47-5634-40b7-89a5-306f9bc32f87" />

For coding/programming the 4x8 LIFO buffer in VHDL:

- 1). the thing I did is identify all the input and output ports within the system.

  Inputs: Push_Popn, Enable, Reset, CLK, D_IN(4-bit input so vector was used in the code)
  
  Outputs: D_OUT(4-bit output), Full, Empty

- 2). I defined Q as a signal because it acts as input and output simultaneously so output from counter4 block and input from the 4-input AND gate

   But the signal was split into 4-bits so hence std_logic_vector(3 downto 0) was used

- 3). I identified the main components in the system and only those 2 components individually and stated their respective input and output ports

      Those 2 components are ShiftReg8 and counter4

      ShiftReg8 inputs: reset, shift_holdn, left_rightn, CLK, I_R, I_L

      ShiftReg8 output: Q(0)

      counter4 inputs: up_downn, enable, reset, CLK

      counter4 output: Q(this is a 4-bit output though)

- 4). After doing that, I converted the specific components to their respective port maps according to the respective components inputs and outputs and the actual entity/systems inputs and outputs

      However, for ShiftReg8, it contains 4-bit inputs and 4-bit outputs so I had to do 4 port map blocks of each shiftReg8 and map them to their respective inputs/outputs for example, block 1 -> D(0), block 2 -> D(1) etc

      counter4, there's only 1 port map since its the only component there and all 1-bit inputs too

- 5). Finally, at the end, I wrote the 2 logic equations for Full and Empty respectively which are:

       Full <= Q3 and (not Q2) and (not Q1) and (not Q0)  and Empty <= (not Q3) and (not Q2) and (not Q1) and (not Q0)
