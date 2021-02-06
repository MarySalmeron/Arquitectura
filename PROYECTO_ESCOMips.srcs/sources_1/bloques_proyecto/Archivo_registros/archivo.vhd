library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
------------------------------------------------------------------ENTIDAD--------------------------------------------------------------------
entity Reg_archivos is
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
end Reg_archivos;
------------------------------------------------------------------ARQUITECTURA--------------------------------------------------------------------
architecture Behavioral of Reg_archivos is

Type banco is array (0 to 15) of std_logic_vector(15 downto 0);
signal q: banco;

signal dgeneral : STD_LOGIC_VECTOR (15 downto 0);
signal l : STD_LOGIC_VECTOR (15 downto 0);
signal resp : STD_LOGIC_VECTOR (15 downto 0);

component Registro is
    Port ( d : in STD_LOGIC_VECTOR (15 downto 0);
           clr,clk,l : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component barrel_s is
    Port ( dato : in STD_LOGIC_VECTOR (15 downto 0);
           res : out STD_LOGIC_VECTOR (15 downto 0);
           s : in STD_LOGIC_VECTOR (3 downto 0);
           dir : in STD_LOGIC);
end component;

component Dmux is
    Port ( WR : in STD_LOGIC;
           WriteReg : in STD_LOGIC_VECTOR (3 downto 0);
           l : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component Mux_WD is
    Port ( WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           respuesta : in STD_LOGIC_VECTOR (15 downto 0);
           SHE : in STD_LOGIC;
           dato : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component Mux_RD is
    Port ( readReg1 : in STD_LOGIC_VECTOR (3 downto 0);
           readReg2 : in STD_LOGIC_VECTOR (3 downto 0);
           readData1 : out STD_LOGIC_VECTOR (15 downto 0);
           readData2 : out STD_LOGIC_VECTOR (15 downto 0);
           q0 : in STD_LOGIC_VECTOR (15 downto 0);
           q1 : in STD_LOGIC_VECTOR (15 downto 0);
           q2 : in STD_LOGIC_VECTOR (15 downto 0);
           q3 : in STD_LOGIC_VECTOR (15 downto 0);
           q4 : in STD_LOGIC_VECTOR (15 downto 0);
           q5 : in STD_LOGIC_VECTOR (15 downto 0);
           q6 : in STD_LOGIC_VECTOR (15 downto 0);
           q7 : in STD_LOGIC_VECTOR (15 downto 0);
           q8 : in STD_LOGIC_VECTOR (15 downto 0);
           q9 : in STD_LOGIC_VECTOR (15 downto 0);
           q10 : in STD_LOGIC_VECTOR (15 downto 0);
           q11 : in STD_LOGIC_VECTOR (15 downto 0);
           q12 : in STD_LOGIC_VECTOR (15 downto 0);
           q13 : in STD_LOGIC_VECTOR (15 downto 0);
           q14 : in STD_LOGIC_VECTOR (15 downto 0);
           q15 : in STD_LOGIC_VECTOR (15 downto 0));
end component;

------------------------------------------------------------------ARQUITECTURA (BEGIN)--------------------------------------------------------------------
begin

demux: Dmux Port map(
    WriteReg => writeReg,
    WR => WR,
    l => l
);

Ciclo: for i in 0 to 15 generate
flipflop: Registro Port map(
    d => dgeneral,
    q => q(i),
    clk => clk,
    clr => clr,
    l => l(i) 
);
end generate;

mux1: Mux_RD Port map(
    readReg1 => readReg1,
    readReg2 => readReg2,
    readData1 => readData1,
    readData2 => readData2,
    q0 => q(0),
    q1 => q(1),
    q2 => q(2),
    q3 => q(3),
    q4 => q(4),
    q5 => q(5),
    q6 => q(6),
    q7 => q(7),
    q8 => q(8),
    q9 => q(9),
    q10 => q(10),
    q11 => q(11),
    q12 => q(12),
    q13 => q(13),
    q14 => q(14),
    q15 => q(15)
);

barrel_shift: barrel_s Port map(
    s => shamt,
    dir => dir,
    dato => readData1,
    res => resp
);

mux2: Mux_WD Port map(
    SHE => SHE,
    WriteData => writeData,
    dato => dgeneral,
    respuesta => resp
);


end Behavioral;
