LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Common Anode display (0 = ON, 1 = OFF)
ENTITY seven_seg IS
    PORT (
        bin_input : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Dice value (valid range: 1-6)
        seg_output : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- 7-seg output (a...g)
    );
END seven_seg;

ARCHITECTURE Behavioral OF seven_seg IS
BEGIN
    WITH bin_input SELECT
        seg_output <= "1001111" WHEN "001", -- 1
        "0010010" WHEN "010", -- 2
        "0000110" WHEN "011", -- 3
        "1001100" WHEN "100", -- 4
        "0100100" WHEN "101", -- 5
        "0100000" WHEN "110", -- 6
        "1111111" WHEN OTHERS; -- Off for invalid inputs
END Behavioral;