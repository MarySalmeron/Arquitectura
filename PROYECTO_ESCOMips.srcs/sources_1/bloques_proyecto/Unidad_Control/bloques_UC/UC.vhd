library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( salidaDeco : in STD_LOGIC_VECTOR (6 downto 0);
           salidaCond : in STD_LOGIC_VECTOR (5 downto 0);
           clk,clr,na : in STD_LOGIC;
           SDOPC,SM : out STD_LOGIC);
end UC;

architecture Behavioral of UC is
type estados is (A);
signal edo_act,edo_sig: estados;
begin

automata : process(salidaDeco, salidaCond, edo_act, na)
begin
    SDOPC <= '0';
    SM <= '0';
    case edo_act is
        when A => edo_sig <= A;
            if(salidaDeco(0) = '0') then                --if(tipoR = '0')
                if(salidaDeco(1) = '1') then            --if(BEQI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(5) = '1') then    --if(EQ = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif(salidaDeco(2) = '1') then         --if(BNEI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(4) = '1') then    --if(NE = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif(salidaDeco(3) = '1') then         --if(BLTI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(3) = '1') then    --if(LT = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif(salidaDeco(4) = '1') then         --if(BLETI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(2) = '1') then    --if(LE = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif(salidaDeco(5) = '1') then         --if(BGTI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(1) = '1') then    --if(GT = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                elsif(salidaDeco(6) = '1') then         --if(BGETI = '1')
                    if(na = '1') then
                        SM <= '1';
                    else
                        if(salidaCond(0) = '1') then    --if(GE = '1')
                            SDOPC <= '1';
                            SM <= '1';
                        else
                            SM <= '1';
                        end if;
                    end if;
                else
                    SDOPC <= '1';
                    SM <= '1';
                end if;
            end if;
    end case;
end process automata;

transicion : process(clk,clr)
begin
    if(clr = '1') then
        edo_act <= A;
    elsif(rising_edge(clk)) then
        edo_act <= edo_sig;
    end if;
end process transicion;

end Behavioral;
