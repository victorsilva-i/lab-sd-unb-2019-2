library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maqestados is
  port( clock : in STD_LOGIC;
        ligadesliga : in STD_LOGIC;
        sensorA : in STD_LOGIC;
        sensorB : in STD_LOGIC;
        T60 : in STD_LOGIC;
        T20 : in STD_LOGIC;
        T6 : in STD_LOGIC;
        T5 : in STD_LOGIC;
        resetcounter : out STD_LOGIC;
        RYGsemaforoA : out STD_LOGIC_VECTOR(2 downto 0);
        RYGsemaforoB : out STD_LOGIC_VECTOR(2 downto 0) );
end maqestados;

architecture maqestados_arch of maqestados is
  -- inserir sinais e componentes aqui 
begin

  -- inserir implementacao aqui 

end maqestados_arch;



