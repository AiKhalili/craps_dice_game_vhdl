LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Verifies controller FSM functionality for the Dice Craps game
ENTITY tb_controller IS
END tb_controller;

ARCHITECTURE behavior OF tb_controller IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL enter : STD_LOGIC := '0';

    SIGNAL Eq : STD_LOGIC := '0';
    SIGNAL D7 : STD_LOGIC := '0';
    SIGNAL D711 : STD_LOGIC := '0';
    SIGNAL D2312 : STD_LOGIC := '0';

    SIGNAL win : STD_LOGIC;
    SIGNAL lose : STD_LOGIC;
    SIGNAL Sp : STD_LOGIC;
    SIGNAL roll : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Clock generation (10 ns period)
    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    controller_inst : ENTITY work.controller
        PORT MAP(
            clk => clk,
            reset => reset,
            enter => enter,
            Eq => Eq,
            D7 => D7,
            D711 => D711,
            D2312 => D2312,
            win => win,
            lose => lose,
            Sp => Sp,
            roll => roll
        );

    PROCESS
    BEGIN

        -- Test 1: Reset FSM and start new game
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll: WIN (sum = 7 or 11)
        enter <= '1'; -- start rolling
        WAIT FOR 4 * clk_period;
        enter <= '0'; -- latch first sum

        D711 <= '1';
        WAIT FOR clk_period;
        D711 <= '0';

        WAIT FOR 2 * clk_period;

        -- Test 2: Reset and LOSE (sum = 2,3,12)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        D2312 <= '1';
        WAIT FOR clk_period;
        D2312 <= '0';

        WAIT FOR 2 * clk_period;

        -- Test 3: Point phase : WIN (sum equals stored point)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll (point is established)
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        -- Second roll
        WAIT FOR clk_period;
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        Eq <= '1'; -- sum == point : WIN
        WAIT FOR clk_period;
        Eq <= '0';

        WAIT FOR 2 * clk_period;

        -- Test 4: Point phase : LOSE (sum = 7)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll (point established)
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        -- Second roll
        WAIT FOR clk_period;
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        D7 <= '1'; -- sum = 7 : LOSE
        WAIT FOR clk_period;
        D7 <= '0';

        WAIT;

    END PROCESS;

END behavior;