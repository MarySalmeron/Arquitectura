library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Programa is
    generic (
        m : integer := 9; --tamaño del bus de direcciones
        n : integer := 25 --tamaño de palabra
    );
    Port ( dir : in STD_LOGIC_VECTOR (m-1 downto 0);
           inst : out STD_LOGIC_VECTOR (n-1 downto 0));
end Programa;

architecture Behavioral of Programa is
								--OPERACIONES DE CARGA Y ALAMACENAMIENTO
constant LI : std_logic_vector(4 downto 0):="00001";
constant LW1 : std_logic_vector(4 downto 0):="00010";
constant LW : std_logic_vector(4 downto 0):="10111";
constant SWI : std_logic_vector(4 downto 0):="00011";
constant SW : std_logic_vector(4 downto 0):="00100";

								--INSTRUCCIONES ARITMETICAS
constant ADD : std_logic_vector(4 downto 0):="00000";
constant SUB : std_logic_vector(4 downto 0):="00000";
constant ADDI : std_logic_vector(4 downto 0):="00101";
constant SUBI : std_logic_vector(4 downto 0):="00110";

constant ID_ADD : std_logic_vector(3 downto 0) := "0000";
constant ID_SUB : std_logic_vector(3 downto 0) := "0001";

								--INSTRUCCIONES LOGICAS
constant OP_AND : std_logic_vector(4 downto 0):="00000";
constant OP_OR : std_logic_vector(4 downto 0):="00000";
constant OP_XOR : std_logic_vector(4 downto 0):="00000";
constant OP_NAND : std_logic_vector(4 downto 0):="00000";
constant OP_NOR : std_logic_vector(4 downto 0):="00000";
constant OP_XNOR : std_logic_vector(4 downto 0):="00000";
constant OP_NOT : std_logic_vector(4 downto 0):="00000";
constant OP_ANDI : std_logic_vector(4 downto 0):="00111";
constant OP_ORI : std_logic_vector(4 downto 0):="01000";
constant OP_XORI : std_logic_vector(4 downto 0):="01001";
constant OP_NANDI : std_logic_vector(4 downto 0):="01010";
constant OP_NORI : std_logic_vector(4 downto 0):="01011";
constant OP_XNORI : std_logic_vector(4 downto 0):="01100";

constant ID_AND : std_logic_vector(3 downto 0) := "0010";
constant ID_OR : std_logic_vector(3 downto 0) := "0011";
constant ID_XOR : std_logic_vector(3 downto 0) := "0100";
constant ID_NAND : std_logic_vector(3 downto 0) := "0101";
constant ID_NOR : std_logic_vector(3 downto 0) := "0110";
constant ID_XNOR : std_logic_vector(3 downto 0) := "0111";
constant ID_NOT : std_logic_vector(3 downto 0) := "1000";

									--INSTRUCCIONES DE CORRIMIENTO
constant OP_SLL : std_logic_vector(4 downto 0):="00000";
constant OP_SRL : std_logic_vector(4 downto 0):="00000";

									--INSTRUCCIONES DE SALTOS CONDICIONALES E INCONDICIONALES
constant BEQI : std_logic_vector(4 downto 0):="01101";
constant BNEI : std_logic_vector(4 downto 0):="01110";
constant BLTI : std_logic_vector(4 downto 0):="01111";
constant BLETI : std_logic_vector(4 downto 0):="10000";
constant BGTI : std_logic_vector(4 downto 0):="10001";
constant BGETI : std_logic_vector(4 downto 0):="10010";
constant B : std_logic_vector(4 downto 0):="10011";

										--INSTRUCCIONES DE MANEJO DE SUBRUTINAS
constant CALL : std_logic_vector(4 downto 0):="10100";
constant RET : std_logic_vector(4 downto 0):="10101";

										--OTRAS INSTRUCCIONES
constant NOP : std_logic_vector(4 downto 0):="10110";


										--REGISTROS
constant R0 : std_logic_vector(3 downto 0):="0000";
constant R1 : std_logic_vector(3 downto 0):="0001";
constant R2 : std_logic_vector(3 downto 0):="0010";
constant R3 : std_logic_vector(3 downto 0) := "0011";
constant R4 : std_logic_vector(3 downto 0) := "0100";
constant R5 : std_logic_vector(3 downto 0) := "0101";
constant R6 : std_logic_vector(3 downto 0) := "0110";
constant R7 : std_logic_vector(3 downto 0) := "0111";
constant R8 : std_logic_vector(3 downto 0) := "1000";
constant R9 : std_logic_vector(3 downto 0) := "1001";
constant R10 : std_logic_vector(3 downto 0) := "1010";
constant R11 : std_logic_vector(3 downto 0) := "1011";
constant R12 : std_logic_vector(3 downto 0) := "1100";
constant R13 : std_logic_vector(3 downto 0) := "1101";
constant R14 : std_logic_vector(3 downto 0) := "1110";
constant R15 : std_logic_vector(3 downto 0) := "1111";
constant SU : std_logic_vector(3 downto 0):="0000";

type banco is array (0 to (2**m)-1) of std_logic_vector(n-1 downto 0);
constant aux : banco := (
    --PRIMER PROGRAMA====================================================================================================================
--    LI & R0 & x"0001",                  --LI R0,#1
--    LI & R1 & x"0007",                  --LI R1,#7
--    ADD & R1 & R1 & R0 & su & ID_ADD,   --ADD R4,R0,R1      ciclo:
--    SWI & R1 & x"0005",                 --SWI R1,0x5
--    B & su & x"0002",                   --B ciclo
    --SEGUNDO PROGRAMA====================================================================================================================
    LI & R0 & x"0003",              --0
    LI & R1 & x"0002",              --1
    LI & R2 & x"0000",              --2
    LI & R3 & x"0000",              --3
    CALL & SU & x"0008",            --4
    
    SWI & R2 & x"0026",             --5
    NOP & SU & SU & SU & SU & SU,   --6
    B & SU & x"0006",               --7
    
    ADD & R2 & R2 & R0 & SU & ID_ADD,    --8
    ADDI & R3 & R3 & x"001",       --9
    BLTI & R1 & R3 & x"FFE",        --10
    RET & SU & SU & SU & SU & SU,   --11
    others => (others => '0')
);
begin

    inst <= aux(conv_integer(dir));


end Behavioral;