library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity barrel_s is
    Port ( dato : in STD_LOGIC_VECTOR (15 downto 0);
           res : out STD_LOGIC_VECTOR (15 downto 0);
           s : in STD_LOGIC_VECTOR (3 downto 0);
           dir : in STD_LOGIC);
end barrel_s;

architecture Behavioral of barrel_s is
begin

process(dato, s, dir)
variable aux : std_logic_vector(15 downto 0);
begin
aux := dato;    
if(dir='1') then            
    for i in 0 to 3 loop
        for j in 15 downto 2**i loop    
            if s(i) = '0' then
                aux(j) := aux(j);     
            else                  
                aux(j) := aux(j-2**i);  
            end if;                    
        end loop;                      
        for j in 2**i-1 downto 0 loop   
            if s(i) = '0' then
                aux(j) := aux(j);
            else
                aux(j) := '0';
            end if;
        end loop;
    end loop;
else
    for i in 0 to 3 loop
        for j in 0 to 15-2**i loop
            if s(i) = '0' then
                aux(j) := aux(j);
            else
                aux(j) := aux(j+2**i);
            end if;
        end loop;
        for j in 16-2**i to 15 loop
            if s(i) = '0' then
                aux(j) := aux(j);
            else
                aux(j) := '0';
            end if;
        end loop;
    end loop;
end if;
res <= aux;
    
end process;

end Behavioral;
