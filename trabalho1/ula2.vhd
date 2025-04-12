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

entity ula2 is
    Port ( Operator1, Operator2, Selector : in  BIT;
           Output : out  BIT;
           Zero, Negative, Carry_out, Overflow : out  BIT);
end ula2;

architecture Behavioral of ula2 is

begin

output <= operator1;

end Behavioral;

