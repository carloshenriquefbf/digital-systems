library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ula is
    Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
           Zero_flag_out : OUT STD_LOGIC := '0';
           Negative_flag_out : OUT STD_LOGIC := '0';
           Carry_flag_out : OUT STD_LOGIC := '0';
           Overflow_flag_out : OUT STD_LOGIC := '0');
end ula;

architecture Behavioral of ula is
    signal temp_result : STD_LOGIC_VECTOR(4 DOWNTO 0); -- Extra bit for carry/overflow
begin

    process(Selector_in, OperatorA_in, OperatorB_in)
        variable temp_result : STD_LOGIC_VECTOR(4 DOWNTO 0);
        variable signed_A, signed_B : signed(4 DOWNTO 0);
    begin
        case Selector_in is
            when "0001" => Result_out <= OperatorA_in and Operatorb_in;
            when "0010" => Result_out <= OperatorA_in nand Operatorb_in;
            when "0011" => Result_out <= OperatorA_in or Operatorb_in;
            when "0100" => Result_out <= OperatorA_in nor Operatorb_in;
            when "0101" => Result_out <= OperatorA_in xor Operatorb_in;
            when "0110" => Result_out <= OperatorA_in xnor Operatorb_in;
            -- Addition
            when "0111" =>
                signed_A := '0' & signed(OperatorA_in);
                signed_B := '0' & signed(OperatorB_in);

                temp_result := std_logic_vector(signed_A + signed_B);
                Result_out <= temp_result(3 DOWNTO 0);
                Carry_flag_out <= temp_result(4);

                -- Overflow: when two negative numbers produce a positive result OR when two positive numbers produce a negative result
                Overflow_flag_out <= (signed_A(3) and signed_B(3) and not temp_result(3)) or
                 (not signed_A(3) and not signed_B(3) and temp_result(3));

                if temp_result(3 downto 0) = "0000" then
                    Zero_flag_out <= '1';
                else
                    Zero_flag_out <= '0';
                end if;

                Negative_flag_out <= temp_result(3);
            -- Subtraction
            when "1000" =>
                signed_A := '0' & signed(OperatorA_in);
                signed_B := '0' & signed(OperatorB_in);

                temp_result := std_logic_vector(signed_A - signed_B);
                Result_out <= temp_result(3 DOWNTO 0);
                Carry_flag_out <= temp_result(4);

                -- Overflow: when subtracting a negative number from a positive number produces a negative result OR when subtracting a positive number from a negative number produces a positive result
                Overflow_flag_out <= (not signed_A(3) and signed_B(3) and temp_result(3)) or
                                (signed_A(3) and not signed_B(3) and not temp_result(3));

                if temp_result(3 downto 0) = "0000" then
                    Zero_flag_out <= '1';
                else
                    Zero_flag_out <= '0';
                end if;
                Negative_flag_out <= temp_result(3);
            when others =>
                Result_out <= (others => '0');
                Zero_flag_out <= '0';
                Negative_flag_out <= '0';
                Carry_flag_out <= '0';
                Overflow_flag_out <= '0';
        end case;
    end process;

end Behavioral;