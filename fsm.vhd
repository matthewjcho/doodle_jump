LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fsm IS
    GENERIC (
        N : INTEGER := 16#0100#
    );
    PORT (
        clk_in : IN STD_LOGIC;
        BTNL : IN STD_LOGIC;
        BTNR : IN STD_LOGIC;
        BTN0 : IN STD_LOGIC;
        BTNU : IN STD_LOGIC;
        BTND : IN STD_LOGIC;
        VGA_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        VGA_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        VGA_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        VGA_hsync : OUT STD_LOGIC;
        VGA_vsync : OUT STD_LOGIC;
        SEG7_anode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        SEG7_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END fsm;

ARCHITECTURE Behavioral OF fsm IS

    TYPE state_type IS (S0, S1, S2, S3, S4, S5);
    SIGNAL PS, NS : state_type := S0;

    SIGNAL reset_any : STD_LOGIC := '0';
    SIGNAL pause_internal : STD_LOGIC := '0';
    SIGNAL btnu_prev : STD_LOGIC := '0';
    SIGNAL score_at_target : STD_LOGIC := '0';

    SIGNAL start_pulse : STD_LOGIC := '0';
    SIGNAL btn0_prev : STD_LOGIC := '0';

    SIGNAL land_pulse : STD_LOGIC := '0';
    SIGNAL fall_complete : STD_LOGIC := '0';
    SIGNAL score : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

    SIGNAL game_idle_i : STD_LOGIC := '1';
    SIGNAL game_reset_i : STD_LOGIC := '1';
    SIGNAL game_running_i : STD_LOGIC := '0';
    SIGNAL game_won_i : STD_LOGIC := '0';
    SIGNAL game_lost_i : STD_LOGIC := '0';
    SIGNAL game_pause_i : STD_LOGIC := '0';

    SIGNAL move_left_i : STD_LOGIC := '0';
    SIGNAL move_right_i : STD_LOGIC := '0';
    SIGNAL Y_i : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

    COMPONENT doodle_jump IS
        PORT (
            clk_in : IN STD_LOGIC;
            game_reset : IN STD_LOGIC;
            game_running : IN STD_LOGIC;
            move_left : IN STD_LOGIC;
            move_right : IN STD_LOGIC;
            state_y : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            game_idle_state : IN STD_LOGIC;
            game_pause_state : IN STD_LOGIC;
            game_won_state : IN STD_LOGIC;
            game_lost_state : IN STD_LOGIC;
            score_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            land_pulse : OUT STD_LOGIC;
            fall_complete : OUT STD_LOGIC;
            VGA_red : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            VGA_green : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            VGA_blue : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            VGA_hsync : OUT STD_LOGIC;
            VGA_vsync : OUT STD_LOGIC;
            SEG7_anode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            SEG7_seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    reset_any <= BTND;
    score_at_target <= '1' WHEN unsigned(score) >= TO_UNSIGNED(N, score'LENGTH) ELSE '0';

    start_pulse_process : PROCESS(clk_in)
    BEGIN
        IF rising_edge(clk_in) THEN
            IF (reset_any = '1') THEN
                btn0_prev <= '0';
                start_pulse <= '0';
            ELSE
                btn0_prev <= BTN0;

                IF (BTN0 = '1' AND btn0_prev = '0') THEN
                    start_pulse <= '1';
                ELSE
                    start_pulse <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS;
    
    
    pause_toggle_process : PROCESS(clk_in)
    BEGIN
        IF rising_edge(clk_in) THEN
            
            IF (reset_any = '1') THEN
                pause_internal <= '0';
                btnu_prev <= '0';
                
            ELSE
                btnu_prev <= BTNU;
                
                IF (BTNU = '1' AND btnu_prev = '0') THEN
                    pause_internal <= NOT pause_internal;
                END IF;
                
            END IF;
        
        END IF;                
    END PROCESS;


    clockAndReset : PROCESS(clk_in, reset_any)
    BEGIN
        IF (reset_any = '1') THEN
            PS <= S0;
        ELSIF rising_edge(clk_in) THEN
            PS <= NS;
        END IF;
    END PROCESS;


    nextStateLogic : PROCESS(PS, start_pulse, land_pulse, fall_complete, pause_internal, score_at_target)
    BEGIN
        NS <= PS;

        CASE PS IS

            -- Idle
            WHEN S0 =>
                IF (start_pulse = '1') THEN
                    NS <= S2;
                END IF;

            -- Landed
            WHEN S1 =>
                IF (pause_internal = '1') THEN
                    NS <= S5;
                ELSIF (score_at_target = '1') THEN
                    NS <= S3;
                ELSIF (fall_complete = '1') THEN
                    NS <= S4;
                ELSE
                    NS <= S2;
                END IF;

            -- Running
            WHEN S2 =>
                IF (pause_internal = '1') THEN
                    NS <= S5;
                ELSIF (score_at_target = '1') THEN
                    NS <= S3;
                ELSIF (fall_complete = '1') THEN
                    NS <= S4;
                ELSIF (land_pulse = '1') THEN
                    NS <= S1;
                END IF;

            -- Win
            WHEN S3 =>
                NS <= S3;

            -- Lose
            WHEN S4 =>
                NS <= S4;
                
            -- Pause
            WHEN S5 =>
                IF (pause_internal = '0') THEN
                    NS <= S2;
                ELSE
                    NS <= S5;
                END IF;

        END CASE;
    END PROCESS;

    WITH PS SELECT
        Y_i <= "000" WHEN S0,
               "001" WHEN S1,
               "010" WHEN S2,
               "011" WHEN S3,
               "100" WHEN S4,
               "101" WHEN S5,
               "000" WHEN OTHERS;

    
    game_idle_i <= '1' WHEN PS = S0 ELSE '0';
    game_pause_i <= '1' WHEN PS = S5 ELSE '0';
    game_reset_i <= '1' WHEN (reset_any = '1' OR PS = S0) ELSE '0';
    game_running_i <= '1' WHEN (PS = S1 OR PS = S2) ELSE '0';
    game_won_i <= '1' WHEN PS = S3 ELSE '0';
    game_lost_i <= '1' WHEN PS = S4 ELSE '0';

    move_left_i <= BTNL WHEN (PS = S1 OR PS = S2) ELSE '0';
    move_right_i <= BTNR WHEN (PS = S1 OR PS = S2) ELSE '0';


    game : doodle_jump
        PORT MAP (
            clk_in => clk_in,
            game_reset => game_reset_i,
            game_running => game_running_i,
            move_left => move_left_i,
            move_right => move_right_i,
            state_y => Y_i,
            game_idle_state => game_idle_i,
            game_pause_state => game_pause_i,
            game_won_state => game_won_i,
            game_lost_state => game_lost_i,
            score_out => score,
            land_pulse => land_pulse,
            fall_complete => fall_complete,
            VGA_red => VGA_red,
            VGA_green => VGA_green,
            VGA_blue => VGA_blue,
            VGA_hsync => VGA_hsync,
            VGA_vsync => VGA_vsync,
            SEG7_anode => SEG7_anode,
            SEG7_seg => SEG7_seg
        );

END Behavioral;
