LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

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

    -- Clock generation
    clk_process : PROCESS
    BEGIN
        LOOP
            clk <= '0';
            WAIT FOR clk_period/2;
            clk <= '1';
            WAIT FOR clk_period/2;
        END LOOP;
    END PROCESS;

    -- Instantiate controller
    uut : ENTITY work.controller
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
            sum_ld => OPEN,
            point_phase => OPEN
        );

    -- Stimulus
    stim_proc : PROCESS
    BEGIN
        -- Reset FSM
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- Test 1: First roll WIN (D711 = 1)
        enter <= '1'; -- Press roll
        WAIT FOR 3 * clk_period;
        enter <= '0'; -- Release roll

        -- Simulate sum evaluation
        D711 <= '1';
        WAIT FOR 2 * clk_period;
        D711 <= '0';

        WAIT FOR 5 * clk_period; -- wait for FSM to go to S_WIN

        -- Test 2: First roll LOSE (D2312 = 1)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        enter <= '1';
        WAIT FOR 3 * clk_period;
        enter <= '0';

        D2312 <= '1';
        WAIT FOR 2 * clk_period;
        D2312 <= '0';

        WAIT FOR 5 * clk_period;

        -- Test 3: Point phase WIN (Eq = 1)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll (establish point)
        enter <= '1';
        WAIT FOR 3 * clk_period;
        enter <= '0';
        WAIT FOR 2 * clk_period;

        -- Second roll
        enter <= '1';
        WAIT FOR 3 * clk_period;
        enter <= '0';
        WAIT FOR 1 * clk_period;

        Eq <= '1';
        WAIT FOR 2 * clk_period;
        Eq <= '0';

        WAIT FOR 5 * clk_period;

        -- Test 4: Point phase LOSE (D7 = 1)
        reset <= '1';
        WAIT FOR 2 * clk_period;
        reset <= '0';
        WAIT FOR clk_period;

        -- First roll (establish point)
        enter <= '1';
        WAIT FOR 3 * clk_period;
        enter <= '0';
        WAIT FOR 2 * clk_period;

        -- Second roll
        enter <= '1';
        WAIT FOR 3 * clk_period;
        enter <= '0';
        WAIT FOR 1 * clk_period;

        D7 <= '1';
        WAIT FOR 2 * clk_period;
        D7 <= '0';

        WAIT;
    END PROCESS;

END behavior;