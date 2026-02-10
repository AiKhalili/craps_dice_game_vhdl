LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Verifies correct summation of two dice values (1–6)
ENTITY tb_adder IS
END tb_adder;

ARCHITECTURE Behavioral OF tb_adder IS

    SIGNAL dice1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL dice2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    adder_inst : ENTITY work.adder
        PORT MAP(
            dice1 => dice1,
            dice2 => dice2,
            sum => sum
        );

    PROCESS
    BEGIN
        --Test 1: 1 + 1 = 2
        dice1 <= "001";
        dice2 <= "001";
        WAIT FOR 10 ns;

        --Test 2: 3 + 2 = 5
        dice1 <= "011";
        dice2 <= "010";
        WAIT FOR 10 ns;

        --Test 3: 6 + 6 = 12
        dice1 <= "110";
        dice2 <= "110";
        WAIT FOR 10 ns;

        --Test 4: 5 + 3 = 8
        dice1 <= "101";
        dice2 <= "011";
        WAIT FOR 10 ns;

        --Test 5: 2 + 4 = 6
        dice1 <= "010";
        dice2 <= "100";
        WAIT FOR 10 ns;

        --Test 6: 4 + 5 = 9
        dice1 <= "100";
        dice2 <= "101";
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END Behavioral;