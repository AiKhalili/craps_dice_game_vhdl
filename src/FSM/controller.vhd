LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- FSM controller for Craps dice game
ENTITY controller IS
    PORT (
        clk, reset, enter : IN STD_LOGIC; -- Clock, reset, roll button
        Eq, D7, D711, D2312 : IN STD_LOGIC; -- Comparison flags from datapath

        win, lose : OUT STD_LOGIC; -- Game result outputs
        Sp : OUT STD_LOGIC; -- Store point
        roll : OUT STD_LOGIC; -- Enable dice rolling
        sum_ld : OUT STD_LOGIC; -- Latch dice sum
        point_phase : OUT STD_LOGIC -- Indicates point phase
    );
END controller;

ARCHITECTURE Behavioral OF controller IS

    -- FSM states definition
    TYPE state_type IS (
        S_IDLE, -- Waiting for player to press enter
        S_ROLL_FIRST, -- Rolling dice for first throw
        S_LATCH_FIRST, -- Latch sum of first throw
        S_EVAL_FIRST, -- Evaluate first throw
        S_POINT_WAIT, -- Waiting for next roll in point phase
        S_ROLL_POINT, -- Rolling dice during point phase
        S_LATCH_POINT, -- Latch sum during point phase
        S_EVAL_POINT, -- Evaluate point phase roll
        S_WIN, -- Win state
        S_LOSE -- Lose state
    );

    SIGNAL state, next_state : state_type;

BEGIN

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            state <= S_IDLE;
        ELSIF rising_edge(clk) THEN
            state <= next_state;
        END IF;
    END PROCESS;

    -- Next-state logic (combinational)
    PROCESS (state, enter, Eq, D7, D711, D2312)
    BEGIN
        CASE state IS

            WHEN S_IDLE =>
                IF enter = '1' THEN
                    next_state <= S_ROLL_FIRST;
                ELSE
                    next_state <= S_IDLE;
                END IF;

            WHEN S_ROLL_FIRST =>
                IF enter = '0' THEN
                    next_state <= S_LATCH_FIRST;
                ELSE
                    next_state <= S_ROLL_FIRST;
                END IF;

            WHEN S_LATCH_FIRST =>
                next_state <= S_EVAL_FIRST;

            WHEN S_EVAL_FIRST =>
                IF D711 = '1' THEN -- 7 or 11 : win
                    next_state <= S_WIN;
                ELSIF D2312 = '1' THEN -- 2, 3, or 12 : lose
                    next_state <= S_LOSE;
                ELSE -- Otherwise : point phase
                    next_state <= S_POINT_WAIT;
                END IF;

            WHEN S_POINT_WAIT =>
                IF enter = '1' THEN
                    next_state <= S_ROLL_POINT;
                ELSE
                    next_state <= S_POINT_WAIT;
                END IF;

            WHEN S_ROLL_POINT =>
                IF enter = '0' THEN
                    next_state <= S_LATCH_POINT;
                ELSE
                    next_state <= S_ROLL_POINT;
                END IF;

            WHEN S_LATCH_POINT =>
                next_state <= S_EVAL_POINT;

            WHEN S_EVAL_POINT =>
                IF Eq = '1' THEN -- Sum equals point : win
                    next_state <= S_WIN;
                ELSIF D7 = '1' THEN -- 7 during point : lose
                    next_state <= S_LOSE;
                ELSE
                    next_state <= S_POINT_WAIT;
                END IF;

            WHEN S_WIN =>
                next_state <= S_WIN;

            WHEN S_LOSE =>
                next_state <= S_LOSE;

        END CASE;
    END PROCESS;

    -- Output logic (Moore-style)
    PROCESS (state)
    BEGIN
        roll <= '0';
        sum_ld <= '0';
        Sp <= '0';
        win <= '0';
        lose <= '0';
        point_phase <= '0';

        CASE state IS

            WHEN S_ROLL_FIRST =>
                roll <= '1';

            WHEN S_ROLL_POINT =>
                roll <= '1';
                point_phase <= '1';

            WHEN S_LATCH_FIRST =>
                sum_ld <= '1';

            WHEN S_LATCH_POINT =>
                sum_ld <= '1';
                point_phase <= '1';

            WHEN S_POINT_WAIT =>
                Sp <= '1'; -- Store point value
                point_phase <= '1';

            WHEN S_EVAL_POINT =>
                point_phase <= '1';

            WHEN S_WIN =>
                win <= '1';

            WHEN S_LOSE =>
                lose <= '1';

            WHEN OTHERS =>
                NULL;

        END CASE;
    END PROCESS;
END Behavioral;