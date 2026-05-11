LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY pause_screen IS
    PORT (
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pause_state : IN STD_LOGIC;
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END pause_screen;

ARCHITECTURE Behavioral OF pause_screen IS
    SIGNAL placement_x : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(400, 11);
    SIGNAL placement_y : STD_LOGIC_VECTOR(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(300, 11);
    SIGNAL letters_paused : STD_LOGIC;
    SIGNAL letters_on : STD_LOGIC;
    
BEGIN
    red <= '0';
    green <= '0';
    blue <= letters_on;
    
    display_pause : PROCESS(pixel_row, pixel_col, pause_state)
    BEGIN
        letters_paused <= '0';
        letters_on <= '0';

        IF (pause_state = '1') THEN
        -- "PAUSED"
        -- P
        
        IF ((pixel_col >= placement_x - 150 AND pixel_col <= placement_x - 145 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x - 150 AND pixel_col <= placement_x - 120 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y - 35) OR
            (pixel_col >= placement_x - 150 AND pixel_col <= placement_x - 120 AND
             pixel_row >= placement_y AND pixel_row <= placement_y + 5) OR
            (pixel_col >= placement_x - 125 AND pixel_col <= placement_x - 120 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y)) THEN
             
            letters_paused <= '1';
        END IF;


        -- A
        IF ((pixel_col >= placement_x - 100 AND pixel_col <= placement_x - 95 AND
             pixel_row >= placement_y - 40  AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x - 75 AND pixel_col <= placement_x - 70 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x - 100 AND pixel_col <= placement_x - 70 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y - 35) OR
            (pixel_col >= placement_x - 100 AND pixel_col <= placement_x - 70 AND
             pixel_row >= placement_y AND pixel_row <= placement_y + 5)) THEN
             
            letters_paused <= '1';
        END IF;


        -- U
        IF ((pixel_col >= placement_x - 50 AND pixel_col <= placement_x - 45 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 35) OR
            (pixel_col >= placement_x - 25 AND pixel_col <= placement_x - 20 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 35) OR
            (pixel_col >= placement_x - 50 AND pixel_col <= placement_x - 20 AND
             pixel_row >= placement_y + 35 AND pixel_row <= placement_y + 40)) THEN
             
            letters_paused <= '1';
        END IF;


        -- S
        IF ((pixel_col >= placement_x AND pixel_col <= placement_x + 30 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y - 35) OR
            (pixel_col >= placement_x AND pixel_col <= placement_x + 5 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y) OR
            (pixel_col >= placement_x AND pixel_col <= placement_x + 30 AND
             pixel_row >= placement_y AND pixel_row <= placement_y + 5) OR
            (pixel_col >= placement_x + 25 AND pixel_col <= placement_x + 30 AND
             pixel_row >= placement_y AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x AND pixel_col <= placement_x + 30 AND
             pixel_row >= placement_y + 35 AND pixel_row <= placement_y + 40)) THEN
             
            letters_paused <= '1';
        END IF;


        -- E
        IF ((pixel_col >= placement_x + 50 AND pixel_col <= placement_x + 55 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x + 50 AND pixel_col <= placement_x + 80 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y - 35) OR
            (pixel_col >= placement_x + 50 AND pixel_col <= placement_x + 80 AND
             pixel_row >= placement_y AND pixel_row <= placement_y + 5) OR
            (pixel_col >= placement_x + 50 AND pixel_col <= placement_x + 80 AND
             pixel_row >= placement_y + 35 AND pixel_row <= placement_y + 40)) THEN
            letters_paused <= '1';
        END IF;


        -- D
        IF ((pixel_col >= placement_x + 100 AND pixel_col <= placement_x + 105 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x + 100 AND pixel_col <= placement_x + 125 AND
             pixel_row >= placement_y - 40 AND pixel_row <= placement_y - 35) OR
            (pixel_col >= placement_x + 100 AND pixel_col <= placement_x + 125 AND
             pixel_row >= placement_y + 35 AND pixel_row <= placement_y + 40) OR
            (pixel_col >= placement_x + 125 AND pixel_col <= placement_x + 130 AND
             pixel_row >= placement_y - 35 AND pixel_row <= placement_y + 35)) THEN
            letters_paused <= '1';
        END IF;

    END IF;

    letters_on <= letters_paused;
                
    END PROCESS;
    
END Behavioral;