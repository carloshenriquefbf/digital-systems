library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula is
    Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
end ula;

architecture Behavioral of ula is

begin

    process(Selector_in, OperatorA_in, OperatorB_in)
    begin
        case Selector_in is
            when "0001" => Result_out <= OperatorA_in and Operatorb_in;
            when "0010" => Result_out <= OperatorA_in nand Operatorb_in;
            when "0011" => Result_out <= OperatorA_in or Operatorb_in;
            when "0100" => Result_out <= OperatorA_in nor Operatorb_in;
            when "0101" => Result_out <= OperatorA_in xor Operatorb_in;
            when "0110" => Result_out <= OperatorA_in xnor Operatorb_in;
            when others => Result_out <= (others => '0');
        end case;
    end process;

end Behavioral;