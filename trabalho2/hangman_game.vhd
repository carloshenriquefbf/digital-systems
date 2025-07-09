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
        errors       : out std_logic_vector(3 downto 0);  -- Error counter
        game_over    : out std_logic;                     -- 1 = game ended
        game_won     : out std_logic                      -- 1 = player won
    );
end hangman_game;

architecture Behavioral of hangman_game is
    constant ASTERISK : std_logic_vector(7 downto 0) := X"2A";

    type word_array is array (0 to WORD_LENGTH-1) of std_logic_vector(7 downto 0);

    signal current_word : word_array := (others => ASTERISK);
    signal error_count  : unsigned(3 downto 0) := (others => '0');
    signal guessed      : std_logic_vector(WORD_LENGTH-1 downto 0) := (others => '0');
    signal won          : std_logic := '0';
    signal lost         : std_logic := '0';

begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset game state
            current_word <= (others => ASTERISK);
            error_count <= (others => '0');
            guessed <= (others => '0');
            won <= '0';
            lost <= '0';
        elsif rising_edge(clk) then
            if key_code = "00011100" then -- A
                current_word(4) <= X"41";
				current_word(7) <= X"41";
                guessed(4) <= '1';
                guessed(7) <= '1';
            elsif key_code = "00100100" then -- E
                current_word(1) <= X"45";
                guessed(1) <= '1';
            elsif key_code = "00101011" then -- F
                current_word(0) <= X"46";
                guessed(0) <= '1';
            elsif key_code = "00110001" then -- N
                current_word(3) <= X"4E";
                current_word(5) <= X"4E";
                guessed(3) <= '1';
                guessed(5) <= '1';
            elsif key_code = "00101101" then -- R
                current_word(2) <= X"52";
                guessed(2) <= '1';
            elsif key_code /= "00000000" then
                error_count <= error_count + 1;
            end if;
        end if;

        if guessed = "11111111" then
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
    errors <= std_logic_vector(error_count);
    game_over <= won or lost;
    game_won <= won;

end Behavioral;