LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_sum_register IS
END tb_sum_register;

ARCHITECTURE behavior OF tb_sum_register IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL load : STD_LOGIC := '0';
    SIGNAL sum_in : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sum_out : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    inst : ENTITY work.sum_register
        PORT MAP(
            clk => clk,
            reset => reset,
            load => load,
            sum_in => sum_in,
            sum_out => sum_out
        );

    -- Clock generation
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period / 2;
        clk <= '1';
        WAIT FOR clk_period / 2;
    END PROCESS;

    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        -- Test reset
        reset <= '1';
        WAIT FOR 15 ns;
        reset <= '0';

        -- Load = 1 = should load input
        load <= '1';
        sum_in <= "0101"; -- 5
        WAIT FOR clk_period;

        sum_in <= "1010"; -- 10
        WAIT FOR clk_period;

        -- Load = 0 = should hold value
        load <= '0';
        sum_in <= "1111";
        WAIT FOR clk_period;

        -- Another load
        load <= '1';
        sum_in <= "0011"; -- 3
        WAIT FOR clk_period;

        -- Apply reset again
        reset <= '1';
        WAIT FOR clk_period;
        reset <= '0';

        WAIT;
    END PROCESS;

END behavior;