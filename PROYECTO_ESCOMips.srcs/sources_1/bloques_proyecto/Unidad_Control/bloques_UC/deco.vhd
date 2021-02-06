library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco is
    Port ( opCode : in STD_LOGIC_VECTOR (4 downto 0);
           op_salida : out STD_LOGIC_VECTOR (6 downto 0));
end deco;

architecture Behavioral of deco is

begin

with opCode select
    op_salida <= "0000001" when "00000",
                "0000010" when "01101",
                "0000100" when "01110",
                "0001000" when "01111",
                "0010000" when "10000",
                "0100000" when "10001",
                "1000000" when "10010",
                "0000000" when others;

--process(opCode)
--begin

--    case opCode is
--        when "00000" => op_salida <= "0000001";
--        when "01101" => op_salida <= "0000010";
--        when "01110" => op_salida <= "0000100";
--        when "01111" => op_salida <= "0001000";
--        when "10000" => op_salida <= "0010000";
--        when "10001" => op_salida <= "0100000";
--        when "10010" => op_salida <= "1000000";
--        when others => op_salida <= "0000000";
--    end case;
--end process;

end Behavioral;
