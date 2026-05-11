LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY idle_screen IS
    PORT (
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        idle_state : IN STD_LOGIC;
        red : OUT STD_LOGIC;
        green : OUT STD_LOGIC;
        blue : OUT STD_LOGIC
    );
END idle_screen;

ARCHITECTURE Behavioral OF idle_screen IS

    SIGNAL letters_doodle : STD_LOGIC := '0';
    SIGNAL letters_jump : STD_LOGIC := '0';
    SIGNAL letters_press_btn0 : STD_LOGIC := '0';
    SIGNAL letters_press_btnd : STD_LOGIC := '0';
    SIGNAL letters_on : STD_LOGIC := '0';

BEGIN

    red <= '0';
    green <= '0';
    blue <= letters_on;

    display_idle : PROCESS(pixel_row, pixel_col, idle_state)
    BEGIN
        letters_doodle <= '0';
        letters_jump <= '0';
        letters_press_btn0 <= '0';
        letters_press_btnd <= '0';

        IF idle_state = '1' THEN

            -- DOODLE
            -- D
            IF (((pixel_col >= 130 AND pixel_col <= 140) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 130 AND pixel_col <= 175) AND (pixel_row >= 100 AND pixel_row <= 110)) OR
                ((pixel_col >= 130 AND pixel_col <= 175) AND (pixel_row >= 160 AND pixel_row <= 170)) OR
                ((pixel_col >= 175 AND pixel_col <= 185) AND (pixel_row >= 110 AND pixel_row <= 160))) THEN

                letters_doodle <= '1';

            -- O
            ELSIF (((pixel_col >= 200 AND pixel_col <= 210) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 245 AND pixel_col <= 255) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 200 AND pixel_col <= 255) AND (pixel_row >= 100 AND pixel_row <= 110)) OR
                ((pixel_col >= 200 AND pixel_col <= 255) AND (pixel_row >= 160 AND pixel_row <= 170))) THEN

                letters_doodle <= '1';

            -- O
            ELSIF (((pixel_col >= 270 AND pixel_col <= 280) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 315 AND pixel_col <= 325) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 270 AND pixel_col <= 325) AND (pixel_row >= 100 AND pixel_row <= 110)) OR
                ((pixel_col >= 270 AND pixel_col <= 325) AND (pixel_row >= 160 AND pixel_row <= 170))) THEN

                letters_doodle <= '1';

            -- D
            ELSIF (((pixel_col >= 340 AND pixel_col <= 350) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 340 AND pixel_col <= 385) AND (pixel_row >= 100 AND pixel_row <= 110)) OR
                ((pixel_col >= 340 AND pixel_col <= 385) AND (pixel_row >= 160 AND pixel_row <= 170)) OR
                ((pixel_col >= 385 AND pixel_col <= 395) AND (pixel_row >= 110 AND pixel_row <= 160))) THEN

                letters_doodle <= '1';

            -- L
            ELSIF (((pixel_col >= 410 AND pixel_col <= 420) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 410 AND pixel_col <= 465) AND (pixel_row >= 160 AND pixel_row <= 170))) THEN

                letters_doodle <= '1';

            -- E
            ELSIF (((pixel_col >= 480 AND pixel_col <= 490) AND (pixel_row >= 100 AND pixel_row <= 170)) OR
                ((pixel_col >= 480 AND pixel_col <= 535) AND (pixel_row >= 100 AND pixel_row <= 110)) OR
                ((pixel_col >= 480 AND pixel_col <= 525) AND (pixel_row >= 130 AND pixel_row <= 140)) OR
                ((pixel_col >= 480 AND pixel_col <= 535) AND (pixel_row >= 160 AND pixel_row <= 170))) THEN

                letters_doodle <= '1';
            END IF;


            --JUMP
            -- J
            IF (((pixel_col >= 265 AND pixel_col <= 330) AND (pixel_row >= 190 AND pixel_row <= 200)) OR
                ((pixel_col >= 295 AND pixel_col <= 305) AND (pixel_row >= 190 AND pixel_row <= 250)) OR
                ((pixel_col >= 250 AND pixel_col <= 305) AND (pixel_row >= 250 AND pixel_row <= 260)) OR
                ((pixel_col >= 250 AND pixel_col <= 260) AND (pixel_row >= 230 AND pixel_row <= 250))) THEN

                letters_jump <= '1';

            -- U
            ELSIF (((pixel_col >= 345 AND pixel_col <= 355) AND (pixel_row >= 190 AND pixel_row <= 260)) OR
                ((pixel_col >= 390 AND pixel_col <= 400) AND (pixel_row >= 190 AND pixel_row <= 260)) OR
                ((pixel_col >= 345 AND pixel_col <= 400) AND (pixel_row >= 250 AND pixel_row <= 260))) THEN

                letters_jump <= '1';

            -- M
            ELSIF (((pixel_col >= 415 AND pixel_col <= 425) AND (pixel_row >= 190 AND pixel_row <= 260)) OR
                ((pixel_col >= 470 AND pixel_col <= 480) AND (pixel_row >= 190 AND pixel_row <= 260)) OR
                ((pixel_col >= 430 AND pixel_col <= 440) AND (pixel_row >= 200 AND pixel_row <= 225)) OR
                ((pixel_col >= 445 AND pixel_col <= 455) AND (pixel_row >= 215 AND pixel_row <= 240)) OR
                ((pixel_col >= 455 AND pixel_col <= 465) AND (pixel_row >= 200 AND pixel_row <= 225))) THEN

                letters_jump <= '1';

            -- P
            ELSIF (((pixel_col >= 495 AND pixel_col <= 505) AND (pixel_row >= 190 AND pixel_row <= 260)) OR
                ((pixel_col >= 495 AND pixel_col <= 550) AND (pixel_row >= 190 AND pixel_row <= 200)) OR
                ((pixel_col >= 495 AND pixel_col <= 550) AND (pixel_row >= 225 AND pixel_row <= 235)) OR
                ((pixel_col >= 540 AND pixel_col <= 550) AND (pixel_row >= 200 AND pixel_row <= 225))) THEN

                letters_jump <= '1';
            END IF;



            -- PRESS BTN0 TO START JUMPING
            
            IF (((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 82 AND pixel_col <= 85) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 86 AND pixel_col <= 89) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 90 AND pixel_col <= 93) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 94 AND pixel_col <= 97) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 94 AND pixel_col <= 97) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 82 AND pixel_col <= 85) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 86 AND pixel_col <= 89) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 90 AND pixel_col <= 93) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 78 AND pixel_col <= 81) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 106 AND pixel_col <= 109) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 110 AND pixel_col <= 113) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 114 AND pixel_col <= 117) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 118 AND pixel_col <= 121) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 118 AND pixel_col <= 121) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 106 AND pixel_col <= 109) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 110 AND pixel_col <= 113) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 114 AND pixel_col <= 117) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 110 AND pixel_col <= 113) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 114 AND pixel_col <= 117) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 102 AND pixel_col <= 105) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 118 AND pixel_col <= 121) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 130 AND pixel_col <= 133) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 134 AND pixel_col <= 137) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 138 AND pixel_col <= 141) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 142 AND pixel_col <= 145) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 130 AND pixel_col <= 133) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 134 AND pixel_col <= 137) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 138 AND pixel_col <= 141) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 126 AND pixel_col <= 129) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 130 AND pixel_col <= 133) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 134 AND pixel_col <= 137) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 138 AND pixel_col <= 141) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 142 AND pixel_col <= 145) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 154 AND pixel_col <= 157) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 158 AND pixel_col <= 161) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 162 AND pixel_col <= 165) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 166 AND pixel_col <= 169) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 150 AND pixel_col <= 153) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 150 AND pixel_col <= 153) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 154 AND pixel_col <= 157) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 158 AND pixel_col <= 161) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 162 AND pixel_col <= 165) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 166 AND pixel_col <= 169) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 166 AND pixel_col <= 169) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 150 AND pixel_col <= 153) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 154 AND pixel_col <= 157) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 158 AND pixel_col <= 161) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 162 AND pixel_col <= 165) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 178 AND pixel_col <= 181) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 182 AND pixel_col <= 185) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 186 AND pixel_col <= 189) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 190 AND pixel_col <= 193) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 178 AND pixel_col <= 181) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 182 AND pixel_col <= 185) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 186 AND pixel_col <= 189) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 190 AND pixel_col <= 193) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 190 AND pixel_col <= 193) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 178 AND pixel_col <= 181) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 182 AND pixel_col <= 185) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 186 AND pixel_col <= 189) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 246 AND pixel_col <= 249) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 250 AND pixel_col <= 253) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 258 AND pixel_col <= 261) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 262 AND pixel_col <= 265) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 274 AND pixel_col <= 277) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 278 AND pixel_col <= 281) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 282 AND pixel_col <= 285) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 298 AND pixel_col <= 301) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 302 AND pixel_col <= 305) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 306 AND pixel_col <= 309) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 294 AND pixel_col <= 297) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 310 AND pixel_col <= 313) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 294 AND pixel_col <= 297) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 306 AND pixel_col <= 309) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 310 AND pixel_col <= 313) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 294 AND pixel_col <= 297) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 302 AND pixel_col <= 305) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 310 AND pixel_col <= 313) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 294 AND pixel_col <= 297) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 298 AND pixel_col <= 301) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 310 AND pixel_col <= 313) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 294 AND pixel_col <= 297) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 310 AND pixel_col <= 313) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 298 AND pixel_col <= 301) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 302 AND pixel_col <= 305) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 306 AND pixel_col <= 309) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 342 AND pixel_col <= 345) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 346 AND pixel_col <= 349) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 354 AND pixel_col <= 357) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 358 AND pixel_col <= 361) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 370 AND pixel_col <= 373) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 374 AND pixel_col <= 377) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 378 AND pixel_col <= 381) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 370 AND pixel_col <= 373) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 374 AND pixel_col <= 377) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 378 AND pixel_col <= 381) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 418 AND pixel_col <= 421) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 422 AND pixel_col <= 425) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 426 AND pixel_col <= 429) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 430 AND pixel_col <= 433) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 414 AND pixel_col <= 417) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 414 AND pixel_col <= 417) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 418 AND pixel_col <= 421) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 422 AND pixel_col <= 425) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 426 AND pixel_col <= 429) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 430 AND pixel_col <= 433) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 430 AND pixel_col <= 433) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 414 AND pixel_col <= 417) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 418 AND pixel_col <= 421) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 422 AND pixel_col <= 425) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 426 AND pixel_col <= 429) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 438 AND pixel_col <= 441) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 442 AND pixel_col <= 445) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 450 AND pixel_col <= 453) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 454 AND pixel_col <= 457) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 466 AND pixel_col <= 469) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 470 AND pixel_col <= 473) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 474 AND pixel_col <= 477) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 466 AND pixel_col <= 469) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 470 AND pixel_col <= 473) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 474 AND pixel_col <= 477) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 490 AND pixel_col <= 493) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 494 AND pixel_col <= 497) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 498 AND pixel_col <= 501) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 502 AND pixel_col <= 505) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 502 AND pixel_col <= 505) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 490 AND pixel_col <= 493) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 494 AND pixel_col <= 497) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 498 AND pixel_col <= 501) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 494 AND pixel_col <= 497) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 498 AND pixel_col <= 501) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 486 AND pixel_col <= 489) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 502 AND pixel_col <= 505) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 514 AND pixel_col <= 517) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 522 AND pixel_col <= 525) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 526 AND pixel_col <= 529) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 562 AND pixel_col <= 565) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 566 AND pixel_col <= 569) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 574 AND pixel_col <= 577) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 562 AND pixel_col <= 565) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 566 AND pixel_col <= 569) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 586 AND pixel_col <= 589) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 590 AND pixel_col <= 593) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 594 AND pixel_col <= 597) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 610 AND pixel_col <= 613) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 618 AND pixel_col <= 621) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 634 AND pixel_col <= 637) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 638 AND pixel_col <= 641) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 642 AND pixel_col <= 645) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 646 AND pixel_col <= 649) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 646 AND pixel_col <= 649) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 634 AND pixel_col <= 637) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 638 AND pixel_col <= 641) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 642 AND pixel_col <= 645) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 630 AND pixel_col <= 633) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 654 AND pixel_col <= 657) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 658 AND pixel_col <= 661) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 666 AND pixel_col <= 669) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 670 AND pixel_col <= 673) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 654 AND pixel_col <= 657) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 658 AND pixel_col <= 661) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 662 AND pixel_col <= 665) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 666 AND pixel_col <= 669) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 670 AND pixel_col <= 673) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 682 AND pixel_col <= 685) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 686 AND pixel_col <= 689) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 690 AND pixel_col <= 693) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 678 AND pixel_col <= 681) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 694 AND pixel_col <= 697) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 706 AND pixel_col <= 709) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 710 AND pixel_col <= 713) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 714 AND pixel_col <= 717) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 718 AND pixel_col <= 721) AND (pixel_row >= 320 AND pixel_row <= 323)) OR
                ((pixel_col >= 702 AND pixel_col <= 705) AND (pixel_row >= 324 AND pixel_row <= 327)) OR
                ((pixel_col >= 702 AND pixel_col <= 705) AND (pixel_row >= 328 AND pixel_row <= 331)) OR
                ((pixel_col >= 702 AND pixel_col <= 705) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 710 AND pixel_col <= 713) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 714 AND pixel_col <= 717) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 718 AND pixel_col <= 721) AND (pixel_row >= 332 AND pixel_row <= 335)) OR
                ((pixel_col >= 702 AND pixel_col <= 705) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 718 AND pixel_col <= 721) AND (pixel_row >= 336 AND pixel_row <= 339)) OR
                ((pixel_col >= 702 AND pixel_col <= 705) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 718 AND pixel_col <= 721) AND (pixel_row >= 340 AND pixel_row <= 343)) OR
                ((pixel_col >= 706 AND pixel_col <= 709) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 710 AND pixel_col <= 713) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 714 AND pixel_col <= 717) AND (pixel_row >= 344 AND pixel_row <= 347)) OR
                ((pixel_col >= 718 AND pixel_col <= 721) AND (pixel_row >= 344 AND pixel_row <= 347))) THEN
                
                letters_press_btn0 <= '1';
            END IF;


            -- PRESS BTND TO RESET

            IF (((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 178 AND pixel_col <= 181) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 182 AND pixel_col <= 185) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 186 AND pixel_col <= 189) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 190 AND pixel_col <= 193) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 190 AND pixel_col <= 193) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 178 AND pixel_col <= 181) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 182 AND pixel_col <= 185) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 186 AND pixel_col <= 189) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 174 AND pixel_col <= 177) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 202 AND pixel_col <= 205) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 206 AND pixel_col <= 209) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 210 AND pixel_col <= 213) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 214 AND pixel_col <= 217) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 214 AND pixel_col <= 217) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 202 AND pixel_col <= 205) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 206 AND pixel_col <= 209) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 210 AND pixel_col <= 213) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 206 AND pixel_col <= 209) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 210 AND pixel_col <= 213) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 198 AND pixel_col <= 201) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 214 AND pixel_col <= 217) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 222 AND pixel_col <= 225) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 226 AND pixel_col <= 229) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 230 AND pixel_col <= 233) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 234 AND pixel_col <= 237) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 238 AND pixel_col <= 241) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 250 AND pixel_col <= 253) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 258 AND pixel_col <= 261) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 262 AND pixel_col <= 265) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 246 AND pixel_col <= 249) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 246 AND pixel_col <= 249) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 250 AND pixel_col <= 253) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 258 AND pixel_col <= 261) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 262 AND pixel_col <= 265) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 262 AND pixel_col <= 265) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 246 AND pixel_col <= 249) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 250 AND pixel_col <= 253) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 254 AND pixel_col <= 257) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 258 AND pixel_col <= 261) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 274 AND pixel_col <= 277) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 278 AND pixel_col <= 281) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 282 AND pixel_col <= 285) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 274 AND pixel_col <= 277) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 278 AND pixel_col <= 281) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 282 AND pixel_col <= 285) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 286 AND pixel_col <= 289) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 270 AND pixel_col <= 273) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 274 AND pixel_col <= 277) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 278 AND pixel_col <= 281) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 282 AND pixel_col <= 285) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 322 AND pixel_col <= 325) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 326 AND pixel_col <= 329) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 330 AND pixel_col <= 333) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 334 AND pixel_col <= 337) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 334 AND pixel_col <= 337) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 322 AND pixel_col <= 325) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 326 AND pixel_col <= 329) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 330 AND pixel_col <= 333) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 334 AND pixel_col <= 337) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 334 AND pixel_col <= 337) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 318 AND pixel_col <= 321) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 322 AND pixel_col <= 325) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 326 AND pixel_col <= 329) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 330 AND pixel_col <= 333) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 342 AND pixel_col <= 345) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 346 AND pixel_col <= 349) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 354 AND pixel_col <= 357) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 358 AND pixel_col <= 361) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 350 AND pixel_col <= 353) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 370 AND pixel_col <= 373) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 374 AND pixel_col <= 377) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 378 AND pixel_col <= 381) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 366 AND pixel_col <= 369) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 382 AND pixel_col <= 385) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 394 AND pixel_col <= 397) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 398 AND pixel_col <= 401) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 402 AND pixel_col <= 405) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 406 AND pixel_col <= 409) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 406 AND pixel_col <= 409) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 406 AND pixel_col <= 409) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 406 AND pixel_col <= 409) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 406 AND pixel_col <= 409) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 390 AND pixel_col <= 393) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 394 AND pixel_col <= 397) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 398 AND pixel_col <= 401) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 402 AND pixel_col <= 405) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 438 AND pixel_col <= 441) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 442 AND pixel_col <= 445) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 450 AND pixel_col <= 453) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 454 AND pixel_col <= 457) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 446 AND pixel_col <= 449) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 466 AND pixel_col <= 469) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 470 AND pixel_col <= 473) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 474 AND pixel_col <= 477) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 462 AND pixel_col <= 465) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 478 AND pixel_col <= 481) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 466 AND pixel_col <= 469) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 470 AND pixel_col <= 473) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 474 AND pixel_col <= 477) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 514 AND pixel_col <= 517) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 522 AND pixel_col <= 525) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 526 AND pixel_col <= 529) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 526 AND pixel_col <= 529) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 514 AND pixel_col <= 517) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 522 AND pixel_col <= 525) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 518 AND pixel_col <= 521) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 522 AND pixel_col <= 525) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 510 AND pixel_col <= 513) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 526 AND pixel_col <= 529) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 538 AND pixel_col <= 541) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 542 AND pixel_col <= 545) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 546 AND pixel_col <= 549) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 550 AND pixel_col <= 553) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 538 AND pixel_col <= 541) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 542 AND pixel_col <= 545) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 546 AND pixel_col <= 549) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 534 AND pixel_col <= 537) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 538 AND pixel_col <= 541) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 542 AND pixel_col <= 545) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 546 AND pixel_col <= 549) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 550 AND pixel_col <= 553) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 562 AND pixel_col <= 565) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 566 AND pixel_col <= 569) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 574 AND pixel_col <= 577) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 562 AND pixel_col <= 565) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 566 AND pixel_col <= 569) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 574 AND pixel_col <= 577) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 574 AND pixel_col <= 577) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 558 AND pixel_col <= 561) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 562 AND pixel_col <= 565) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 566 AND pixel_col <= 569) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 570 AND pixel_col <= 573) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 586 AND pixel_col <= 589) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 590 AND pixel_col <= 593) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 594 AND pixel_col <= 597) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 586 AND pixel_col <= 589) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 590 AND pixel_col <= 593) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 594 AND pixel_col <= 597) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 582 AND pixel_col <= 585) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 586 AND pixel_col <= 589) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 590 AND pixel_col <= 593) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 594 AND pixel_col <= 597) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 598 AND pixel_col <= 601) AND (pixel_row >= 404 AND pixel_row <= 407)) OR
                ((pixel_col >= 606 AND pixel_col <= 609) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 610 AND pixel_col <= 613) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 618 AND pixel_col <= 621) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 622 AND pixel_col <= 625) AND (pixel_row >= 380 AND pixel_row <= 383)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 384 AND pixel_row <= 387)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 388 AND pixel_row <= 391)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 392 AND pixel_row <= 395)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 396 AND pixel_row <= 399)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 400 AND pixel_row <= 403)) OR
                ((pixel_col >= 614 AND pixel_col <= 617) AND (pixel_row >= 404 AND pixel_row <= 407))) THEN
                
                letters_press_btnd <= '1';
            END IF;

        END IF;

    END PROCESS display_idle;

    letters_on <= letters_doodle OR letters_jump OR letters_press_btn0 OR letters_press_btnd;

END Behavioral;
