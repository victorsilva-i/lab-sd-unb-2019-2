library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mostrador is
  port( num7seg3 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg2 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg1 : in STD_LOGIC_VECTOR(7 downto 0);
        num7seg0 : in STD_LOGIC_VECTOR(7 downto 0);
        clock50Mhz : in STD_LOGIC; --clock da placa
        num7seg : out STD_LOGIC_VECTOR(7 downto 0);  --digito a ser mostrado
        displays : out STD_LOGIC_VECTOR(3 downto 0)); --seletor de mostrador
end mostrador;

architecture mostrador_arch of mostrador is
  signal cntDiv: STD_LOGIC_VECTOR(16 downto 0); -- general clock div/cnt
  type state_type is (ST0,ST1,ST2,ST3);
  signal currentstate,nextstate : state_type;
  signal slowclock : STD_LOGIC;
begin

  slowclock <= cntDiv(16);  -- divided clock: 50MHz/2^17 = 381.47 Hz

  --Divisor do Clock
  ckDivider: process(clock50Mhz)
  begin
    if rising_edge(clock50Mhz) then
      cntDiv <= cntDiv + '1';
    end if;
  end process ckDivider;
	
  --Processo de sincronização
  sync_proc: process(slowclock)
  begin
    if rising_edge(slowclock) then
      currentstate <= nextstate;			
    end if;
  end process sync_proc;
 
  --Lógica de estado seguinte
  comb_proc: process(currentstate,num7seg0,num7seg1,num7seg2,num7seg3)
  begin
    case currentstate is
      when ST0 =>
        num7seg <= num7seg0;
        displays <= "1110"; -- seleciona mostrador AN0
        nextstate <= ST1;
      when ST1 =>
        num7seg <= num7seg1;
        displays <= "1101"; -- seleciona mostrador AN1
        nextstate <= ST2; 
      when ST2 =>
        num7seg <= num7seg2;
        displays <= "1011"; -- seleciona mostrador AN2
        nextstate <= ST3;
      when ST3 =>
        num7seg <= num7seg3;
        displays <= "0111"; -- seleciona mostrador AN3
        nextstate <= ST0; 
      when others =>
        num7seg <= num7seg0;
        displays <= "1110"; -- seleciona mostrador AN0
        nextstate <= ST1;	
    end case;
  end process comb_proc;

end mostrador_arch;
