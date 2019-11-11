LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY convsemaforo7seg IS
  PORT (
    RYGsemaforo : int STD_LOGIC_VECTOR (2 DOWNTO 0);
    Num7seg : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END convsemaforo7seg;
ARCHITECTURE convsemaforo7seg_arch OF convsemaforo7seg IS BEGIN
  WITH RYGsemaforo SELECT
    Num7seg <= “01111111” WHEN “100”,
    <= “11111101” WHEN “010”,
    <= “11101111” WHEN “001”, <= “11111111” WHEN OTHERS;
END convsemaforo7seg_arch;