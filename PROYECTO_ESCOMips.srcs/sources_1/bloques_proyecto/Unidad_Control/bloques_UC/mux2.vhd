library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( funCode : in STD_LOGIC_VECTOR (19 downto 0);
           opCode : in STD_LOGIC_VECTOR (19 downto 0);
           SM : in STD_LOGIC;
           salmux2 : out STD_LOGIC_VECTOR (19 downto 0));
end mux2;

architecture Behavioral of mux2 is

begin

salmux2 <= funCode when (SM = '0') else
            opCode;

end Behavioral;
