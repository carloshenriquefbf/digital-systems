library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
    Port (
        clk      : in  std_logic;          -- Main clock (e.g., 50MHz)
        rst      : in  std_logic;          -- Active-high reset
        data     : in  std_logic;          -- PS/2 data line
        pclk     : in  std_logic;          -- PS/2 clock line
        -- LCD outputs
        LCD_DB   : out std_logic_vector(7 downto 0);
        RS       : out std_logic;
        RW       : out std_logic;
        OE       : out std_logic;
        -- led
        l1		: out std_logic;
        l2		: out std_logic;
        l3		: out std_logic;
        l4		: out std_logic;
        l5		: out std_logic;
        l6		: out std_logic;
        l7		: out std_logic;
        l8		: out std_logic
    );
end main;

architecture Behavioral of main is
    -- Keyboard interface signals
    signal key_press     : std_logic_vector(7 downto 0);

    -- Game interface signals
    signal display_word : std_logic_vector(63 downto 0);  -- 8 ASCII characters
    signal game_won     : std_logic := '0';

    -- LCD control signals
    signal lcd_ext_cmds   : std_logic_vector(9 downto 0);
    signal lcd_cmd_select : std_logic_vector(3 downto 0) := (others => '0');
    signal lcd_cmd_ptr    : unsigned(3 downto 0) := (others => '0');

    -- LCD command buffer
    type lcd_cmds_t is array(0 to 15) of std_logic_vector(9 downto 0);
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
        10 => "10"&X"2A",
        11 => "10"&X"2A",
        -- Game status display
        12 => "10"&X"2D",
        13 => "10"&X"2D",
        14 => "10"&X"2D",
        15 => "00"&X"80"  -- Move cursor to start
    );

begin
    -- Keyboard decoder
    kb_decoder: entity work.key
    port map (
        data        => data,
        pclk        => pclk,
        key_press    => key_press,
        l1 => l1,
        l2 => l2,
        l3 => l3,
        l4 => l4,
        l5 => l5,
        l6 => l6,
        l7 => l7,
        l8 => l8
    );

    game_engine: entity work.hangman_game
    generic map (
        WORD_LENGTH => 8
    )
    port map (
        clk          => clk,
        reset        => rst,
        key_code     => key_press,
        display_word => display_word,
        game_won    => game_won
    );

    -- LCD Controller
    lcd_controller: entity work.modified_lcd
    port map (
        CLK         => clk,
        rst         => rst,
        LCD_DB      => LCD_DB,
        RS          => RS,
        RW          => RW,
        OE          => OE,
        ext_cmds    => lcd_ext_cmds,
        cmd_select  => lcd_cmd_select
    );

    -- LCD Command Update Process
    process(clk, rst)
    begin
        if rst = '1' then
            lcd_cmd_ptr <= (others => '0');
            lcd_cmd_select <= (others => '0');
            lcd_ext_cmds <= (others => '0');
        elsif rising_edge(clk) then
            -- Update word display (positions 4-11)
            lcd_cmds(4) <= "10" & display_word(63 downto 56); -- 1st letter
            lcd_cmds(5) <= "10" & display_word(55 downto 48); -- 2nd letter
            lcd_cmds(6) <= "10" & display_word(47 downto 40); -- 3rd letter
            lcd_cmds(7) <= "10" & display_word(39 downto 32); -- 4th letter
            lcd_cmds(8) <= "10" & display_word(31 downto 24); -- 5th letter
            lcd_cmds(9) <= "10" & display_word(23 downto 16); -- 6th letter
            lcd_cmds(10) <= "10" & display_word(15 downto 8); -- 7th letter
            lcd_cmds(11) <= "10" & display_word(7 downto 0);  -- 8th letter

            -- Update game status
			if game_won = '1' then
                lcd_cmds(13) <= "10" & X"57"; -- W
			end if;

            -- Cycle through commands to update LCD
            if lcd_cmd_ptr < 15 then
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
