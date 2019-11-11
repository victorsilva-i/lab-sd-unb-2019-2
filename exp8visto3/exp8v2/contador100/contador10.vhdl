LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY contador10 IS
    PORT (
        clock : IN STD - LOGIC;
        Reset : IN STD - LOGIC;
        Enable : IN STD - LOGIC;
        Rci : IN STD - LOGIC;
        Load : IN STD - LOGIC;
        D : IN STD - LOGIC_VECTOR (3 DOWNTO 0);
        Q : OUT STD - LOGIC_VECTOR (3 DOWNTO 0);
        rco : OUT STD - LOGIC);
END contador10;
ARCHITECTURE contator10_arch OF contador10 IS
    TYPE estado IS (ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9);
    SIGNAL currentState, nextState, loadState : estado;
BEGIN
    WITH D SELECT
        loadState <= ST0 WHEN “0000”,
        ST1 WHEN “0001”, ST2 WHEN “0010”, ST3 WHEN “0011”, ST4 WHEN “0100”, ST5 WHEN “0101”, ST6 WHEN “0110”,
        ST7 WHEN “0111”, ST8 WHEN “1000”, ST9 WHEN “1001”,
        ST0 WHEN OTHERS;
    sync_proc : PROCESS (clock)
    BEGIN
        IF rising_edge (clock) THEN
            currentState <= nextState;
        END IF;
    END PROCESS sync_proc;
    comb_proc : PROCESS (currentState, reset, enable, rci, load, loadState) BEGIN
        CASE currentState IS WHEN ST0 =>
                Q <= “0000”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST1;
                ELSE
                    nextState <= ST0;
                END IF;
            WHEN ST1 =>
                Q <= “0001”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST2;
                ELSE
                    nextState <= ST1;
                END IF;
            WHEN ST2 =>
                Q <= “0010”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST3;
                ELSE
                    nextState <= ST2;
                END IF;

            WHEN ST3 =>
                Q <= “0011”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST4;
                ELSE
                    nextState <= ST3;
                END IF;
            WHEN ST4 =>
                Q <= “0100”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST5;
                ELSE
                    nextState <= ST4;
                END IF;
            WHEN ST5 =>
                Q <= “0101”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST6;
                ELSE
                    nextState <= ST5;
                END IF;
            WHEN ST6 =>
                Q <= “0110”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST7;
                ELSE
                    nextState <= ST6;
                END IF;
            WHEN ST7 =>
                Q <= “0111”;

                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST8;
                ELSE
                    nextState <= ST7;
                END IF;
            WHEN ST8 =>
                Q <= “1000”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST9;
                ELSE
                    nextState <= ST8;
                END IF;
            WHEN ST9 =>
                Q <= “1001”;
                Rco <= ‘0’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST0;
                ELSE
                    nextState <= ST9;
                END IF;
            WHEN OTHERS => Q <= “0000”;
                Rco <= ‘1’;
                IF (reset = ‘1’) THEN
                    nextState <= ST0;
                ELSIF (load = ‘1’) THEN
                    nextState <= loadState;
                ELSIF ((enable = ‘0’) AND (rci = ‘0’)) THEN
                    nextState <= ST1;
                ELSE
                    nextState <= ST0;
                END IF;
        END CASE;
    END PROCESS comb_proc;
END contator10_arch;