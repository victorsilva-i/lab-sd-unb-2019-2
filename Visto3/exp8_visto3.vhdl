
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exp8visto3 is
  port( clock : in STD_LOGIC;
        LD : in STD_LOGIC;        
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        num7seg : out STD_LOGIC_VECTOR(7 downto 0);
        displays : out STD_LOGIC_VECTOR(3 downto 0) );
end exp8visto3;

architecture exp8visto3_arch of exp8visto3 is

component divclock is  
        port( clock50MHz : in STD_LOGIC;
        clock1Hz : out STD_LOGIC );
end component;
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

component timeflags is  
        port( dezena : in STD_LOGIC_VECTOR(3 downto 0);
        unidade : in STD_LOGIC_VECTOR(3 downto 0);
        T60 : out STD_LOGIC;
        T20 : out STD_LOGIC;
        T6 : out STD_LOGIC;
        T5 : out STD_LOGIC );
end component;
component maquina is
         port( CLK, LD, A, B, T5, T6, T20, T60 : in STD_LOGIC;
         RYGsemaforoA, RYGsemaforoB: out STD_LOGIC_VECTOR(2 downto 0);
         Resetcontador: out STD_LOGIC);
end component;
component convbinario7seg is
        port( numbinario : in STD_LOGIC_VECTOR(3 downto 0);
        num7seg : out STD_LOGIC_VECTOR(7 downto 0) );
end component; 
component convsemaforo7seg is
        port(numbinario: in STD_LOGIC_VECTOR(2 downto 0);
	   num7seg: out STD_LOGIC_VECTOR(7 downto 0));
end component;
component mostrador is
  port( num7seg3 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg2 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg1 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg0 : in STD_LOGIC_VECTOR(7 downto 0);
        clock50Mhz : in STD_LOGIC; --clock da placa
        num7seg : out STD_LOGIC_VECTOR(7 downto 0);  --digito a ser mostrado
        displays : out STD_LOGIC_VECTOR(3 downto 0)); --seletor de mostrador
end component;

signal resetcont, rcs, clock1, z, T60, T20, T6, T5: STD_LOGIC;

signal dezena, unidade: STD_LOGIC_VECTOR(3 downto 0);
signal RYGA, RYGB: STD_LOGIC_VECTOR(2 downto 0);
signal num7seg_uni, num7seg_dez, RYGA_1, RYGB_1: STD_LOGIC_VECTOR(7downto 0);

begin

U1: divclock port map (clock, clock1);


U2: cont10 port map (clock1, resetcont, '0', '0', '0', x"0", rcs, unidade);


U3: cont10 port map (clock1, resetcont, '0', rcs, '0', x"0", z ,dezena);


U4: timeflags port map (dezena, unidade, T60, T20, T6, T5); 


U5: maquina port map (clock1, LD, A, B, T5, T6, T20, T60, RYGA, RYGB, resetcont);


U6: convbinario7seg port map (unidade, num7seg_uni);


U7: convbinario7seg port map (dezena, num7seg_dez);


U8: convsemaforo7seg port map (RYGA, RYGA_1);


U9: convsemaforo7seg port map (RYGB, RYGB_1);


U10: mostrador port map (RYGA_1, num7seg_dez, num7seg_uni, RYGB_1, clock, num7seg, displays);


end exp8visto3_arch;