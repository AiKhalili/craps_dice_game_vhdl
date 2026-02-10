LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_dice_game IS
END tb_dice_game;

ARCHITECTURE behavior OF tb_dice_game IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL roll_btn : STD_LOGIC := '0';

    SIGNAL seg1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL seg2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL win : STD_LOGIC;
    SIGNAL lose : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    inst : ENTITY work.dice_game
        PORT MAP(
            clk => clk,
            reset => reset,
            roll_btn => roll_btn,
            seg1 => seg1,
            seg2 => seg2,
            win => win,
            lose => lose
        );

    -- Clock generation
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        -- RESET SYSTEM
        reset <= '1';
        WAIT FOR 30 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- FIRST ROLL (Try WIN: 7 or 11)
        roll_btn <= '1'; -- Hold roll
        WAIT FOR 80 ns; -- Dice are rolling
        roll_btn <= '0'; -- Release roll = evaluate
        WAIT FOR 60 ns;

        -- If not win/lose, POINT should be stored here
        -- SECOND ROLL (Try Eq or 7)
        roll_btn <= '1';
        WAIT FOR 70 ns;
        roll_btn <= '0';
        WAIT FOR 60 ns;

        -- THIRD ROLL (Force remaining condition)
        roll_btn <= '1';
        WAIT FOR 90 ns;
        roll_btn <= '0';
        WAIT FOR 80 ns;

        -- RESET AGAIN (New game)
        reset <= '1';
        WAIT FOR 30 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- FIRST ROLL (Try LOSE: 2,3,12)
        roll_btn <= '1';
        WAIT FOR 60 ns;
        roll_btn <= '0';
        WAIT FOR 60 ns;

        WAIT;
    END PROCESS;

END behavior;