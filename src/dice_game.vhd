LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY dice_game IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        roll_btn : IN STD_LOGIC;

        seg1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        seg2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);

        win : OUT STD_LOGIC;
        lose : OUT STD_LOGIC
    );
END dice_game;

ARCHITECTURE Structural OF dice_game IS

    -- Dice values
    SIGNAL dice1_val, dice2_val : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- Sum signals
    SIGNAL sum, sum_latched : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Point
    SIGNAL point : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Control signals
    SIGNAL roll_en : STD_LOGIC;
    SIGNAL sum_ld : STD_LOGIC;
    SIGNAL Sp : STD_LOGIC;

    -- compare
    SIGNAL Eq : STD_LOGIC;
    SIGNAL D7 : STD_LOGIC;
    SIGNAL D711 : STD_LOGIC;
    SIGNAL D2312 : STD_LOGIC;

    -- Point control
    SIGNAL point_phase : STD_LOGIC;
    SIGNAL point_load : STD_LOGIC;

BEGIN

    -- Dice counters
    dice1 : ENTITY work.dice_counter
        GENERIC MAP(SEED => "101")
        PORT MAP(clk, reset, roll_en, dice1_val);

    dice2 : ENTITY work.dice_counter
        GENERIC MAP(SEED => "011")
        PORT MAP(clk, reset, roll_en, dice2_val);

    -- Seven segment displays
    seg_disp1 : ENTITY work.seven_seg
        PORT MAP(dice1_val, seg1);

    seg_disp2 : ENTITY work.seven_seg
        PORT MAP(dice2_val, seg2);

    -- Adder
    adder_inst : ENTITY work.adder
        PORT MAP(dice1_val, dice2_val, sum);

    -- Sum register
    sum_reg : ENTITY work.sum_register
        PORT MAP(clk, reset, sum_ld, sum, sum_latched);

    point_load <= Sp AND point_phase;

    -- Point register
    point_reg : ENTITY work.point_register
        PORT MAP(
            clk,
            reset,
            point_load,
            sum_latched,
            point
        );

    -- Comparator (sum == point)
    comp : ENTITY work.comparator
        PORT MAP(sum_latched, point, Eq);

    -- Test logic 
    test_logic_inst : ENTITY work.test_logic
        PORT MAP(sum_latched, D7, D711, D2312);

    -- Controller FSM
    ctrl : ENTITY work.controller
        PORT MAP(
            clk => clk,
            reset => reset,
            enter => roll_btn,
            Eq => Eq,
            D7 => D7,
            D711 => D711,
            D2312 => D2312,
            win => win,
            lose => lose,
            Sp => Sp,
            roll => roll_en,
            sum_ld => sum_ld,
            point_phase => point_phase
        );

END Structural;