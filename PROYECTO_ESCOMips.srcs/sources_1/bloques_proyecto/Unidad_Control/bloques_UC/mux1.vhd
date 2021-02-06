library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1 is
    Port ( SDOPC : in STD_LOGIC;
           opCode,cero : in STD_LOGIC_VECTOR(4 downto 0);
           salmux1 : out STD_LOGIC_VECTOR(4 downto 0));
end mux1;

architecture Behavioral of mux1 is
begin
cero <= "00000";
salmux1 <= cero when (SDOPC = '0') else
            opCode;

end Behavioral;
