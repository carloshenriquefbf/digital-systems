
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_arithmetic_operations is
end testbench_arithmetic_operations;

architecture Behavioral of testbench_arithmetic_operations is

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
        -- Simple addition (1 + 2 = 3)
        Input_in <= "0001";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0010";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0111";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expecting SUM operation: 0001 + 0010 = 0011

        -- Reset the buttons
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Addition with negative numbers (-1 + -2 = -3)
        Input_in <= "1111";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "1110";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0111";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 1101 (-3), Negative flag 1

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Addition with overflow (7 + 1 = -8)
        Input_in <= "0111";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0001";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0111";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 1000 (-8), Negative and Overflow flags 1

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Simple subtraction (5 - 2 = 3)
        Input_in <= "0101";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0010";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "1000";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 0011 (3), all flags 0

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Subtraction with negative result (2 - 5 = -3)
        Input_in <= "0010";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0101";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "1000";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 1101 (-3), Negative flag 1 and Carry flag 1

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Subtraction with overflow (-8 - 1 = 7)
        Input_in <= "1000";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0001";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "1000";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 0111 (7), Overflow flag 1

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        -- Zero result (3 - 3 = 0)
        Input_in <= "0011"; -- 3
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0011"; -- 3
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "1000";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        -- Expected: 0000 (0), Zero flag 1

        -- Reset
        Reset_button <= '1'; wait for 100 ns; Reset_button <= '0'; wait for 100 ns;

        wait;
    end process;
end Behavioral;