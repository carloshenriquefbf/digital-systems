----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    14:52:17 04/08/2025
-- Design Name:
-- Module Name:    main - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( Input_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           Output_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
           OperatorA_button_in, OperatorB_button_in, Selector_button_in, clock : IN STD_LOGIC_VECTOR(3 DOWNTO 0);

end main;

architecture Behavioral of main is

COMPONENT ula
        Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
               Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
               --Zero, Negative, Carry_out, Overflow
               Flag_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
    end COMPONENT ula;

    signal input_operatorA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_operatorB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_selector : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal output_result : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal output_flag : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_clock : STD_LOGIC := '0';

COMPONENT debouncer
        Port ( clock : in  STD_LOGIC;
               input_switch : in  STD_LOGIC;
               output_switch : out  STD_LOGIC);
    end COMPONENT debouncer;

    signal debounced_operatorA : STD_LOGIC := '0';
    signal debounced_operatorB : STD_LOGIC := '0';
    signal debounced_selector : STD_LOGIC := '0';

begin

    ula_inst: ula
        port map (
            OperatorA_in => input_operatorA,
            OperatorB_in => input_operatorB,
            Selector_in => input_selector,
            Result_out => output_result,
            Flag_out => output_flag
        );

    debouncer_inst_operatorA: debouncer
        port map (
            clock => input_clock,
            input_switch => OperatorA_button_in,
            output_switch => debounced_operatorA
        );

    debouncer_inst_operatorB: debouncer
        port map (
            clock => input_clock,
            input_switch => OperatorB_button_in,
            output_switch => debounced_operatorB
        );

    debouncer_inst_selector: debouncer
        port map (
            clock => input_clock,
            input_switch => Selector_button_in,
            output_switch => debounced_selector
        );
--TODO: Inserir process e começar a implementação
end Behavioral;