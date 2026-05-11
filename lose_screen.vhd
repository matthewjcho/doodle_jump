LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY lose_screen IS
    PORT (
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        lose_state : IN STD_LOGIC;
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END lose_screen;

ARCHITECTURE Behavioral OF lose_screen IS
    SIGNAL placement_x : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL placmenet_y : STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL letters_you, letters_lose : STD_LOGIC;
    SIGNAL letters_on : STD_LOGIC;
    
BEGIN

    red <= letters_on;
    green <= '0';
    blue <= '0';

    display_lose : PROCESS(pixel_row, pixel_col, lose_state)
    BEGIN
    
        letters_you <= '0';
        letters_lose <= '0';
        
        IF (lose_state = '1') THEN
        
            -- YOU
            -- Y
            IF (((pixel_col >= 250 AND pixel_col <= 260) AND
                 (pixel_row >= 180 AND pixel_row <= 220)) OR
                ((pixel_col >= 290 AND pixel_col <= 300) AND
                 (pixel_row >= 180 AND pixel_row <= 220)) OR
                ((pixel_col >= 270 AND pixel_col <= 280) AND
                 (pixel_row >= 220 AND pixel_row <= 260))) THEN
                letters_you <= '1';

            -- O
            ELSIF (((pixel_col >= 330 AND pixel_col <= 340) AND
                 (pixel_row >= 180 AND pixel_row <= 260)) OR
                ((pixel_col >= 370 AND pixel_col <= 380) AND
                 (pixel_row >= 180 AND pixel_row <= 260)) OR
                ((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 180 AND pixel_row <= 190)) OR
                ((pixel_col >= 330 AND pixel_col <= 380) AND
                 (pixel_row >= 250 AND pixel_row <= 260))) THEN
                letters_you <= '1';

            -- U
            ELSIF (((pixel_col >= 410 AND pixel_col <= 420) AND
                 (pixel_row >= 180 AND pixel_row <= 260)) OR
                ((pixel_col >= 450 AND pixel_col <= 460) AND
                 (pixel_row >= 180 AND pixel_row <= 260)) OR
                ((pixel_col >= 410 AND pixel_col <= 460) AND
                 (pixel_row >= 250 AND pixel_row <= 260))) THEN
                 
                letters_you <= '1';
            END IF;


            -- "LOSE"
            -- L
            IF (((pixel_col >= 180 AND pixel_col <= 190) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 180 AND pixel_col <= 230) AND
                 (pixel_row >= 400 AND pixel_row <= 410))) THEN
                
                letters_lose <= '1';

            -- O
            ELSIF (((pixel_col >= 260 AND pixel_col <= 270) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 300 AND pixel_col <= 310) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 260 AND pixel_col <= 310) AND
                 (pixel_row >= 330 AND pixel_row <= 340)) OR
                ((pixel_col >= 260 AND pixel_col <= 310) AND
                 (pixel_row >= 400 AND pixel_row <= 410))) THEN
                
                letters_lose <= '1';

            -- S
            ELSIF (((pixel_col >= 340 AND pixel_col <= 390) AND
                 (pixel_row >= 330 AND pixel_row <= 340)) OR
                ((pixel_col >= 340 AND pixel_col <= 350) AND
                 (pixel_row >= 330 AND pixel_row <= 370)) OR
                ((pixel_col >= 340 AND pixel_col <= 390) AND
                 (pixel_row >= 365 AND pixel_row <= 375)) OR
                ((pixel_col >= 380 AND pixel_col <= 390) AND
                 (pixel_row >= 370 AND pixel_row <= 410)) OR
                ((pixel_col >= 340 AND pixel_col <= 390) AND
                 (pixel_row >= 400 AND pixel_row <= 410))) THEN
                
                letters_lose <= '1';

            -- E
            ELSIF (((pixel_col >= 420 AND pixel_col <= 430) AND
                 (pixel_row >= 330 AND pixel_row <= 410)) OR
                ((pixel_col >= 420 AND pixel_col <= 470) AND
                 (pixel_row >= 330 AND pixel_row <= 340)) OR
                ((pixel_col >= 420 AND pixel_col <= 460) AND
                 (pixel_row >= 365 AND pixel_row <= 375)) OR
                ((pixel_col >= 420 AND pixel_col <= 470) AND
                 (pixel_row >= 400 AND pixel_row <= 410))) THEN
                
                letters_lose <= '1';
            END IF;
        
        END IF;
        
        letters_on <= letters_you OR letters_lose;
    
    END PROCESS;
       
END Behavioral;
