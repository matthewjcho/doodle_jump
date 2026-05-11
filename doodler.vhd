LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY doodler IS
    PORT (
        v_sync : IN STD_LOGIC;
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        doodler_x : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- current doodler x position
        doodler_y : IN STD_LOGIC_VECTOR (10 DOWNTO 0); -- current doodler y position
        feet : OUT STD_LOGIC_VECTOR (10 DOWNTO 0);     -- current doodler feet position (for jump logic)
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END doodler;

ARCHITECTURE Behavioral OF doodler IS
    SIGNAL score_tmp : STD_LOGIC_VECTOR (15 DOWNTO 0) := (others => '0');

    SIGNAL doodler_on : STD_LOGIC;
    SIGNAL body_on, head_on, l_eye_on, r_eye_on, l_foot_on, r_foot_on : STD_LOGIC;
    SIGNAL S_doodler_x : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (400, 11);
    SIGNAL S_doodler_y : STD_LOGIC_VECTOR (10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR (300, 11);

BEGIN
    red <= '0';
    green <= doodler_on;
    blue <= l_eye_on OR r_eye_on;
    
    draw_doodler : PROCESS (doodler_x, pixel_row, pixel_col) IS
    BEGIN
        -- body
        IF (pixel_col >= doodler_x - 18 AND pixel_col <= doodler_x + 18 AND
            pixel_row >= doodler_y - 20 AND pixel_row <= doodler_y + 20) THEN
            body_on <= '1';
        ELSE
            body_on <= '0'; 
        END IF;
        
       -- head
        IF (pixel_col >= doodler_x - 14 AND pixel_col <= doodler_x + 14 AND
            pixel_row >= doodler_y - 45 AND pixel_row <= doodler_y - 21) THEN
            head_on <= '1';
        ELSE
            head_on <= '0';
        END IF;    
        
        -- left eye
        IF (pixel_col >= doodler_x - 8 AND pixel_col <= doodler_x - 4 AND
            pixel_row >= doodler_y - 31 AND pixel_row <= doodler_y - 27) THEN
            l_eye_on <= '1';
        ELSE
            l_eye_on <= '0';
        END IF;
        
        -- right eye
        IF (pixel_col >= doodler_x + 4 AND pixel_col <= doodler_x + 8 AND
            pixel_row >= doodler_y - 31 AND pixel_row <= doodler_y - 27) THEN
            r_eye_on <= '1';
        ELSE
            r_eye_on <= '0';
        END IF;
                
        -- left foot
        IF (pixel_col >= doodler_x - 12 AND pixel_col <= doodler_x - 4 AND
            pixel_row >= doodler_y + 21 AND pixel_row <= doodler_y + 28) THEN
            l_foot_on <= '1';
        ELSE
            l_foot_on <= '0';
        END IF;        
        
        -- right foot
        IF (pixel_col >= doodler_x + 4 AND pixel_col <= doodler_x + 12 AND
            pixel_row >= doodler_y + 21 AND pixel_row <= doodler_y + 28) THEN
            r_foot_on <= '1';
        ELSE
            r_foot_on <= '0';
        END IF;
            
        
        doodler_on <= head_on OR body_on OR l_eye_on OR r_eye_on OR l_foot_on OR r_foot_on;
        
    END PROCESS;
        
END Behavioral;
