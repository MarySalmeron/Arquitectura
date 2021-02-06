library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity extensores is
    Port ( s_inst : in STD_LOGIC_VECTOR (11 downto 0);
           signo,direccion : out STD_LOGIC_VECTOR (15 downto 0));
end extensores;

architecture Behavioral of extensores is

begin

process(s_inst)
begin
    if(s_inst(11) = '1') then
        signo <= "1111" & s_inst;
    else 
        signo <= "0000" & s_inst;
    end if;
    direccion <= "0000" & s_inst;
end process;

end Behavioral;
