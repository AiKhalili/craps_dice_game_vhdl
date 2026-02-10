LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY sum_register IS
    PORT (
        clk : IN STD_LOGIC; --Clock signal
        reset : IN STD_LOGIC; --Asynchronous reset
        load : IN STD_LOGIC; --Load enable
        sum_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); --Input data
        sum_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) --Registered output
    );
END sum_register;

ARCHITECTURE behavioral OF sum_register IS
    -- Internal register
    SIGNAL sum_reg : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            sum_reg <= (OTHERS => '0'); -- Clear register on reset
        ELSIF rising_edge(clk) THEN
            IF load = '1' THEN
                sum_reg <= sum_in; -- Load new value
            END IF;
        END IF;
    END PROCESS;

    sum_out <= sum_reg; -- Output assignment
END behavioral;