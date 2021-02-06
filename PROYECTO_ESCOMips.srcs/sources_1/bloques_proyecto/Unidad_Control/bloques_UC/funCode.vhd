library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity FunCodeE is
    generic (
        m : integer := 4; --tamaño del bus de direcciones
        n : integer := 20 --tamaño de la microinstruccion
    );
    Port ( funCode : in STD_LOGIC_VECTOR (m-1 downto 0);
           micFun : out STD_LOGIC_VECTOR (n-1 downto 0));
end FunCodeE;

architecture Behavioral of FunCodeE is

type banco is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);

    --Microinstruccion
	--SDMP,UP,DW,WPC,SR2,SWD,SEXT,SHE,DIR,WR,SOP1,SOP2,ALUOP[3],ALUOP[2],ALUOP[1],ALUOP[0],SDMD,WD,SR,LF
	constant ADD:    			std_logic_vector:="00000100010000110011";
	constant SUB:    			std_logic_vector:="00000100010001110011";
	constant AND_M:  			std_logic_vector:="00000100010000000011";
	constant OR_M:   			std_logic_vector:="00000100010000010011";
	constant XOR_M:  			std_logic_vector:="00000100010000100011";
	constant NAND_M: 			std_logic_vector:="00000100010011010011";
	constant NOR_M:  			std_logic_vector:="00000100010011000011";
	constant XNOR_M: 			std_logic_vector:="00000100010010100011";
	constant NOT_M:  			std_logic_vector:="00000100010011010011";
	constant SLL_M:  			std_logic_vector:="00000001110000000000";
	constant SRL_M:  			std_logic_vector:="00000001010000000000";
constant aux : banco := (
    ADD,		--00
	SUB,		--01
	AND_M,		--02
	OR_M,		--03
	XOR_M,		--04
	NAND_M,		--05
	NOR_M,		--06
	XNOR_M,		--07
	NOT_M,		--08
	SLL_M,		--09
	SRL_M,		--10                           
    others => (others => '0')
);
begin

    micFun <= aux(conv_integer(funCode));


end Behavioral;