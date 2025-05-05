
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_gate_operations is
end testbench_gate_operations;

architecture Behavioral of testbench_gate_operations is

    component main
        Port (
            Input_in : in STD_LOGIC_VECTOR(3 downto 0);
            Output_out : out STD_LOGIC_VECTOR(3 downto 0);
            OperatorA_button_in, OperatorB_button_in, Selector_button_in, Reset_button_in : in STD_LOGIC;
            Zero_flag_out, Negative_flag_out, Carry_flag_out, Overflow_flag_out : out STD_LOGIC
        );
    end component;


    signal Input_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Output_out : STD_LOGIC_VECTOR(3 downto 0);
    signal OperatorA_button, OperatorB_button, Selector_button, Reset_button : STD_LOGIC := '0';
    signal Zero_flag, Negative_flag, Carry_flag, Overflow_flag : STD_LOGIC;

begin

    uut: main
        port map (
            Input_in => Input_in,
            Output_out => Output_out,
            OperatorA_button_in => OperatorA_button,
            OperatorB_button_in => OperatorB_button,
            Selector_button_in => Selector_button,
            Reset_button_in => Reset_button,
            Zero_flag_out => Zero_flag,
            Negative_flag_out => Negative_flag,
            Carry_flag_out => Carry_flag,
            Overflow_flag_out => Overflow_flag
        );

        stim_proc: process
    begin
        -- AND operation
        Input_in <= "1000";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1010";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0001";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting AND operation: 1000 AND 1010 = 1000

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- OR operation
        Input_in <= "1000";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1010";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0011";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting OR operation: 1000 OR 1010 = 1010

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- NAND operation
        Input_in <= "0010";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1100";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0010";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting NAND operation: 0010 NAND 1100 = 1111

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- NOR operation
        Input_in <= "0100";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1100";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0100";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting NOR operation: 0100 NOR 1100 = 0011

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- XOR operation
        Input_in <= "0101";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1100";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0101";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting XOR operation: 0101 XOR 1100 = 1001

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- XNOR operation
        Input_in <= "0110";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1100";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0110";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting XNOR operation: 0110 XNOR 1100 = 0101

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;
        wait;
    end process;
end Behavioral;