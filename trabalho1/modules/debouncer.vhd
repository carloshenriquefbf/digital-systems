----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    14:52:17 04/08/2025
-- Design Name:
-- Module Name:    ula2 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Port ( clock : in  STD_LOGIC;
           input_switch : in  STD_LOGIC;
           output_switch : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
    signal count : integer range 0 to 125000;
    signal switch_state : std_logic;
begin
    process(clock)
	 begin
        if rising_edge(clock) then
            if (input_switch /= switch_state and count < 125000) then
                count <= count + 1;
            elsif count = 125000 then
                switch_state <= input_switch;
            else
                count <= 0;
            end if;
        end if;
    end process;

    output_switch <= switch_state;

end Behavioral;

