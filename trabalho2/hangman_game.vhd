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

    constant TARGET_WORD : word_array := (
        X"46", X"45", X"52", X"4E", X"41", X"4E", X"44", X"41"  -- F E R N A N D A
    );

    signal current_word : word_array := (others => ASTERISK);
    signal error_count  : unsigned(3 downto 0) := (others => '0');
    signal guessed      : std_logic_vector(WORD_LENGTH-1 downto 0) := (others => '0');
    signal won          : std_logic := '0';
    signal lost         : std_logic := '0';

    begin
        case scancode is
            when X"1C" => return X"41";  -- A
            when X"32" => return X"42";  -- B
            when X"21" => return X"43";  -- C
            when X"23" => return X"44";  -- D
            when X"24" => return X"45";  -- E
            when X"2B" => return X"46";  -- F
            when X"34" => return X"47";  -- G
            when X"33" => return X"48";  -- H
            when X"43" => return X"49";  -- I
            when X"3B" => return X"4A";  -- J
            when X"42" => return X"4B";  -- K
            when X"4B" => return X"4C";  -- L
            when X"3A" => return X"4D";  -- M
            when X"31" => return X"4E";  -- N
            when X"44" => return X"4F";  -- O
            when X"4D" => return X"50";  -- P
            when X"15" => return X"51";  -- Q
            when X"2D" => return X"52";  -- R
            when X"1B" => return X"53";  -- S
            when X"2C" => return X"54";  -- T
            when X"3C" => return X"55";  -- U
            when X"2A" => return X"56";  -- V
            when X"1D" => return X"57";  -- W
            when X"22" => return X"58";  -- X
            when X"35" => return X"59";  -- Y
            when X"1A" => return X"5A";  -- Z
            when others => return X"00";  -- Invalid
        end case;
    end function;

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
            elsif key_code = "00100100" then -- E
                current_word(1) <= X"45";
            elsif key_code = "00101011" then -- F
                current_word(0) <= X"46";
            elsif key_code = "00110001" then -- N
                current_word(3) <= X"4E";
                        current_word(5) <= X"4E";
            elsif key_code = "00101101" then -- R
                current_word(2) <= X"52";
            else
                error_count <= error_count + 1;
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