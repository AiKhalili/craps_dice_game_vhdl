LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Compares the current dice sum with the stored point value
ENTITY comparator IS
    PORT (
        sum : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Current dice sum (2–12)
        point : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Stored point value
        Eq : OUT STD_LOGIC -- 1 if sum = point
    );
END comparator;

ARCHITECTURE Behavioral OF comparator IS
BEGIN
    -- Combinational comparsion: output '1' when sum equals point
    Eq <= '1' WHEN unsigned(sum) = unsigned(point) ELSE
        '0';
END Behavioral;