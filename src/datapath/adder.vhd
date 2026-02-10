LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Adds the values of two dice (1–6) and produces their sum (2–12)
ENTITY adder IS
    PORT (
        dice1 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- First dice value
        dice2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- Second dice value
        sum : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- Resulting dice sum
    );
END adder;

ARCHITECTURE Behavioral OF adder IS
BEGIN
    -- Convert dice inputs to unsigned, resize to 4 bits,
    -- then perform combinational addition
    sum <= STD_LOGIC_VECTOR(
        resize(unsigned(dice1), 4) +
        resize(unsigned(dice2), 4)
        );
END Behavioral;