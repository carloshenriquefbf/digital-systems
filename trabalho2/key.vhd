library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity key is
    port(
        data : in  std_logic;   -- scan data from keyboard
        pclk : in  std_logic;   -- clock input for keyboard
		key_press: out std_logic_vector(7 downto 0);
        l1   : out std_logic;   -- data display
        l2   : out std_logic;
        l3   : out std_logic;
        l4   : out std_logic;
        l5   : out std_logic;
        l6   : out std_logic;
        l7   : out std_logic;
        l8   : out std_logic
    );
end key;

architecture Behavioral of key is

    signal store    : std_logic_vector(10 downto 0) := (others => '0');
	 signal count_bit : integer := 0;

begin

key_press <= store( 8 downto 1);

l1 <= store(1);
l2 <= store(2);
l3 <= store(3);
l4 <= store(4);
l5 <= store(5);
l6 <= store(6);
l7 <= store(7);
l8 <= store(8);

-- Processo 2: Em cada borda de descida de pclk, captura um bit de `data`
process(pclk)

variable num_bit : integer := count_bit;

begin
	  if falling_edge(pclk) then

			store(num_bit) <= data;

			num_bit := num_bit + 1;

			if num_bit > 10 then
				num_bit := 0;
			end if;

			count_bit <= num_bit;

	  end if;
end process;

end Behavioral;