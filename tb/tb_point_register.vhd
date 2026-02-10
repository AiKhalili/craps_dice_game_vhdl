LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Verifies correct storage and reset behavior of the point register
ENTITY tb_point_register IS
END tb_point_register;

ARCHITECTURE behavioral OF tb_point_register IS

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '0';
    SIGNAL sp : STD_LOGIC := '0';
    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL point : STD_LOGIC_VECTOR(3 DOWNTO 0);

    CONSTANT clk_period : TIME := 10 ns;

BEGIN

    point_register_inst : ENTITY work.point_register
        PORT MAP(
            clk => clk,
            reset => reset,
            sp => sp,
            sum => sum,
            point => point
        );

    -- Clock generation process
    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR clk_period/2;
            clk <= '1';
            WAIT FOR clk_period/2;
        END LOOP;
    END PROCESS;

    PROCESS
    BEGIN
        -- Test 1: Reset clears the point register
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 10 ns;

        -- Test 2: Store initial point value (5)
        sum <= "0101";
        sp <= '1';
        WAIT UNTIL rising_edge(clk);
        WAIT FOR 5 ns;
        sp <= '0';
        WAIT FOR 20 ns;

        -- Test 3: Change sum without store enable (point should remain unchanged)
        sum <= "1001";
        WAIT FOR 40 ns;

        -- Test 4: Store a new point value (9)
        sp <= '1';
        WAIT UNTIL rising_edge(clk);
        WAIT FOR 5 ns;
        sp <= '0';
        WAIT FOR 20 ns;

        -- Test 5: Reset clears the stored point again
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS

END behavioral;