<img width="658" height="459" alt="image" src="https://github.com/user-attachments/assets/cd2da8e0-8b96-435a-a1ce-f1103ae6f413" />     ==> Diagram

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

<img width="773" height="499" alt="image" src="https://github.com/user-attachments/assets/ea47afe3-dc6b-43e1-8315-4f036173b4ae" />     ==> Testbench

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


This is the ALU component of the CPU which is essentially one of the most important components within a CPU. Inside the CPU, the ALU executes arithmetic and logical operations on binary data. Arithmetic operations include addition and subtraction. It's basically a calculation engine that processes the data being fetched from the memory to perform the instructions and bit shifting too. Without the ALU, the CPU can't process the data which would make the software impossible to run as its main role is to perform operation on binary data. 

For the full ALU diagram, the entity section declares the entire ALU component's input and output ports only (not signals). For instance, the input ports are A, B, C_in, En(which stands for enable) and F(the selection input 2-bits too). The output ports are just C_out and Y. 

However, getting from the main inputs (A and B) to the main output (Y) in terms of the process is really long so hence, the signals are being introduced as a reference indicator. So I named the 6 signals: S1, S2, S3, S4, S5 and B_extra. The architecture section of the entire ALU tells you the behavioural implementations of the entire ALU including each specific component and what actions they perform too. Inside the ALU component, there's also a smaller component within the ALU which is the full adder so this is where the port map is useful since it's used to perform the operation of the full adder within the ALU's implementation. I specified the specific components of the FA there within the architectural implementation (Note: S3 and S4 are 2 signals but they're both implementing the same function pretty much). The component is only for a general full adder only (nothing external included) so inputs are A, B and C_in and outputs are C_out and S. Hence, from there, the port map gets implemented and since the full adder is only there for both S3 and S4, it makes sense to write S => S3 inside the port map while writing as well A => A, B => B, etc. After writing the port map, outside that block, I wrote S4 <= S3, indicating that both are the same parts as they implement the same function essentially. 

The first part of the implementation is just writing the logic equations of the 6 signals first. So, for instance:

  - B_extra = B xor F(0); S1 <= A nor B; S2 <= A nand B; (for S3, S4, C_out, the equations weren't written as they're all inside the port map which takes care of the implementations).

  - However, in the ALUcode.vhd, S3 <= A xor B_extra xor C_in; S4 <= A xor B_extra xor C_in; C_out <= (A and B_extra) or (C_in and (A xor B_extra));

The second part of the implementation is the implementation of the multiplexer which basically treats S5 as a signal output and S1 to S4 as signal inputs, so here this time, it's mainly on the signals that are being used:

  - There are 4 signal inputs so hence there should be 4 possible binary outputs only using the fact that the square root of 4 is 2 so using 2-digit binary values: "00", "01", "10", "11".
   When "00", S5 <= S1;   "01", S5 <= S2;   "10", S5 <= S3;   "11", S5 <= S4;

The third part of the implementation is the final AND gate on the right side where almost most of the operations are done/complete and there's one final thing to do and that's the Y output only turns on if both S5 turns on and Enable (En on the diagram) also turns on too. Hence, this deduces that Y <= S5 and En.


