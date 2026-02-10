LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Verifying the decision logic of the test_logic module
ENTITY tb_test_logic IS
END tb_test_logic;

ARCHITECTURE behavioral OF tb_test_logic IS

    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL d7 : STD_LOGIC;
    SIGNAL d711 : STD_LOGIC;
    SIGNAL d2312 : STD_LOGIC;

BEGIN

    test_logic_inst : ENTITY work.test_logic
        PORT MAP(
            sum => sum,
            d7 => d7,
            d711 => d711,
            d2312 => d2312
        );

    PROCESS
    BEGIN

        -- Test sum = 2 : D2312 should be 1, others 0
        sum <= "0010";
        WAIT FOR 10 ns;

        -- Test sum = 3 : D2312 should be 1, others 0
        sum <= "0011";
        WAIT FOR 10 ns;

        -- Test sum = 4 : All outputs should be 0
        sum <= "0100";
        WAIT FOR 10 ns;

        -- Test sum = 5 : All outputs should be 0
        sum <= "0101";
        WAIT FOR 10 ns;

        -- Test sum = 6 : All outputs should be 0
        sum <= "0110";
        WAIT FOR 10 ns;

        -- Test sum = 7 : D7 and D711 should be 1
        sum <= "0111";
        WAIT FOR 10 ns;

        -- Test sum = 8 : All outputs should be 0
        sum <= "1000";
        WAIT FOR 10 ns;

        -- Test sum = 9 : All outputs should be 0
        sum <= "1001";
        WAIT FOR 10 ns;

        -- Test sum = 10 : All outputs should be 0
        sum <= "1010";
        WAIT FOR 10 ns;

        -- Test sum = 11 : D711 should be 1, others 0
        sum <= "1011";
        WAIT FOR 10 ns;

        -- Test sum = 12 : D2312 should be 1, others 0
        sum <= "1100";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavioral;