LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Testbench for Dice Counter
-- Verifies reset, enable, pause, and resume behavior
ENTITY dice_counter_tb IS
END dice_counter_tb;

ARCHITECTURE Behavioral OF dice_counter_tb IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL roll_enable : STD_LOGIC := '0';
    SIGNAL dice_value : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

    inst : ENTITY work.dice_counter
        PORT MAP(
            clk => clk,
            reset => reset,
            roll_enable => roll_enable,
            dice_value => dice_value
        );

    -- Clock generation (10 ns period)
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR 5 ns;
        clk <= '1';
        WAIT FOR 5 ns;
    END PROCESS;

    -- Stimulus to test different operating modes
    stim_process : PROCESS
    BEGIN
        -- Initial reset
        WAIT UNTIL rising_edge(clk);
        reset <= '1';
        roll_enable <= '0';

        WAIT UNTIL rising_edge(clk);
        reset <= '0';

        -- Enable rolling (dice should change every clock)
        WAIT UNTIL rising_edge(clk);
        roll_enable <= '1';

        WAIT FOR 100 ns;

        -- Pause rolling (dice should freeze)
        WAIT UNTIL rising_edge(clk);
        roll_enable <= '0';

        WAIT FOR 40 ns;

        -- Resume rolling
        WAIT UNTIL rising_edge(clk);
        roll_enable <= '1';

        WAIT FOR 80 ns;

        -- Reset during rolling
        WAIT UNTIL rising_edge(clk);
        reset <= '1';

        WAIT UNTIL rising_edge(clk);
        reset <= '0';

        -- Final rolling to observe full sequence
        WAIT UNTIL rising_edge(clk);
        roll_enable <= '1';

        WAIT FOR 200 ns;

        -- Stop simulation
        roll_enable <= '0';
        WAIT;
    END PROCESS;

END Behavioral;