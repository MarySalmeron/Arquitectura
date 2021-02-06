library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete1 is
component bloqCondicion is
    Port ( Q : in STD_LOGIC_VECTOR (3 downto 0); 
           cond_salida : out STD_LOGIC_VECTOR (5 downto 0)); 
end component;

component FunCodeE is
    Port ( funCode : in STD_LOGIC_VECTOR (3 downto 0);
           micFun : out STD_LOGIC_VECTOR (19 downto 0));
end component;

component MopCode is
    Port ( opCode : in STD_LOGIC_VECTOR (4 downto 0);
           micOp : out STD_LOGIC_VECTOR (19 downto 0));
end component;

component deco is
    Port ( opCode : in STD_LOGIC_VECTOR (4 downto 0);
           op_salida : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component nivel is
    Port ( clk,clr : in STD_LOGIC;
           na : out STD_LOGIC);
end component;

component UC is
    Port ( salidaDeco : in STD_LOGIC_VECTOR (6 downto 0);
           salidaCond : in STD_LOGIC_VECTOR (5 downto 0);
           clk,clr,na : in STD_LOGIC;
           SDOPC,SM : out STD_LOGIC);
end component;

--component mux1 is
--    Port ( SDOPC : in STD_LOGIC;
--           opcode,cero : in STD_LOGIC_VECTOR(4 downto 0);
--           salmux1 : out STD_LOGIC_VECTOR(4 downto 0));
--end component;

component mux2 is
    Port ( funCode : in STD_LOGIC_VECTOR (19 downto 0);
           opCode : in STD_LOGIC_VECTOR (19 downto 0);
           SM : in STD_LOGIC;
           salmux2 : out STD_LOGIC_VECTOR (19 downto 0));
end component;

component banderas is
    Port ( clk,clr : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           LF : in STD_LOGIC);
end component;

end package;