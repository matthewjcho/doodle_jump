LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY doodle_jump IS
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
END doodle_jump;

ARCHITECTURE Behavioral OF doodle_jump IS

    CONSTANT GROUND_POS : INTEGER := 500;

    SIGNAL pxl_clk : STD_LOGIC := '0';

    SIGNAL display : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL led_mpx : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL S_red, S_green, S_blue : STD_LOGIC;
    SIGNAL final_red, final_green, final_blue : STD_LOGIC;

    SIGNAL S_red_doodler, S_green_doodler, S_blue_doodler : STD_LOGIC;
    SIGNAL S_red_platform, S_green_platform, S_blue_platform : STD_LOGIC;

    SIGNAL S_vsync : STD_LOGIC;

    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR(10 DOWNTO 0);

    SIGNAL doodler_x_pos : UNSIGNED(10 DOWNTO 0) := TO_UNSIGNED(400, 11);
    SIGNAL doodler_y_pos : UNSIGNED(10 DOWNTO 0) := TO_UNSIGNED(GROUND_POS, 11);
    SIGNAL doodler_feet : UNSIGNED(10 DOWNTO 0);

    SIGNAL landed : STD_LOGIC := '0';
    SIGNAL falling : STD_LOGIC := '0';

    SIGNAL count : UNSIGNED(20 DOWNTO 0) := (OTHERS => '0');
    SIGNAL jump_count : UNSIGNED(5 DOWNTO 0) := (OTHERS => '0');

    SIGNAL landed_prev : STD_LOGIC := '0';

    SIGNAL state_allows_update : STD_LOGIC := '0';
    SIGNAL active_update : STD_LOGIC := '0';

    CONSTANT num_platforms : INTEGER := 8;
    CONSTANT platform_h : INTEGER := 4;
    CONSTANT collision_half_width : INTEGER := 32;

    TYPE platform_pos_array IS ARRAY (0 TO num_platforms - 1) OF UNSIGNED(10 DOWNTO 0);
    TYPE platform_type_array IS ARRAY (0 TO num_platforms - 1) OF STD_LOGIC_VECTOR(1 DOWNTO 0);
    TYPE platform_broken_array IS ARRAY (0 TO num_platforms - 1) OF STD_LOGIC;
    TYPE platform_hit_array IS ARRAY (0 TO num_platforms - 1) OF STD_LOGIC;
    TYPE platform_curr_pos_array IS ARRAY (0 TO num_platforms - 1) OF STD_LOGIC_VECTOR(10 DOWNTO 0);

    SIGNAL platform_x : platform_pos_array := (OTHERS => TO_UNSIGNED(400, 11));
    SIGNAL platform_y : platform_pos_array := (OTHERS => TO_UNSIGNED(300, 11));
    SIGNAL curr_platform_x : platform_curr_pos_array := (OTHERS => (OTHERS => '0'));
    SIGNAL curr_platform_y : platform_curr_pos_array := (OTHERS => (OTHERS => '0'));

    SIGNAL platform_type : platform_type_array := (OTHERS => "00");

    SIGNAL S_broken : platform_broken_array := (OTHERS => '0');
    SIGNAL platform_hit : platform_hit_array := (OTHERS => '0');

    SIGNAL platform_red : STD_LOGIC_VECTOR(num_platforms - 1 DOWNTO 0);
    SIGNAL platform_green : STD_LOGIC_VECTOR(num_platforms - 1 DOWNTO 0);
    SIGNAL platform_blue : STD_LOGIC_VECTOR(num_platforms - 1 DOWNTO 0);

    SIGNAL random_bits : STD_LOGIC_VECTOR(15 DOWNTO 0) := X"ACE1";

    SIGNAL idle_red, idle_green, idle_blue : STD_LOGIC;
    SIGNAL pause_red, pause_green, pause_blue : STD_LOGIC;
    SIGNAL win_red, win_green, win_blue : STD_LOGIC;
    SIGNAL lose_red, lose_green, lose_blue : STD_LOGIC;

    COMPONENT doodler IS
        PORT (
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            doodler_x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            doodler_y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT platform IS
        PORT (
            clk_in : IN STD_LOGIC;
            v_sync : IN STD_LOGIC;
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            platform_pos_x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            platform_pos_y : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            platform_type : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            broken : IN STD_LOGIC;
            curr_platform_pos_x : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            curr_platform_pos_y : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT idle_screen IS 
        PORT (
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            idle_state : IN STD_LOGIC;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC  
        );
    END COMPONENT;
    
    COMPONENT pause_screen IS
        PORT (
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pause_state : IN STD_LOGIC;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT win_screen IS
        PORT (
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            win_state : IN STD_LOGIC;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT lose_screen IS
        PORT (
            pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            lose_state : IN STD_LOGIC;
            red : OUT STD_LOGIC;
            green : OUT STD_LOGIC;
            blue : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT vga_sync IS
        PORT (
            pixel_clk : IN STD_LOGIC;
            red_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            green_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            blue_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            red_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            green_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            blue_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hsync : OUT STD_LOGIC;
            vsync : OUT STD_LOGIC;
            pixel_row : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            pixel_col : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT clk_wiz_0 IS
        PORT (
            clk_in1 : IN STD_LOGIC;
            clk_out1 : OUT STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT leddec16 IS
        PORT (
            dig : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            anode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    doodler_feet <= doodler_y_pos + TO_UNSIGNED(28, 11);
    falling <= '1' WHEN jump_count >= TO_UNSIGNED(16, 6) ELSE '0';

    score_out <= display;
    fall_complete <= '1' WHEN TO_INTEGER(doodler_feet) >= 700 ELSE '0';

    led_mpx <= STD_LOGIC_VECTOR(count(19 DOWNTO 17));

    state_allows_update <= '1' WHEN (state_y = "001" OR state_y = "010") ELSE '0';
    active_update <= game_running AND state_allows_update;

    land_pulse_process : PROCESS(clk_in)
    BEGIN
        IF rising_edge(clk_in) THEN
            IF (game_reset = '1') THEN
                landed_prev <= '0';
                land_pulse <= '0';

            ELSIF (active_update = '1' AND count = 0) THEN
                landed_prev <= landed;

                IF (landed = '1' AND landed_prev = '0') THEN
                    land_pulse <= '1';
                ELSE
                    land_pulse <= '0';
                END IF;

            ELSE
                land_pulse <= '0';
            END IF;
        END IF;
    END PROCESS;

    landed_check : PROCESS(doodler_feet, doodler_x_pos, curr_platform_x, curr_platform_y, S_broken, falling)
        VARIABLE hit : STD_LOGIC;
        VARIABLE hit_array : platform_hit_array;
        VARIABLE curr_feet_int : INTEGER;
        VARIABLE doodler_x_int : INTEGER;
        VARIABLE platform_x_int : INTEGER;
        VARIABLE platform_y_top, platform_y_bot : INTEGER;
    BEGIN
        hit := '0';
        hit_array := (OTHERS => '0');

        curr_feet_int := TO_INTEGER(doodler_feet);
        doodler_x_int := TO_INTEGER(doodler_x_pos);

        FOR i IN 0 TO num_platforms - 1 LOOP
            platform_x_int := TO_INTEGER(unsigned(curr_platform_x(i)));
            platform_y_top := TO_INTEGER(unsigned(curr_platform_y(i))) - platform_h;
            platform_y_bot := TO_INTEGER(unsigned(curr_platform_y(i))) + platform_h;

            IF falling = '1' AND S_broken(i) = '0' THEN
                IF (curr_feet_int >= platform_y_top) AND
                   (curr_feet_int <= platform_y_bot) AND
                   (ABS(doodler_x_int - platform_x_int) < collision_half_width) THEN

                    hit := '1';
                    hit_array(i) := '1';

                END IF;
            END IF;
        END LOOP;

        landed <= hit;
        platform_hit <= hit_array;
    END PROCESS;


    doodler_pos : PROCESS(clk_in)
    BEGIN
        IF rising_edge(clk_in) THEN
            count <= count + 1;

            IF game_reset = '1' THEN
                count <= (OTHERS => '0');
                jump_count <= (OTHERS => '0');
                display <= (OTHERS => '0');

                doodler_x_pos <= TO_UNSIGNED(400, 11);
                doodler_y_pos <= TO_UNSIGNED(GROUND_POS, 11);

            ELSIF active_update = '1' THEN
                IF count = 0 THEN

                    IF move_left = '1' THEN
                        IF doodler_x_pos <= TO_UNSIGNED(0, 11) THEN
                            doodler_x_pos <= TO_UNSIGNED(800, 11);
                        ELSE
                            doodler_x_pos <= doodler_x_pos - TO_UNSIGNED(10, 11);
                        END IF;

                    ELSIF move_right = '1' THEN
                        IF doodler_x_pos >= TO_UNSIGNED(800, 11) THEN
                            doodler_x_pos <= TO_UNSIGNED(0, 11);
                        ELSE
                            doodler_x_pos <= doodler_x_pos + TO_UNSIGNED(10, 11);
                        END IF;
                    END IF;

                    IF (landed = '1') THEN
                        jump_count <= (OTHERS => '0');
                        display <= STD_LOGIC_VECTOR(unsigned(display) + TO_UNSIGNED(10, 16));

                    ELSIF (jump_count < TO_UNSIGNED(8, 6)) THEN
                        
                        IF (doodler_y_pos <= TO_UNSIGNED(15, 11)) THEN
                            doodler_y_pos<= TO_UNSIGNED(0, 11);
                        ELSE
                            doodler_y_pos <= doodler_y_pos - TO_UNSIGNED(15, 11);
                        END IF;
                    
                        jump_count <= jump_count + 1;

                    ELSIF (jump_count < TO_UNSIGNED(16, 6)) THEN
                    
                        IF (doodler_y_pos <= TO_UNSIGNED(5, 11)) THEN
                            doodler_y_pos <= TO_UNSIGNED(0, 11);
                        ELSE
                            doodler_y_pos <= doodler_y_pos - TO_UNSIGNED(5, 11);
                        END IF;
                        
                        jump_count <= jump_count + 1;

                    ELSE
                        doodler_y_pos <= doodler_y_pos + TO_UNSIGNED(8, 11);
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;


    define_platform : PROCESS(clk_in)
        VARIABLE lfsr_next : STD_LOGIC_VECTOR(15 DOWNTO 0);
        VARIABLE new_x : INTEGER;
        VARIABLE new_y : INTEGER;
        CONSTANT max_dx : INTEGER := 160;
        CONSTANT min_x : INTEGER := 50;
        CONSTANT max_x : INTEGER := 750;
        CONSTANT min_spawn_y : INTEGER := 20;
        CONSTANT max_spawn_y : INTEGER := 120;
        VARIABLE random_offset : INTEGER;
    BEGIN
        IF rising_edge(clk_in) THEN

            IF game_reset = '1' THEN
                random_bits <= X"ACE1";

                platform_type <= (OTHERS => "00");
                S_broken <= (OTHERS => '0');

                platform_x(0) <= TO_UNSIGNED(280, 11);
                platform_y(0) <= TO_UNSIGNED(540, 11);

                platform_x(1) <= TO_UNSIGNED(260, 11);
                platform_y(1) <= TO_UNSIGNED(470, 11);

                platform_x(2) <= TO_UNSIGNED(320, 11);
                platform_y(2) <= TO_UNSIGNED(400, 11);

                platform_x(3) <= TO_UNSIGNED(410, 11);
                platform_y(3) <= TO_UNSIGNED(330, 11);

                platform_x(4) <= TO_UNSIGNED(310, 11);
                platform_y(4) <= TO_UNSIGNED(260, 11);

                platform_x(5) <= TO_UNSIGNED(340, 11);
                platform_y(5) <= TO_UNSIGNED(190, 11);

                platform_x(6) <= TO_UNSIGNED(420, 11);
                platform_y(6) <= TO_UNSIGNED(120, 11);

                platform_x(7) <= TO_UNSIGNED(400, 11);
                platform_y(7) <= TO_UNSIGNED(40, 11);

            ELSIF active_update = '1' AND count = 0 THEN

                FOR i IN 0 TO num_platforms - 1 LOOP
                    IF platform_hit(i) = '1' AND platform_type(i) = "10" THEN
                        S_broken(i) <= '1';
                    END IF;
                END LOOP;

                IF landed = '1' THEN
                    FOR i IN 0 TO num_platforms - 1 LOOP
                        platform_y(i) <= platform_y(i) + TO_UNSIGNED(75, 11);
                    END LOOP;
                END IF;

                lfsr_next := random_bits;

                FOR i IN 0 TO num_platforms - 1 LOOP
                    IF TO_INTEGER(platform_y(i)) > 600 THEN

                        lfsr_next := lfsr_next(14 DOWNTO 0) &
                                     (lfsr_next(15) XOR lfsr_next(13) XOR lfsr_next(12) XOR lfsr_next(10));
                        
                        random_offset := (TO_INTEGER(unsigned(lfsr_next(7 DOWNTO 0))) MOD (2 * max_dx + 1)) - max_dx;
                        
                        IF (i = 0) THEN
                            new_x := TO_INTEGER(platform_x(num_platforms - 1)) + random_offset;
                        ELSE
                            new_x := TO_INTEGER(platform_x(i - 1)) + random_offset;
                        END IF;
                        
                        IF (new_x < min_x) THEN
                            new_x := min_x;
                        ELSIF (new_x > max_x) THEN
                            new_x := max_x;
                        END IF;
                        
                        platform_x(i) <= TO_UNSIGNED(new_x, 11);

                        lfsr_next := lfsr_next(14 DOWNTO 0) &
                                     (lfsr_next(15) XOR lfsr_next(13) XOR lfsr_next(12) XOR lfsr_next(10));

                        new_y := TO_INTEGER(unsigned(lfsr_next(7 DOWNTO 0)) MOD (max_spawn_y - min_spawn_y + 1)) + min_spawn_y;
                        platform_y(i) <= TO_UNSIGNED(new_y, 11);

                        lfsr_next := lfsr_next(14 DOWNTO 0) &
                                     (lfsr_next(15) XOR lfsr_next(13) XOR lfsr_next(12) XOR lfsr_next(10));

                        platform_type(i) <= lfsr_next(15 DOWNTO 14);
                        S_broken(i) <= '0';
                    END IF;
                END LOOP;

                random_bits <= lfsr_next;
            END IF;
        END IF;
    END PROCESS;

    platform_mux : PROCESS(platform_red, platform_green, platform_blue)
        VARIABLE r_tmp : STD_LOGIC;
        VARIABLE g_tmp : STD_LOGIC;
        VARIABLE b_tmp : STD_LOGIC;
    BEGIN
        r_tmp := '0';
        g_tmp := '0';
        b_tmp := '0';

        FOR i IN 0 TO num_platforms - 1 LOOP
            r_tmp := r_tmp OR platform_red(i);
            g_tmp := g_tmp OR platform_green(i);
            b_tmp := b_tmp OR platform_blue(i);
        END LOOP;

        S_red_platform <= r_tmp;
        S_green_platform <= g_tmp;
        S_blue_platform <= b_tmp;
        
    END PROCESS;

    S_red <= S_red_doodler WHEN
             (S_red_doodler = '1' OR S_green_doodler = '1' OR S_blue_doodler = '1')
             ELSE S_red_platform;

    S_green <= S_green_doodler WHEN
               (S_red_doodler = '1' OR S_green_doodler = '1' OR S_blue_doodler = '1')
               ELSE S_green_platform;

    S_blue <= S_blue_doodler WHEN
              (S_red_doodler = '1' OR S_green_doodler = '1' OR S_blue_doodler = '1')
              ELSE S_blue_platform;

 
    final_red <= idle_red WHEN game_idle_state = '1' ELSE
                 win_red WHEN game_won_state = '1' ELSE
                 lose_red WHEN game_lost_state = '1' ELSE
                 pause_red WHEN game_pause_state = '1' ELSE
                 S_red;

    final_green <= idle_green WHEN game_idle_state = '1' ELSE
                   win_green WHEN game_won_state = '1' ELSE
                   lose_green WHEN game_lost_state = '1' ELSE
                   pause_green WHEN game_pause_state = '1' ELSE              
                   S_green;

    final_blue <= idle_blue WHEN game_idle_state = '1' ELSE
                  win_blue WHEN game_won_state = '1' ELSE
                  lose_blue WHEN game_lost_state = '1' ELSE
                  pause_blue WHEN game_pause_state = '1' ELSE
                  S_blue;

    add_doodler : doodler
        PORT MAP (
            v_sync => S_vsync,
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            doodler_x => STD_LOGIC_VECTOR(doodler_x_pos),
            doodler_y => STD_LOGIC_VECTOR(doodler_y_pos),
            red => S_red_doodler,
            green => S_green_doodler,
            blue => S_blue_doodler
        );

    generate_platforms : FOR i IN 0 TO num_platforms - 1 GENERATE
    BEGIN
        add_platform : platform
            PORT MAP (
                clk_in => clk_in,
                v_sync => S_vsync,
                pixel_row => S_pixel_row,
                pixel_col => S_pixel_col,
                platform_pos_x => STD_LOGIC_VECTOR(platform_x(i)),
                platform_pos_y => STD_LOGIC_VECTOR(platform_y(i)),
                platform_type => platform_type(i),
                broken => S_broken(i),
                curr_platform_pos_x => curr_platform_x(i),
                curr_platform_pos_y => curr_platform_y(i),
                red => platform_red(i),
                green => platform_green(i),
                blue => platform_blue(i)
            );
    END GENERATE generate_platforms;
    
    display_idle : idle_screen
        PORT MAP (
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            idle_state => game_idle_state,
            red => idle_red,
            green => idle_green,
            blue => idle_blue
        );
        
    display_pause : pause_screen
        PORT MAP (
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            pause_state => game_pause_state,
            red => pause_red,
            green => pause_green,
            blue => pause_blue
        );

    display_win : win_screen
        PORT MAP (
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            win_state => game_won_state,
            red => win_red,
            green => win_green,
            blue => win_blue
        );

    display_lose : lose_screen
        PORT MAP (
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            lose_state => game_lost_state,
            red => lose_red,
            green => lose_green,
            blue => lose_blue
        );

    vga_driver : vga_sync
        PORT MAP (
            pixel_clk => pxl_clk,
            red_in => final_red & "000",
            green_in => final_green & "000",
            blue_in => final_blue & "000",
            red_out => VGA_red,
            green_out => VGA_green,
            blue_out => VGA_blue,
            pixel_row => S_pixel_row,
            pixel_col => S_pixel_col,
            hsync => VGA_hsync,
            vsync => S_vsync
        );

    VGA_vsync <= S_vsync;

    clk_wiz_0_inst : clk_wiz_0
        PORT MAP (
            clk_in1 => clk_in,
            clk_out1 => pxl_clk
        );

    led1 : leddec16
        PORT MAP (
            dig => led_mpx,
            data => display,
            anode => SEG7_anode,
            seg => SEG7_seg
        );

END Behavioral;
