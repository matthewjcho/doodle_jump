LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY win_screen IS
    PORT (
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        win_state : IN STD_LOGIC;
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END win_screen;

ARCHITECTURE Behavioral OF win_screen IS
    SIGNAL letters_you, letters_win, exclamation_on : STD_LOGIC;
    SIGNAL letters_on : STD_LOGIC;
    
BEGIN
    red <= '0';
    green <= letters_on;
    blue <= '0';
    
    display_win : PROCESS(pixel_row, pixel_col, win_state)
    BEGIN
        letters_you <= '0';
        letters_win <= '0';
        exclamation_on  <= '0';

        IF (win_state = '1') THEN

            -- "YOU"
            -- Y
            IF (((pixel_col >= 250 AND pixel_col <= 260) AND
                 (pixel_row >= 200 AND pixel_row <= 240)) OR
                ((pixel_col >= 290 AND pixel_col <= 300) AND
                 (pixel_row >= 200 AND pixel_row <= 240)) OR
                ((pixel_col >= 270 AND pixel_col <= 280) AND
                 (pixel_row >= 240 AND pixel_row <= 280))) THEN
                 
                letters_you <= '1';

            -- O
            ELSIF (((pixel_col >= 330 AND pixel_col <= 340) AND
                 (pixel_row >= 200 AND pixel_row <= 280)) OR
                ((pixel_col >= 370 AND pixel_col <= 380) AND
                 (pixel_row >= 200 AND pixel_row <= 280)) OR
                ((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 200 AND pixel_row <= 210)) OR
                ((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 270 AND pixel_row <= 280))) THEN
                 
                letters_you <= '1';

            -- U
            ELSIF (((pixel_col >= 410 AND pixel_col <= 420) AND
                 (pixel_row >= 200 AND pixel_row <= 280)) OR
                ((pixel_col >= 450 AND pixel_col <= 460) AND
                 (pixel_row >= 200 AND pixel_row <= 280)) OR
                ((pixel_col >= 410 AND pixel_col <= 460) AND
                 (pixel_row >= 270 AND pixel_row <= 280))) THEN
                 
                letters_you <= '1';
            END IF;


            -- "WIN"
            -- W
            IF (((pixel_col >= 230 AND pixel_col <= 240) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 290 AND pixel_col <= 300) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 250 AND pixel_col <= 260) AND
                 (pixel_row >= 370 AND pixel_row <= 410)) OR
                ((pixel_col >= 270 AND pixel_col <= 280) AND
                 (pixel_row >= 370 AND pixel_row <= 410))) THEN
               
                letters_win <= '1';

            -- I
            ELSIF (((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 330 AND pixel_row <= 340)) OR
                ((pixel_col >= 350 AND pixel_col <= 360) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 400 AND pixel_row <= 410))) THEN
                 
                letters_win <= '1';

            -- N
            ELSIF (((pixel_col >= 410 AND pixel_col <= 420) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 460 AND pixel_col <= 470) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 430 AND pixel_col <= 440) AND
                 (pixel_row >= 350 AND pixel_row <= 370)) OR
                ((pixel_col >= 440 AND pixel_col <= 450) AND
                 (pixel_row >= 370 AND pixel_row <= 390))) THEN
                
                letters_win <= '1';
            END IF;

            
            -- "!"
            IF (((pixel_col >= 510 AND pixel_col <= 520) AND 
                (pixel_row >= 330 AND pixel_row <= 385)) OR
                ((pixel_col >= 510 AND pixel_col <= 520) AND 
                (pixel_row >= 400 AND pixel_row <= 410))) THEN
                
                exclamation_on <= '1';
            END IF;

        END IF;
            
        letters_on <= letters_you OR letters_win OR exclamation_on;
        
    END PROCESS;


END Behavioral;
