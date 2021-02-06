library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bloqCondicion is
    Port ( Q : in STD_LOGIC_VECTOR (3 downto 0);  --orden de banderas (OV,N,Z,C)
           cond_salida : out STD_LOGIC_VECTOR (5 downto 0)); --orden de los saltos condicionales (BEQI,BNEI,BLTI,BLETI,BGTI,BGETI)
end bloqCondicion;

architecture Behavioral of bloqCondicion is

begin

cond_salida(5) <= Q(1);
cond_salida(4) <= not Q(1);
cond_salida(3) <= not Q(0);
cond_salida(2) <= Q(1) or (not Q(0));
cond_salida(1) <= Q(0) and (not Q(1));
cond_salida(0) <= Q(0);

end Behavioral;
