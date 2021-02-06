library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Mem_datos is
    Port ( add : in STD_LOGIC_VECTOR (8 downto 0);
           dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           clk, wd : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (15 downto 0));
end Mem_datos;

architecture Behavioral of Mem_datos is
type banco is array (0 to 1023) of std_logic_vector(15 downto 0);
signal aux : banco := (others => (others => '0'));
begin

process(clk)
begin
    if (rising_edge(clk)) then
        if (wd = '1') then
            aux(conv_integer(add)) <= dataIn;
        end if;
    end if;
end process;
dataOut <= aux(conv_integer(add));


end Behavioral;