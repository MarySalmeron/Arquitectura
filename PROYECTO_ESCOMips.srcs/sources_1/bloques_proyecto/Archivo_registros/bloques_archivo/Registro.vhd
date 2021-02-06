library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro is
    Port ( d : in STD_LOGIC_VECTOR (15 downto 0);
           clr,clk,l : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0));
end Registro;

architecture Behavioral of Registro is

begin

process(clk,clr)
    begin
        if (clr ='1') then
            q <= (others=>'0');
        elsif rising_edge(clk) then
            if(l='1') then
                q <= d;
            end if;
        end if;
    end process;

end Behavioral;
