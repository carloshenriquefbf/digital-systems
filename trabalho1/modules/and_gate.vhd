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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity and_gate is
    Port ( a, b : in  STD_LOGIC_VECTOR(3 downto 0);
           saida : out  STD_LOGIC_VECTOR(3 downto 0));
end and_gate;

architecture Behavioral of and_gate is

begin

saida <= a AND b;

end Behavioral;

