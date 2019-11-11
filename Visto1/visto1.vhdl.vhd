library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exp8visto1 is
  port( clock : in STD_LOGIC;
        reset : in STD_LOGIC;        
        enable : in STD_LOGIC;
        load : in STD_LOGIC;
        dezload : in STD_LOGIC_VECTOR(3 downto 0);
        uniload : in STD_LOGIC_VECTOR(3 downto 0);
        dezena : out STD_LOGIC_VECTOR(3 downto 0);
        unidade : out STD_LOGIC_VECTOR(3 downto 0) );
end exp8visto1;

architecture exp8visto1_arch of exp8visto1 is
component cont10 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           rci : in  STD_LOGIC;
           load : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           rco : out  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (3 downto 0));
end component; 

component divclock is
  port( clock50MHz : in STD_LOGIC;
        clock1Hz : out STD_LOGIC );
end component;

signal rcs, clock1, z: STD_LOGIC;

begin

U1: divclock port map (clock, clock1);

U2: cont10 port map (clock1, reset, enable, '0', load, uniload, rcs, unidade);

U3: cont10 port map (clock1, reset, enable, rcs, load, dezload, z ,dezena);


end exp8visto1_arch;