LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY timeflags IS
  PORT (
    dezena : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    unidade : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    T60 : OUT STD_LOGIC;
    T20 : OUT STD_LOGIC;
    T6 : OUT STD_LOGIC;
    T5 : OUT STD_LOGIC);
END timeflags;

ARCHITECTURE timeflags_arch OF timeflags IS
BEGIN
  T5 <= '1' WHEN (unidade >= x"5") ELSE
    '0';
  T6 <= '1' WHEN (unidade >= x"6") ELSE
    '0';
  T20 <= '1' WHEN (dezena >= x"2") ELSE
    '0';
  T60 <= '1' WHEN (dezena >= x"6") ELSE
    '0';

END timeflags_arch;