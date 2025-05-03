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
           OperatorA_button_in, OperatorB_button_in, Selector_button_in : IN STD_LOGIC);
end main;

architecture Behavioral of main is

COMPONENT ula
        Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
               Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
               --Zero, Negative, Carry_out, Overflow
               --Flag_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
    end COMPONENT ula;

    signal input_operatorA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_operatorB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_selector : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal output_result : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    --signal output_flag : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');

begin

    ula_inst: ula
        port map (
            OperatorA_in => input_operatorA,
            OperatorB_in => input_operatorB,
            Selector_in => input_selector,
            Result_out => output_result
            --Flag_out => output_flag
        );

process(OperatorA_button_in, OperatorB_button_in, Selector_button_in )

begin
if rising_edge(Selector_button_in) then
		input_selector <= Input_in;
end if;
if rising_edge(OperatorA_button_in) then
		input_operatorA <= Input_in;
end if;
if rising_edge(OperatorB_button_in) then
		input_operatorB <= Input_in;
end if;


Output_out <= output_result;

end process;

end Behavioral;