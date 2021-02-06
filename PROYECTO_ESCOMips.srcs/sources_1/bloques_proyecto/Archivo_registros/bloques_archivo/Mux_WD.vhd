library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_WD is
    Port ( WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           respuesta : in STD_LOGIC_VECTOR (15 downto 0);
           SHE : in STD_LOGIC;
           dato : out STD_LOGIC_VECTOR (15 downto 0));
end Mux_WD;

architecture Behavioral of Mux_WD is

begin

with SHE select
    dato <= WriteData when '0',
            respuesta when others;

end Behavioral;
