library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divclock is
  port( clock50MHz : in STD_LOGIC;
        clock1Hz : out STD_LOGIC );
end divclock;

architecture divclock_arch of divclock is
  signal cntDiv: STD_LOGIC_VECTOR(31 downto 0);
  signal slowclock : STD_LOGIC;
begin
  process(clock50Mhz)
  begin
    if rising_edge(clock50Mhz) then
      if cntDiv = x"017D_783F" then -- 24.999.999 em hexadecimal
        cntDiv <= x"0000_0000";
        slowclock <= not(slowclock);
      else
        cntDiv <= cntDiv + '1';
        slowclock <= slowclock;
      end if;
    end if;
  end process;
  clock1Hz <= slowclock;
end divclock_arch;