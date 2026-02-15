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
    SIGNAL sum_ld : STD_LOGIC;
    SIGNAL point_phase : STD_LOGIC;

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    -- Clock generation
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
            roll => roll,
            sum_ld => sum_ld,
            point_phase => point_phase
        );

    PROCESS
    BEGIN

        -- TEST 1 : Immediate WIN (7 or 11)
        reset <= '1';
        WAIT FOR 3 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        -- Wait until reaching S_EVAL_FIRST state
        WAIT FOR 2 * clk_period;

        D711 <= '1';
        WAIT FOR 2 * clk_period; -- Hold signal long enough
        D711 <= '0';

        WAIT FOR 3 * clk_period;
        -- TEST 2 : Immediate LOSE (2,3,12)
        reset <= '1';
        WAIT FOR 3 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        WAIT FOR 2 * clk_period;

        D2312 <= '1';
        WAIT FOR 2 * clk_period;
        D2312 <= '0';

        WAIT FOR 3 * clk_period;
        -- TEST 3 : Point Phase WIN
        reset <= '1';
        WAIT FOR 3 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll (establish point)
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        WAIT FOR 3 * clk_period; -- Transition from EVAL_FIRST to POINT_WAIT

        -- Second roll
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        WAIT FOR 2 * clk_period;

        Eq <= '1';
        WAIT FOR 2 * clk_period;
        Eq <= '0';

        WAIT FOR 3 * clk_period;
        -- TEST 4 : Point Phase LOSE (7)
        reset <= '1';
        WAIT FOR 3 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        WAIT FOR 3 * clk_period;

        -- Second roll
        enter <= '1';
        WAIT FOR 4 * clk_period;
        enter <= '0';

        WAIT FOR 2 * clk_period;

        D7 <= '1';
        WAIT FOR 2 * clk_period;
        D7 <= '0';

        WAIT;

    END PROCESS;

END behavior;