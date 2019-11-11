LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY exp8visto2 IS
  PORT (
    clock : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    T60 : OUT STD_LOGIC;
    T20 : OUT STD_LOGIC;
    T6 : OUT STD_LOGIC;
    T5 : OUT STD_LOGIC;
    num7seg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    displays : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END exp8visto2;

ARCHITECTURE exp8visto2_arch OF exp8visto2 IS
  COMPONENT contador100 IS
    PORT (
      clock : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      load : IN STD_LOGIC;
      dezload : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      uniload : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      dezena : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      unidade : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
  END COMPONENT;

  COMPONENT convbinario7seg is
    port( numbinario : in STD_LOGIC_VECTOR(3 downto 0);
          num7seg : out STD_LOGIC_VECTOR(7 downto 0) );
  end COMPONENT;

  COMPONENT mostrador IS
    PORT (
      num7seg3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      num7seg2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      num7seg1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      num7seg0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      clock50Mhz : IN STD_LOGIC; --clock da placa
      num7seg : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --digito a ser mostrado
      displays : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)); --seletor de mostrador
  END COMPONENT;

  COMPONENT timeflags IS
    PORT (
      dezena : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      unidade : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      T60 : OUT STD_LOGIC;
      T20 : OUT STD_LOGIC;
      T6 : OUT STD_LOGIC;
      T5 : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL enableContador, loadContador : STD_LOGIC;
  SIGNAL dezloadContador, uniloadContador, dezena, unidade : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL num7Seg1, num7Seg2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL num7seg3Mostrador, num7seg0Mostrador : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
  enableContador <= '0';
  loadContador <= '0';
  dezloadContador <= "0000";
  uniloadContador <= "0000";
  num7seg3Mostrador <= "11111111";
  num7seg0Mostrador <= "11111111";

  U0 : contador100 PORT MAP(clock, reset, enableContador, loadContador, dezloadContador, uniloadContador, dezena, unidade);
  U1 : convbinario7seg PORT MAP(dezena, num7Seg1);
  U2 : convbinario7seg PORT MAP(unidade, num7Seg2);
  U3 : mostrador PORT MAP(num7seg3Mostrador, num7Seg1, num7Seg2, num7seg0Mostrador, clock, num7seg, displays);
  U4 : timeflags PORT MAP(dezena, unidade, T60, T20, T6, T5);

END exp8visto2_arch;