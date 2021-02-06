library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity simulacion is
--  Port ( );
end simulacion;

architecture Behavioral of simulacion is

component Proyecto is
    Port ( clk,rclr : in STD_LOGIC;
           WR_s : inout STD_LOGIC;
           micro_instruccion_s : inout STD_LOGIC_VECTOR(19 downto 0);
           PCout_s : inout STD_LOGIC_VECTOR (15 downto 0);
           SR_salida : inout STD_LOGIC_VECTOR (15 downto 0);
           instruccion_s : inout STD_LOGIC_VECTOR (24 downto 0);
           res_ALU : inout STD_LOGIC_VECTOR (15 downto 0);
           RD1 : inout STD_LOGIC_VECTOR (15 downto 0);
           RD2 : inout STD_LOGIC_VECTOR (15 downto 0);
           rreg1: out std_logic_vector(3 downto 0);
           rreg2: out std_logic_vector(3 downto 0)
           );
end component;

signal clk,rclr: STD_LOGIC;
signal WR_s : STD_LOGIC;
signal micro_instruccion_s : STD_LOGIC_VECTOR(19 downto 0);
signal SR_salida : STD_LOGIC_VECTOR (15 downto 0);
signal res_ALU : STD_LOGIC_VECTOR (15 downto 0);
signal RD1 : STD_LOGIC_VECTOR (15 downto 0);
signal RD2 : STD_LOGIC_VECTOR (15 downto 0);
signal PCout_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
signal instruccion_s : STD_LOGIC_VECTOR (24 downto 0);
signal rreg1: std_logic_vector(3 downto 0);
signal rreg2: std_logic_vector(3 downto 0);
signal Sal_RD2: std_logic_vector(3 downto 0);
--signal rclr: std_logic;
begin

    pro : Proyecto
    Port Map(
        clk => clk,
        rclr => rclr,
        WR_s => WR_s,
        micro_instruccion_s => micro_instruccion_s,
        SR_salida => SR_salida,
        res_ALU => res_ALU,
        PCout_s => PCout_s,
        instruccion_s => instruccion_s,
        RD1 => RD1,
        RD2 => RD2,
        rreg1=>rreg1,
        rreg2=>rreg2
    );

    reloj : process 
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    
    clearR : process 
    begin
        rclr <= '1';
        wait for 30 ns;
        rclr <= '0';
        wait;
    end process;
 
end Behavioral;
