LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Generates decision flags based on the dice sum according to Craps rules
ENTITY test_logic IS
    PORT (
        sum : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Latched dice sum (2–12)
        d7 : OUT STD_LOGIC; -- 1 if sum = 7
        d711 : OUT STD_LOGIC; -- 1 if sum = 7 or 11
        d2312 : OUT STD_LOGIC -- 1 if sum = 2, 3, or 12
    );
END ENTITY test_logic;

ARCHITECTURE behavioral OF test_logic IS

    -- Integer representation of the dice sum for easy comparison
    SIGNAL sum_int : INTEGER RANGE 0 TO 15;

BEGIN
    -- Convert std_logic_vector input to integer for comparisons
    sum_int <= to_integer(unsigned(sum));

    -- Combinational decision logic
    d7 <= '1' WHEN sum_int = 7 ELSE
        '0';
    d711 <= '1' WHEN (sum_int = 7 OR sum_int = 11) ELSE
        '0';
    d2312 <= '1' WHEN (sum_int = 2 OR sum_int = 3 OR sum_int = 12) ELSE
        '0';
END ARCHITECTURE behavioral;