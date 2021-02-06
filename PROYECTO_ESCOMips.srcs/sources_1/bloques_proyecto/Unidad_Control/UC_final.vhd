library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.paquete1.all;

entity UC_final is
    Port ( clk,clr : in STD_LOGIC;
           funCode : in STD_LOGIC_VECTOR (3 downto 0);
           opCode : in STD_LOGIC_VECTOR (4 downto 0);
           band : in STD_LOGIC_VECTOR (3 downto 0);
           microinst : inout STD_LOGIC_VECTOR (19 downto 0));
end UC_final;

architecture Behavioral of UC_final is

signal EQ,NE,LT,LE,GT,GE : STD_LOGIC;
signal Q_s : STD_LOGIC_VECTOR(3 downto 0);
signal micFun_1 : STD_LOGIC_VECTOR(19 downto 0);
signal micOp_1 : STD_LOGIC_VECTOR(19 downto 0);
signal opCode_Aux1,cero_s : STD_LOGIC_VECTOR(4 downto 0);
signal tipor,beqi,bnei,blti,bleti,bgti,bgeti : STD_LOGIC;
signal na_1 : STD_LOGIC;
signal SDOPC_1,SM_1 : STD_LOGIC;

begin

condicion : bloqCondicion
    Port map(
        Q => Q_s,
        cond_salida(5) => EQ,
        cond_salida(4) => NE,
        cond_salida(3) => LT,
        cond_salida(2) => LE,
        cond_salida(1) => GT,
        cond_salida(0) => GE
    );

MfunCode_1 : FunCodeE
    Port map(
        funCode => funCode,
        micFun => micFun_1
    );
    
MopCode_1 : MopCode
    Port map(
        opCode => opCode_Aux1,
        micOp => micOp_1
    );
    
deco_1 : deco
    Port map(
        opCode => opCode,
        op_salida(0) => tipor,
        op_salida(1) => beqi,
        op_salida(2) => bnei,
        op_salida(3) => blti,
        op_salida(4) => bleti,
        op_salida(5) => bgti,
        op_salida(6) => bgeti
    );

nivel_1 : nivel
    Port map(
        na => na_1,
        clk => clk,
        clr => clr
    );


    
UC_1 : UC
    Port map(
        clk => clk,
        clr => clr,
        na => na_1,
        SDOPC => SDOPC_1,
        SM => SM_1,
        salidaDeco(0) => tipor,
        salidaDeco(1) => beqi,
        salidaDeco(2) => bnei,
        salidaDeco(3) => blti,
        salidaDeco(4) => bleti,
        salidaDeco(5) => bgti,
        salidaDeco(6) => bgeti,
        salidaCond(0) => GE,
        salidaCond(1) => GT,
        salidaCond(2) => LE,
        salidaCond(3) => LT,
        salidaCond(4) => NE,
        salidaCond(5) => EQ
    );

--mux1_1 : mux1
--    Port map(
--        SDOPC => SDOPC_1,
--        opCode => opCode,
--        salmux1 => opCode_Aux1,
--        cero => cero_s     
--    );

cero_s <= "00000";
opCode_Aux1 <= cero_s when (SDOPC_1 = '0') else
            opCode;
    
mux1_2 : mux2
    Port map(
        funCode => micFun_1,
        opCode => micOp_1,
        SM => SM_1,
        salmux2 => microinst
    );

banderas_1 : banderas
    Port map(
        clk => clk,
        clr => clr,
        D => band,
        Q => Q_s,
        LF => microinst(0)
    );

end Behavioral;
