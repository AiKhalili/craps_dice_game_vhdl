LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Verifies equality comparison between dice sum and stored point
ENTITY comparator_tb IS
END comparator_tb;

ARCHITECTURE Behavioral OF comparator_tb IS
    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL point : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Eq : STD_LOGIC;

BEGIN
    comparator_inst : ENTITY work.comparator PORT MAP
        (sum => sum,
        point => point,
        Eq => Eq
        );

    PROCESS
    BEGIN
        -- Test 1: Equal values (7 = 7)
        sum <= "0111";
        point <= "0111";
        WAIT FOR 20 ns;

        -- Test 2: Different values (7 /= 5)
        sum <= "0111";
        point <= "0101";
        WAIT FOR 20 ns;

        -- Test 3: Equal values (11 = 11)
        sum <= "1011";
        point <= "1011";
        WAIT FOR 20 ns;

        -- Test 4: Different values (11 /= 7)
        sum <= "1011";
        point <= "0111";
        WAIT FOR 20 ns;

        -- Test 5: Equal values (5 = 5)
        sum <= "0101";
        point <= "0101";
        WAIT FOR 20 ns;

        -- Test 6: Different values (8 /= 9)
        sum <= "1000";
        point <= "1001";
        WAIT FOR 20 ns;

        -- Test 7: Minimum dice sum (2 = 2)
        sum <= "0010";
        point <= "0010";
        WAIT FOR 20 ns;

        -- Test 8: Maximum dice sum (12 = 12)
        sum <= "1100";
        point <= "1100";
        WAIT FOR 20 ns;

        -- Test 9: Different values (2 /= 12)
        sum <= "0010";
        point <= "1100";
        WAIT FOR 20 ns;

        -- Test 10: Equal values (6 = 6)
        sum <= "0110";
        point <= "0110";
        WAIT FOR 20 ns;

        -- Test 11: Different values (7 /= 6)
        sum <= "0111";
        point <= "0110";
        WAIT FOR 20 ns;

        -- Test 12: Different values (4 /= 10)
        sum <= "0100";
        point <= "1010";
        WAIT FOR 20 ns;

        WAIT;
    END PROCESS;

END Behavioral;