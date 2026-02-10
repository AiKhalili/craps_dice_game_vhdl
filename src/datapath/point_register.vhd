LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Stores the point value after the first dice roll in the game
ENTITY point_register IS
    PORT (
        clk : IN STD_LOGIC; -- System clock
        reset : IN STD_LOGIC; -- Active-high reset
        sp : IN STD_LOGIC; -- Store point enable (from controller)
        sum : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Latched dice sum (2–12)
        point : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Stored point value
    );
END point_register;

ARCHITECTURE behavioral OF point_register IS
    SIGNAL point_reg : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');

BEGIN
    -- Point register: captures the dice sum when sp is asserted
    PROCESS (clk, reset)
    BEGIN
        --reset: clears stored point to 0
        IF reset = '1' THEN
            point_reg <= (OTHERS => '0');

            -- Rising edge of clock: store sum if sp is high
        ELSIF rising_edge(clk) THEN
            IF sp = '1' THEN
                point_reg <= sum; -- Latch the input sum into register
            END IF;

        END IF;
    END PROCESS;

    -- Drive output with registered point value
    point <= point_reg;

END behavioral;