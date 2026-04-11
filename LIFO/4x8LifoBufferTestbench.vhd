library IEEE;
use IEEE.std_logic_1164.all;

entity LIFO_testbench is
end LIFO_testbench;

architecture behavioural of LIFO_testbench is

    component LIFO is
        port (
            Enable    : in std_logic;
            Reset     : in std_logic;
            Push_Popn : in std_logic;
            D_IN      : in std_logic_vector(3 downto 0);
            D_OUT     : out std_logic_vector(3 downto 0);
            CLK       : in std_logic;
            Full      : out std_logic;
            Empty     : out std_logic
        );
    end component;

    -- Initialize signals to '0' to avoid 'U' (Uninitialized) states at startup
    signal Enable, Reset, Push_Popn, CLK, Full, Empty : std_logic := '0';
    signal D_IN : std_logic_vector(3 downto 0) := "0000";
    signal D_OUT : std_logic_vector(3 downto 0);

    -- Define clock period constant
    constant CLK_PERIOD : time := 10 ns;

begin

    uut: LIFO port map(
        Enable    => Enable, 
        Reset     => Reset, 
        Push_Popn => Push_Popn, 
        D_IN      => D_IN, 
        D_OUT     => D_OUT, 
        CLK       => CLK, 
        Full      => Full, 
        Empty     => Empty
    );

    -- Clock generation process: Toggles the clock every half period
    clk_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulate process to run test cases
    stimulate_process: process
    begin
        -- ==========================================
        -- Test Case 1: Initialization and Reset
        -- ==========================================
        Enable <= '0';
        Push_Popn <= '0';
        D_IN <= "0000";
        
        -- Assert Reset
        Reset <= '1';
        wait for CLK_PERIOD * 2;
        
        -- De-assert Reset (Buffer should now be Empty)
        Reset <= '0';
        wait for CLK_PERIOD;

        -- ==========================================
        -- Test Case 2: Push elements until FULL
        -- Assuming Push_Popn = '1' is PUSH
        -- ==========================================
        Enable <= '1';
        Push_Popn <= '1';

        -- Push 8 distinct values into the 8-deep Shift Register
        D_IN <= "0001"; wait for CLK_PERIOD;
        D_IN <= "0010"; wait for CLK_PERIOD;
        D_IN <= "0011"; wait for CLK_PERIOD;
        D_IN <= "0100"; wait for CLK_PERIOD;
        D_IN <= "0101"; wait for CLK_PERIOD;
        D_IN <= "0110"; wait for CLK_PERIOD;
        D_IN <= "0111"; wait for CLK_PERIOD;
        D_IN <= "1000"; wait for CLK_PERIOD; 
        
        -- Buffer should now assert the 'Full' flag. 
        -- Let's disable and wait to observe the waveform.
        Enable <= '0';
        wait for CLK_PERIOD * 2;

        -- ==========================================
        -- Test Case 3: Pop elements until EMPTY
        -- Assuming Push_Popn = '0' is POP
        -- ==========================================
        Enable <= '1';
        Push_Popn <= '0';

        -- Wait for 8 clock cycles to pop all 8 elements.
        -- In the waveform, you should see D_OUT show: 
        -- 1000, 0111, 0110, 0101, 0100, 0011, 0010, 0001 (Last-In, First-Out order)
        wait for CLK_PERIOD * 8;

        -- Buffer should now assert the 'Empty' flag again.
        Enable <= '0';
        wait for CLK_PERIOD * 2;

        -- ==========================================
        -- Test Case 4: Interleaved Push and Pop
        -- ==========================================
        Enable <= '1';
        
        -- Push 2 items
        Push_Popn <= '1';
        D_IN <= "1010"; wait for CLK_PERIOD;
        D_IN <= "1011"; wait for CLK_PERIOD;

        -- Pop 1 item (Should output "1011")
        Push_Popn <= '0';
        wait for CLK_PERIOD;

        -- Push 1 more item
        Push_Popn <= '1';
        D_IN <= "1100"; wait for CLK_PERIOD;

        -- Disable LIFO to end operations
        Enable <= '0';
        wait for CLK_PERIOD * 2;

        -- End the simulation cleanly
        assert false report "Simulation Finished Successfully" severity note;
        wait; -- The 'wait' with no time stops the process forever
    end process;

end behavioural;
