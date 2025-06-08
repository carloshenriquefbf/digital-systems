library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port (
        clk      : in  std_logic;          -- Main clock (e.g., 50MHz)
        reset    : in  std_logic;          -- Active-high reset
        ps2d     : in  std_logic;          -- PS/2 data line
        ps2c     : in  std_logic;          -- PS/2 clock line
        -- LCD outputs
        lcd_db   : out std_logic_vector(7 downto 0);
        lcd_rs   : out std_logic;
        lcd_rw   : out std_logic;
        lcd_oe   : out std_logic
    );
end main;

architecture Behavioral of main is
    -- Clock division signals
    signal clk_count    : std_logic_vector(5 downto 0) := (others => '0');
    signal one_us_clk   : std_logic;  -- 1MHz clock for timing

    -- Keyboard interface signals
    signal key_pressed  : std_logic;
    signal key_code     : std_logic_vector(7 downto 0);
    signal kb_buf_empty : std_logic;

    -- Game interface signals
    signal display_word : std_logic_vector(47 downto 0);  -- 6 ASCII characters
    signal errors       : std_logic_vector(3 downto 0);
    signal game_over    : std_logic;
    signal game_won     : std_logic;

    -- LCD control signals
    signal lcd_ext_cmds   : std_logic_vector(9 downto 0);
    signal lcd_cmd_select : std_logic_vector(3 downto 0) := (others => '0');
    signal lcd_cmd_ptr    : unsigned(3 downto 0) := (others => '0');

    -- LCD command buffer
    type lcd_cmds_t is array(0 to 13) of std_logic_vector(9 downto 0);
    signal lcd_cmds : lcd_cmds_t := (
        0 => "00"&X"3C",  -- Function Set
        1 => "00"&X"0C",  -- Display ON
        2 => "00"&X"01",  -- Clear Display
        3 => "00"&X"02",  -- Return Home
        -- Positions 4-9 will hold the word display
        4 => "10"&X"2A",  -- * (initially)
        5 => "10"&X"2A",
        6 => "10"&X"2A",
        7 => "10"&X"2A",
        8 => "10"&X"2A",
        9 => "10"&X"2A",
        -- Error counter display
        10 => "10"&X"45", -- 'E'
        11 => "10"&X"3A", -- ':'
        12 => "10"&X"30", -- '0' (initial errors)
        13 => "00"&X"80"  -- Move cursor to start
    );

begin
    -- Clock divider process
    process(clk)
    begin
        if rising_edge(clk) then
            clk_count <= std_logic_vector(unsigned(clk_count) + 1);
        end if;
    end process;
    one_us_clk <= clk_count(5);

    -- Keyboard decoder
    kb_decoder: entity work.kb_code
    port map (
        clk         => clk,
        reset       => reset,
        ps2d        => ps2d,
        ps2c        => ps2c,
        rd_key_code => key_pressed,
        key_code    => key_code,
        kb_buf_empty => kb_buf_empty
    );

    -- Hangman Game Core
    game_engine: entity work.hangman_game
    generic map (
        WORD_LENGTH => 6,
        MAX_ERRORS  => 7
    )
    port map (
        clk          => one_us_clk,
        reset        => reset,
        key_pressed  => key_pressed,
        key_code     => key_code,
        display_word => display_word,
        errors       => errors,
        game_over    => game_over,
        game_won     => game_won
    );

    -- LCD Controller
    lcd_controller: entity work.modified_lcd
    port map (
        CLK         => clk,
        rst         => reset,
        LCD_DB      => lcd_db,
        RS          => lcd_rs,
        RW          => lcd_rw,
        OE          => lcd_oe,
        ext_cmds    => lcd_ext_cmds,
        cmd_select  => lcd_cmd_select
    );

    -- LCD Command Update Process
    process(one_us_clk, reset)
    begin
        if reset = '1' then
            lcd_cmd_ptr <= (others => '0');
            lcd_cmd_select <= (others => '0');
            lcd_ext_cmds <= (others => '0');
        elsif rising_edge(one_us_clk) then
            -- Update word display (positions 4-9)
            lcd_cmds(4) <= "10" & display_word(47 downto 40); -- 1st letter
            lcd_cmds(5) <= "10" & display_word(39 downto 32); -- 2nd letter
            lcd_cmds(6) <= "10" & display_word(31 downto 24); -- 3rd letter
            lcd_cmds(7) <= "10" & display_word(23 downto 16); -- 4th letter
            lcd_cmds(8) <= "10" & display_word(15 downto 8);  -- 5th letter
            lcd_cmds(9) <= "10" & display_word(7 downto 0);   -- 6th letter

            -- Update error count (position 12)
            lcd_cmds(12) <= "10" & X"3" & errors;

            -- Game over handling
            if game_over = '1' then
                if game_won = '1' then
                    lcd_cmds(10) <= "10"&X"57"; -- 'W'
                    lcd_cmds(11) <= "10"&X"49"; -- 'I'
                    lcd_cmds(12) <= "10"&X"4E"; -- 'N'
                else
                    lcd_cmds(10) <= "10"&X"4C"; -- 'L'
                    lcd_cmds(11) <= "10"&X"4F"; -- 'O'
                    lcd_cmds(12) <= "10"&X"53"; -- 'S'
                    lcd_cmds(13) <= "10"&X"45"; -- 'E'
                end if;
            end if;

            -- Cycle through commands to update LCD
            if lcd_cmd_ptr < 13 then
                lcd_cmd_ptr <= lcd_cmd_ptr + 1;
            else
                lcd_cmd_ptr <= (others => '0');
            end if;

            -- Send current command to LCD controller
            lcd_cmd_select <= std_logic_vector(lcd_cmd_ptr);
            lcd_ext_cmds <= lcd_cmds(to_integer(lcd_cmd_ptr));
        end if;
    end process;

end Behavioral;