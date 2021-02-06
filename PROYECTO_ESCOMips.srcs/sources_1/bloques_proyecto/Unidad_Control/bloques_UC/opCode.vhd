library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity MopCode is
    generic (
        m : integer := 5; --tamaño del bus de direcciones
        n : integer := 20 --tamaño de la microinstruccion
    );
    Port ( opCode : in STD_LOGIC_VECTOR (m-1 downto 0);
           micOp : out STD_LOGIC_VECTOR (n-1 downto 0));
end MopCode;

architecture Behavioral of MopCode is

type banco is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);
--Microinstruccion
	--SDMP,UP,DW,WPC,SR2,SWD,SEXT,SHE,DIR,WR,SOP1,SOP2,ALUOP[3],ALUOP[2],ALUOP[1],ALUOP[0],SDMD,WD,SR,LF
	constant verificacion: 	    std_logic_vector:="00001000000001110001";
	constant LI:  				std_logic_vector:="00000000010000000000";
	constant LWI: 				std_logic_vector:="00000100010000001000";
	constant SWI: 				std_logic_vector:="00001000000000001100";
	constant SW:  				std_logic_vector:="00001010000100110101";
	
	constant ADDI:  			std_logic_vector:="00000100010100110011";
	constant SUBI:  			std_logic_vector:="00000100010101110011";
	constant ANDI:  			std_logic_vector:="00000100010100000011";
	constant ORI:   			std_logic_vector:="00000100010100010011";
	constant XORI:  			std_logic_vector:="00000100010100100011";
	constant NANDI: 			std_logic_vector:="00000100010111010011";
	constant NORI:  			std_logic_vector:="00000100010111000011";
	constant XNORI: 			std_logic_vector:="00000100010110100011";
	constant salto: 			std_logic_vector:="10010000001100110011"; 
	constant B: 	 			std_logic_vector:="00010000000000000000";
	constant CALL:  			std_logic_vector:="01010000000000000000";
	constant RET: 	 			std_logic_vector:="00110000000000000000";
	constant NOP: 	 			std_logic_vector:="00000000000000000000";
	constant LW: 				std_logic_vector:="00000110010100110001";
constant aux : banco := (
    verificacion, 	--00
	LI,				--01
	LWI,			--02
	SWI,			--03
	SW,				--04
	ADDI,			--05
	SUBI,			--06
	ANDI,			--07
	ORI,			--08
	XORI,			--09
	NANDI,			--10
	NORI,			--11
	XNORI,			--12
	salto,			--13
	salto,			--14
	salto,			--15
	salto,			--16
	salto,			--17
	salto,			--18
	B,				--19
	CALL,			--20
	RET,			--21
	NOP,			--22
	LW,				--23
    others => (others => '0')
);

begin
    micOp <= aux(conv_integer(OpCode));
end Behavioral;
