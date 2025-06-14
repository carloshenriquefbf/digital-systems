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
        key_pressed  : in  std_logic;                     -- From keyboard FSM
        key_code     : in  std_logic_vector(7 downto 0);  -- PS/2 scan code
        display_word : out std_logic_vector(63 downto 0); -- 6 letters (8 bits each)
        errors       : out std_logic_vector(3 downto 0);  -- Error counter
        game_over    : out std_logic;                     -- 1 = game ended
        game_won     : out std_logic                      -- 1 = player won
    );
end hangman_game;

architecture Behavioral of hangman_game is
    constant ASTERISK : std_logic_vector(7 downto 0) := X"2A";

    type word_array is array (0 to WORD_LENGTH-1) of std_logic_vector(7 downto 0);

    constant TARGET_WORD : word_array := (
        X"46", X"45", X"52", X"4E", X"41", X"4E", X"44", X"41"  -- F E R N A N D A
    );

    signal current_word : word_array := (others => ASTERISK);
    signal error_count  : unsigned(3 downto 0) := (others => '0');
    signal guessed      : std_logic_vector(WORD_LENGTH-1 downto 0) := (others => '0');
    signal won          : std_logic := '0';
    signal lost         : std_logic := '0';

    function scan_to_ascii(scancode : std_logic_vector(7 downto 0))
        return std_logic_vector is
    begin
        case scancode is
            when X"1E" => return X"46";  -- F
            when X"1F" => return X"45";  -- E
            when X"20" => return X"52";  -- R
            when X"21" => return X"4E";  -- N
            when X"22" => return X"41";  -- A
            when X"23" => return X"4E";  -- N
            when X"24" => return X"44";  -- D
            when X"25" => return X"41";  -- A
            when others => return ASTERISK;  -- Default to *
        end case;
    end function;

begin
    process(clk, reset)
        variable letter_found : boolean;
    begin
        if reset = '1' then
            -- Reset game state
            current_word <= (others => ASTERISK);
            error_count <= (others => '0');
            guessed <= (others => '0');
            won <= '0';
            lost <= '0';
        elsif rising_edge(clk) and key_pressed = '1' and won = '0' and lost = '0' then
            letter_found := false;

            -- Check if pressed key matches any letter
            for i in 0 to WORD_LENGTH-1 loop
                if key_code = TARGET_WORD(i) and guessed(i) = '0' then
                    current_word(i) <= scan_to_ascii(key_code);
                    guessed(i) <= '1';
                    letter_found := true;
                end if;
            end loop;

            -- Handle wrong guess
            if not letter_found then
                error_count <= error_count + 1;
            end if;

            -- Check win/lose conditions
            if guessed = (guessed'range => '1') then
                won <= '1';
            elsif error_count >= MAX_ERRORS then
                lost <= '1';
            end if;
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