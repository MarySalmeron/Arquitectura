library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.paquete.all;

entity Proyecto is
    Port ( clk, rclr : in STD_LOGIC;
           micro_instruccion_s : inout STD_LOGIC_VECTOR(19 downto 0);
           WR_s : inout STD_LOGIC;
           sPCout : out STD_LOGIC_VECTOR (15 downto 0);
           PCout_s : inout STD_LOGIC_VECTOR (15 downto 0);
           SR_salida : inout STD_LOGIC_VECTOR (15 downto 0);
           instruccion_s : inout STD_LOGIC_VECTOR (24 downto 0);
           res_ALU : inout STD_LOGIC_VECTOR (15 downto 0);
           RD1 : inout STD_LOGIC_VECTOR (15 downto 0);
           RD2 : inout STD_LOGIC_VECTOR (15 downto 0);
           rreg1: out std_logic_vector(3 downto 0);
           rreg2: out std_logic_vector(3 downto 0)
           );
           
end Proyecto;

architecture Behavioral of Proyecto is

    signal PCin_s : STD_LOGIC_VECTOR (15 downto 0);
    signal SWD_salida : STD_LOGIC_VECTOR (15 downto 0);
    signal SR2_salida : STD_LOGIC_VECTOR (3 downto 0);
    signal FLAGS : STD_LOGIC_VECTOR (3 downto 0);
    signal SOP1_salida,SOP2_salida : STD_LOGIC_VECTOR (15 downto 0);
    signal EXT_SIG, EXT_DIR : STD_LOGIC_VECTOR (15 downto 0);
    signal SEXT_salida : STD_LOGIC_VECTOR (15 downto 0);
    signal SDMD_salida : STD_LOGIC_VECTOR (15 downto 0);
    signal DATA_salida : STD_LOGIC_VECTOR (15 downto 0);
    signal clr: std_logic;
    --signal PCout_s : STD_LOGIC_VECTOR (15 downto 0);
begin

    pila_Model : pila
    Port Map(
        clk => clk,
        clr => clr,
        wpc => micro_instruccion_s(16),
        up => micro_instruccion_s(18),
        dw => micro_instruccion_s(17),
        PCin => PCin_s,
        PCout => PCout_s
    );

    P_memProg : Programa
    Port Map(
        dir => PCout_s(8 downto 0),
        inst => instruccion_s
    );

    P_archR : Reg_archivos
    Port Map(
        writeData => SWD_salida,
        writeReg => instruccion_s(19 downto 16),
        readReg1 => instruccion_s(15 downto 12),
        readReg2 => SR2_salida,
        shamt => instruccion_s(7 downto 4),
        WR => micro_instruccion_s(10),
        SHE => micro_instruccion_s(12),
        dir => micro_instruccion_s(11),
        clr => clr,
        clk => clk,
        readData1 => RD1,
        readData2 => RD2
    );

    WR_s <= micro_instruccion_s(10);
    
    SR2_salida <= instruccion_s(19 downto 16) when (micro_instruccion_s(15) = '1') else
                instruccion_s(11 downto 8);
                
    P_UC : UC_final
    Port Map(
        clr => clr,
        clk => clk,
        funCode => instruccion_s(3 downto 0),
        opCode => instruccion_s(24 downto 20),
        band => FLAGS,
        microinst => micro_instruccion_s
    );
    
    P_ALU : aluN
    Port Map(
        a => SOP1_salida,
        b => SOP2_salida,
        aluop => micro_instruccion_s(7 downto 4),
        res => res_ALU,
        n => FLAGS(2),
        z => FLAGS(1),
        ov => FLAGS(3),
        co => FLAGS(0)
    );

    --extensores
    P_ext : extensores
    Port Map(
        s_inst => instruccion_s(11 downto 0),
        signo => EXT_SIG,
        direccion => EXT_DIR
    );

    SEXT_salida <= EXT_DIR when (micro_instruccion_s(13) = '1') else
                    EXT_SIG;
    
    --multiplexores SOP1 y SOP2 
    SOP1_salida <= PCout_s when (micro_instruccion_s(9) = '1') else
                RD1;
    
    SOP2_salida <= SEXT_salida when (micro_instruccion_s(8) = '1') else
                RD2;
            
    --multiplexor SDMD
    SDMD_salida <= instruccion_s(15 downto 0) when (micro_instruccion_s(3) = '1') else
                res_ALU;
    
    P_memData : Mem_datos
    Port Map(
        add => SDMD_salida(8 downto 0),
        dataIn => RD2,
        clk => clk,
        wd => micro_instruccion_s(2),
        dataOut => DATA_salida
    );
    
    SR_salida <= res_ALU when (micro_instruccion_s(1) = '1') else
                    DATA_salida;
                    
    SWD_salida <= SR_salida when (micro_instruccion_s(14) = '1') else
                    instruccion_s(15 downto 0);
                    
    PCin_s <= SR_salida when (micro_instruccion_s(19) = '1') else
                    instruccion_s(15 downto 0);
                    
    process(clk)
    begin
        if(falling_edge(clk))then
            clr <= rclr;
        end if;
    end process;
    
    rreg1<=instruccion_s(15 downto 12);
    rreg2<=SR2_salida;    
    
end Behavioral;
