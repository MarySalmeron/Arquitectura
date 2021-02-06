library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package paquete is
    
component pila is
    Port ( PCin : in STD_LOGIC_VECTOR (15 downto 0);
           PCout : out STD_LOGIC_VECTOR (15 downto 0);
           clk,clr,wpc,up,dw : in STD_LOGIC);
end component;

component Programa is
    Port ( dir : in STD_LOGIC_VECTOR (8 downto 0);
           inst : out STD_LOGIC_VECTOR (24 downto 0));
end component;

component Reg_archivos is
    Port ( writeData : in STD_LOGIC_VECTOR (15 downto 0);
           writeReg : in STD_LOGIC_VECTOR (3 downto 0);
           readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           shamt : in STD_LOGIC_VECTOR (3 downto 0);
           WR : in STD_LOGIC;
           SHE : in STD_LOGIC;
           dir,clr,clk : in STD_LOGIC;
           readData1 : inout STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component UC_final is
    Port ( clk,clr : in STD_LOGIC;
           funCode : in STD_LOGIC_VECTOR (3 downto 0);
           opCode : in STD_LOGIC_VECTOR (4 downto 0);
           band : in STD_LOGIC_VECTOR (3 downto 0);
           microinst : inout STD_LOGIC_VECTOR (19 downto 0));
end component;

component aluN is
    generic( num_bits:integer:=16); 
    Port ( a,b : in STD_LOGIC_VECTOR(num_bits-1 downto 0);
           aluop : in std_logic_vector (3 downto 0);
           res : out STD_LOGIC_vector (num_bits-1 downto 0);
           n,z,ov,co:out std_logic
           );
end component;
    
component Mem_datos is
    Port ( add : in STD_LOGIC_VECTOR (8 downto 0);
           dataIn : in STD_LOGIC_VECTOR (15 downto 0);
           clk, wd : in STD_LOGIC;
           dataOut : out STD_LOGIC_VECTOR (15 downto 0));
end component; 

component extensores is
    Port ( s_inst : in STD_LOGIC_VECTOR (11 downto 0);
           signo,direccion : out STD_LOGIC_VECTOR (15 downto 0));
end component;
   
end package;