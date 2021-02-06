library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity banderas is
    Port ( clk,clr : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           LF : in STD_LOGIC);
end banderas;

architecture Behavioral of banderas is

begin

process(clk,clr)
begin
    if (clr ='1') then
        Q <= (others=>'0');
    elsif(falling_edge(clk)) then
        if(LF='1') then
            Q <= D;
        end if;
    end if;
end process;

end Behavioral;
