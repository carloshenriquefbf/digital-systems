
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_main is
end tb_main;

architecture Behavioral of tb_main is

    component main
        Port (
            Input_in : in STD_LOGIC_VECTOR(3 downto 0);
            Output_out : out STD_LOGIC_VECTOR(3 downto 0);
            OperatorA_button_in, OperatorB_button_in, Selector_button_in : in STD_LOGIC
        );
    end component;


    signal Input_in : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal Output_out : STD_LOGIC_VECTOR(3 downto 0);
    signal OperatorA_button, OperatorB_button, Selector_button : STD_LOGIC := '0';

begin

    uut: main
        port map (
            Input_in => Input_in,
            Output_out => Output_out,
            OperatorA_button_in => OperatorA_button,
            OperatorB_button_in => OperatorB_button,
            Selector_button_in => Selector_button
        );

        stim_proc: process
    begin

        Input_in <= "1000";
        OperatorA_button <= '1'; wait for 100 ns; OperatorA_button <= '0'; wait for 100 ns;

        Input_in <= "0010";
        OperatorB_button <= '1'; wait for 100 ns; OperatorB_button <= '0'; wait for 100 ns;

        Input_in <= "0001";
        Selector_button <= '1'; wait for 100 ns; Selector_button <= '0'; wait for 200 ns;
        wait;
    end process;
end Behavioral;