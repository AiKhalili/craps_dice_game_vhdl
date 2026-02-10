LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY seven_seg_tb IS
END seven_seg_tb;

ARCHITECTURE Behavioral OF seven_seg_tb IS
    SIGNAL bin_input : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL seg_output : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
    seg_uut : ENTITY work.seven_seg PORT MAP
        (bin_input => bin_input,
        seg_output => seg_output
        );

    PROCESS
    BEGIN
        -- Test 1: Number 1
        bin_input <= "001";
        WAIT FOR 20 ns;

        -- Test 2: Number 2
        bin_input <= "010";
        WAIT FOR 20 ns;

        -- Test 3: Number 3
        bin_input <= "011";
        WAIT FOR 20 ns;

        -- Test 4: Number 4
        bin_input <= "100";
        WAIT FOR 20 ns;

        -- Test 5: Number 5
        bin_input <= "101";
        WAIT FOR 20 ns;

        -- Test 6: Number 6
        bin_input <= "110";
        WAIT FOR 20 ns;

        -- Test 7: Invalid input 0
        bin_input <= "000";
        WAIT FOR 20 ns;

        -- Test 8: Invalid input 7
        bin_input <= "111";
        WAIT FOR 20 ns;

        WAIT FOR 50 ns;
        WAIT;
    END PROCESS;

END Behavioral;