library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hangman_game is
    generic (
        WORD_LENGTH : integer := 8;
        MAX_ERRORS  : integer := 7
    );
    port (
        clk          : in  std_logic;
        reset        : in  std_logic;
        key_code     : in  std_logic_vector(7 downto 0);  -- PS/2 scan code
        display_word : out std_logic_vector(63 downto 0); -- 8 letters (8 bits each)
        errors       : out std_logic_vector(7 downto 0);  -- Error counter
        game_over    : out std_logic;                     -- 1 = game ended
        game_won     : out std_logic                      -- 1 = player won
    );
end hangman_game;

architecture Behavioral of hangman_game is
    constant ASTERISK : std_logic_vector(7 downto 0) := X"2A";

    type word_array is array (0 to WORD_LENGTH-1) of std_logic_vector(7 downto 0);

    signal current_word : word_array := (others => ASTERISK);
    signal error_count  : integer := 0;
	signal error_ascii  : std_logic_vector(7 downto 0);
    signal guessed_a    : std_logic := '0';
	signal guessed_f    : std_logic := '0';
    signal guessed_e    : std_logic := '0';
    signal guessed_n    : std_logic := '0';
    signal guessed_d    : std_logic := '0';
	signal guessed_r    : std_logic := '0';
    signal won          : std_logic := '0';
    signal lost         : std_logic := '0';

begin
    process(clk, reset)
    begin
        if reset = '1' then
			if guessed_a = '1' then
		        current_word(4) <= X"41";
				current_word(7) <= X"41";
			else
				current_word(4) <= ASTERISK;
				current_word(7) <= ASTERISK;
			end if;

			if guessed_e = '1' then
			    current_word(1) <= X"45";
			else
				current_word(1) <= ASTERISK;
			end if;

			if guessed_f = '1' then
			    current_word(0) <= X"46";
			else
				current_word(0) <= ASTERISK;
			end if;

            if guessed_n = '1' then
                current_word(3) <= X"4E";
                current_word(5) <= X"4E";
            else
                current_word(3) <= ASTERISK;
                current_word(5) <= ASTERISK;
            end if;

            if guessed_d = '1' then
                current_word(6) <= X"44";
            else
                current_word(6) <= ASTERISK;
            end if;

            if guessed_r = '1' then
                current_word(2) <= X"52";
                else
                current_word(2) <= ASTERISK;
            end if;

        elsif rising_edge(clk) then
            if key_code = "00011100" then    -- A
                guessed_a <= '1';
            elsif key_code = "00100100" then -- E
                guessed_e <= '1';
            elsif key_code = "00101011" then -- F
                guessed_f <= '1';
            elsif key_code = "00110001" then -- N
                guessed_n <= '1';
            elsif key_code = "00101101" then -- R
                guessed_r <= '1';
            elsif key_code = "00100011" then -- D
                guessed_d <= '1';
			end if;

        end if;

        if guessed_a = '1' and guessed_e = '1' and guessed_n = '1' and guessed_r = '1' and guessed_d = '1' and guessed_f = '1' then
            won <= '1';
        end if;

        if error_count >= MAX_ERRORS then
            lost <= '1';
        end if;

    end process;

    -- Output assignments
    display_word <= current_word(0) & current_word(1) & current_word(2) &
                    current_word(3) & current_word(4) & current_word(5) &
                    current_word(6) & current_word(7);
    errors <= error_ascii;
    game_over <= lost;
    game_won <= won;

end Behavioral;
