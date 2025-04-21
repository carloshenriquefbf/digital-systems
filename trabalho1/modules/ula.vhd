----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    14:52:17 04/08/2025
-- Design Name:
-- Module Name:    ula - Behavioral
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

entity ula is
    Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
           --Zero, Negative, Carry_out, Overflow
           Flag_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
end ula;

architecture Behavioral of ula is

    signal and_result   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal nand_result  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal or_result    : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal nor_result   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal xor_result   : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal xnor_result  : STD_LOGIC_VECTOR(3 DOWNTO 0);

-- COMPONENT not_gate
--     PORT (
--        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
--    );
--  END COMPONENT not_gate;

COMPONENT and_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT and_gate;

COMPONENT nand_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT nand_gate;

COMPONENT or_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT or_gate;

COMPONENT nor_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT nor_gate;

COMPONENT xor_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT xor_gate;

COMPONENT xnor_gate
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        saida : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END COMPONENT xnor_gate;

begin

    and_logic: and_gate PORT MAP (OperatorA_in, OperatorB_in, and_result);
    nand_logic: nand_gate PORT MAP (OperatorA_in, OperatorB_in, nand_result);
    or_logic: or_gate PORT MAP (OperatorA_in, OperatorB_in, or_result);
    nor_logic: nor_gate PORT MAP (OperatorA_in, OperatorB_in, nor_result);
    xor_logic: xor_gate PORT MAP (OperatorA_in, OperatorB_in, xor_result);
    xnor_logic: xnor_gate PORT MAP (OperatorA_in, OperatorB_in, xnor_result);

    process(Selector_in, and_result, nand_result, or_result, nor_result, xor_result, xnor_result)
    begin
        case Selector_in is
            when "0001" => Result_out <= and_result;
            when "0010" => Result_out <= nand_result;
            when "0011" => Result_out <= or_result;
            when "0100" => Result_out <= nor_result;
            when "0101" => Result_out <= xor_result;
            when "0110" => Result_out <= xnor_result;
            when others => Result_out <= (others => '0');
        end case;
    end process;

end Behavioral;