LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY platform IS
    PORT (
        v_sync : IN STD_LOGIC;
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        platform_pos_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
        platform_pos_y : IN STD_LOGIC_VECTOR (10 DOWNTO 0);
        platform_type : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        broken : IN std_logic;
        curr_platform_pos_x : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        curr_platform_pos_y : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC   
    );
END platform;

ARCHITECTURE Behavioral OF platform IS

    CONSTANT platform_w : INTEGER := 20;
    CONSTANT platform_h : INTEGER := 4;
    CONSTANT move_speed : INTEGER := 2;
    CONSTANT move_range : INTEGER := 60;

    SIGNAL curr_x, curr_y, spawn_x, spawn_y : INTEGER;
    SIGNAL spawn_type : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

    SIGNAL move_dir : STD_LOGIC := '1';
    
    

BEGIN
    curr_platform_pos_x <= STD_LOGIC_VECTOR(to_unsigned(curr_x, 11));
    curr_platform_pos_y <= STD_LOGIC_VECTOR(to_unsigned(curr_y, 11));

    update_platform : PROCESS(v_sync)
    VARIABLE input_x : INTEGER;
    VARIABLE input_y : INTEGER;
        
    BEGIN
        IF rising_edge(v_sync) THEN

            input_x := TO_INTEGER(unsigned(platform_pos_x));
            input_y := TO_INTEGER(unsigned(platform_pos_y));

            IF (input_x /= spawn_x OR input_y /= spawn_y OR platform_type /= spawn_type) THEN

                spawn_x <= input_x;
                spawn_y <= input_y;
                spawn_type <= platform_type;
    
                curr_x <= input_x;
                curr_y <= input_y;
        
                move_dir <= platform_pos_x(0);

            ELSE
                -- IF MOVING BLUE
                IF (platform_type = "01") THEN
                    
                    -- MOVE RIGHT TILL MOVE_RANGE IS HIT
                    IF (move_dir = '1') THEN
                        IF (curr_x < spawn_x + move_range) THEN
                            curr_x <= curr_x + move_speed;
                        ELSE
                            move_dir <= '0';
                        END IF;
                    
                    -- MOVE LEFT TILL MOVE_RANGE IS HIT
                    ELSE
                        IF (curr_x > spawn_x - move_range) THEN
                            curr_x <= curr_x - move_speed;
                        ELSE
                            move_dir <= '1';
                        END IF;
                        
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;


    create_platform : PROCESS(platform_type, pixel_row, pixel_col, curr_x, curr_y, broken)
    VARIABLE row : INTEGER;
    VARIABLE col : INTEGER;
    VARIABLE platform_on : STD_LOGIC;
        
    BEGIN

        row := TO_INTEGER(unsigned(pixel_row));
        col := TO_INTEGER(unsigned(pixel_col));

        red <= '0';
        green <= '0';
        blue <= '0';

        platform_on := '0';

        IF (broken = '0') THEN

            IF (col >= curr_x - platform_w AND col <= curr_x + platform_w AND
                row >= curr_y - platform_h AND row <= curr_y + platform_h) THEN

                platform_on := '1';

            END IF;
        END IF;

        IF (platform_on = '1') THEN

            -- MOVING BLUE
            IF (platform_type = "01") THEN
                red <= '0';
                green <= '0';
                blue <= '1';

            -- BREAKING YELLOW
            ELSIF (platform_type = "10") THEN
                red <= '1';
                green <= '1';
                blue <= '0';

            -- DEFAULT GREEN
            ELSE
                red <= '0';
                green <= '1';
                blue <= '0';

            END IF;
        END IF;
    END PROCESS;

END Behavioral;