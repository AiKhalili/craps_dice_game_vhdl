LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Dice Counter using 3-bit LFSR
-- Generates pseudo-random dice values (1 to 6)
ENTITY dice_counter IS
    GENERIC (
        SEED : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101" -- Initial seed for LFSR
    );
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        roll_enable : IN STD_LOGIC;
        dice_value : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END dice_counter;

ARCHITECTURE Behavioral OF dice_counter IS

    SIGNAL lfsr : STD_LOGIC_VECTOR(2 DOWNTO 0) := SEED;
    SIGNAL feedback : STD_LOGIC;

BEGIN

    feedback <= lfsr(2) XOR lfsr(0); -- XOR feedback for LFSR

    -- LFSR state update (synchronous, with async reset)
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            lfsr <= SEED;
        ELSIF rising_edge(clk) THEN
            IF roll_enable = '1' THEN
                lfsr <= lfsr(1 DOWNTO 0) & feedback;
            END IF;
        END IF;
    END PROCESS;

    -- Map LFSR states to valid dice values (1 to 6)
    PROCESS (lfsr)
    BEGIN
        CASE lfsr IS
            WHEN "000" => dice_value <= "001";
            WHEN "001" => dice_value <= "010";
            WHEN "010" => dice_value <= "011";
            WHEN "011" => dice_value <= "100";
            WHEN "100" => dice_value <= "101";
            WHEN "101" => dice_value <= "110";
            WHEN OTHERS => dice_value <= "001";
        END CASE;
    END PROCESS;

END Behavioral;