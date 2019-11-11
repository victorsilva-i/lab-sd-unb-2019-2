library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador100 is
  port( clock : in STD_LOGIC;
        reset : in STD_LOGIC;
        enable : in STD_LOGIC;
        load : in STD_LOGIC;
        dezload : in STD_LOGIC_VECTOR(3 downto 0);
        uniload : in STD_LOGIC_VECTOR(3 downto 0);
        dezena : out STD_LOGIC_VECTOR(3 downto 0);
        unidade : out STD_LOGIC_VECTOR(3 downto 0) );
end contador100;

architecture contador100_arch of contador100 is

component divclock is
  port( clock50MHz : in STD_LOGIC;
        clock1Hz : out STD_LOGIC );
end component;


component contador10 is
		port(
        clock : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Enable : IN STD_LOGIC;
        Rci : IN STD_LOGIC;
        Load : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        rco : OUT STD_LOGIC);
end component;

signal RC0_0, RC0_1, clock_2: STD_LOGIC;

begin
RC0_1 <= '0';

U0: divclock port map(clock, clock_2);
U1: contador10 port map(clock_2, reset, enable, '0',load,uniload, unidade, RC0_0);
U2: contador10 port map(clock_2, reset, enable, RC0_0,load,dezload, dezena, RC0_1);

end contador100_arch;


