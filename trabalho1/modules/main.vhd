
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity main is
    Port ( Input_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
           Output_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
           OperatorA_button_in, OperatorB_button_in, Selector_button_in : IN STD_LOGIC);
end main;

architecture Behavioral of main is

COMPONENT ula
        Port ( OperatorA_in, OperatorB_in, Selector_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
               Result_out : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0));
    end COMPONENT ula;

    signal input_operatorA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_operatorB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal input_selector : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal output_result : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');

begin

    ula_inst: ula
        port map (
            OperatorA_in => input_operatorA,
            OperatorB_in => input_operatorB,
            Selector_in => input_selector,
            Result_out => output_result
        );


process(Selector_button_in)
begin
    if rising_edge(Selector_button_in) then
        input_selector <= Input_in;
    end if;
end process;

process(OperatorA_button_in)
begin
    if rising_edge(OperatorA_button_in) then
        input_operatorA <= Input_in;
    end if;
end process;

process(OperatorB_button_in)
begin
    if rising_edge(OperatorB_button_in) then
        input_operatorB <= Input_in;
    end if;
end process;

Output_out <= output_result;

end Behavioral;