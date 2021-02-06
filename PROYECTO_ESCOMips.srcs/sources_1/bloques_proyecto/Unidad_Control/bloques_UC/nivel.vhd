library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nivel is
    Port ( clk,clr : in STD_LOGIC;
           na : out STD_LOGIC);
end nivel;

architecture Behavioral of nivel is
signal nclk,pclk: std_logic;
begin

process(clr,clk)
begin
    if(clr = '1') then
        pclk <= '0';
    elsif(rising_edge(clk)) then
        pclk <= not pclk;
    end if;
end process;

process(clr,clk)
begin
    if(clr = '1') then
        nclk <= '0';
    elsif(falling_edge(clk)) then
        if((nclk xor pclk) = '1') then
            nclk <= not nclk;
        end if;
    end if;
end process;

na <= pclk xor nclk;

end Behavioral;
