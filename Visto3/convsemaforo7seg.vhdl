library ieee;
use ieee.std_logic_1164.all;

entity convsemaforo7seg is
	port(numbinario: in STD_LOGIC_VECTOR(2 downto 0);
	          num7seg: out STD_LOGIC_VECTOR(7 downto 0));
end convsemaforo7seg;

architecture convsemaforo7seg_arch of convsemaforo7seg is
begin
	with numbinario select
		num7seg <=   "01111111" when "100",
				"11111101" when "010",
				"11101111" when "001",
				"11111111" when others;
end convsemaforo7seg_arch;

library ieee;
use ieee.std_logic_1164.all;

entity maquina is
	port( CLK, LD, A, B, T5, T6, T20, T60 : in STD_LOGIC;
	          RYGsemaforoA, RYGsemaforoB: out STD_LOGIC_VECTOR(2 downto 0);
	          Resetcontador: out STD_LOGIC);
end maquina;

architecture m_arch of maquina is

	type estado is (GR, YR, RR1, RG, RY, RR2, YY, NN);

signal CurrentState, NextState : estado;

begin

sync_proc: process (CLK)
begin
	if rising_edge(CLK) then
		CurrentState <= NextState;
	end if;
end process sync_proc;

comb_proc: process(CurrentState, LD, A, B, T5, T6, T20, T60)
begin
	case CurrentState is
		when GR =>
			RYGsemaforoA <= "001";
			RYGsemaforoB <= "100";
			if ((T60= '1' and LD = '1') or (A= '0' and B= '1' and T20 = '1' and LD = '1')) then
				NextState <= YR;
				Resetcontador <= '1';
			elsif (LD = '0') then
				NextState <= YY;
				Resetcontador <= '1';
			else
				NextState <= GR;
				Resetcontador <= '0';
			end if;


		when YR =>
			RYGsemaforoA <= "010";
			RYGsemaforoB <= "100";
		if (T6= '1' and LD = '1') then
			NextState <= RR1;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= YR;
			Resetcontador <= '0';
		end if;


		when RR1 =>
			RYGsemaforoA <= "100";
			RYGsemaforoB <= "100";
		if (T5= '1' and LD = '1') then
			NextState <= RG;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= RR1;
			Resetcontador <= '0';
		end if;

		

		when RG =>
			RYGsemaforoA <= "100";
			RYGsemaforoB <= "001";
		if ((T60= '1' and LD = '1') or (A= '1' and B= '0' and T20 = '1' and LD= '1')) then
			NextState <= RY;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= RG;
			Resetcontador <= '0';
		end if;


		when RY =>
			RYGsemaforoA <= "100";
			RYGsemaforoB <= "010";
		if (T6= '1' and LD = '1') then
			NextState <= RR2;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= RY;
			Resetcontador <= '0';
		end if;


		when RR2 =>
			RYGsemaforoA <= "100";
			RYGsemaforoB <= "100";
		if (T5= '1' and LD = '1') then
			NextState <= GR;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= RR2;
			Resetcontador <= '0';
		end if;


		when YY =>
			RYGsemaforoA <= "010";
			RYGsemaforoB <= "010";
		if ( LD = '1') then
			NextState <= GR;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= NN;
			Resetcontador <= '1';
		else
			NextState <= YY;
			Resetcontador <= '1';
		end if;

		when NN =>
			RYGsemaforoA <= "000";
			RYGsemaforoB <= "000";
		if ( LD = '1' ) then
			NextState <= GR;
			Resetcontador <= '1';
		elsif (LD = '0') then
			NextState <= YY;
			Resetcontador <= '1';
		else
			NextState <= NN;
			Resetcontador <= '1';
		end if;

		when others =>
			RYGsemaforoA <= "000";
			RYGsemaforoB <= "000";
			NextState <= GR;
			Resetcontador <= '1';
			
	end case;
	
end process comb_proc;

end m_arch;