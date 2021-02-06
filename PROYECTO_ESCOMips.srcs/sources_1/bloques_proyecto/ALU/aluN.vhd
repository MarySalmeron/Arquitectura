
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity aluN is
    generic( num_bits:integer:=16); 
    Port ( a,b : in STD_LOGIC_VECTOR(num_bits-1 downto 0);
           aluop : in std_logic_vector (3 downto 0);
           res : out STD_LOGIC_vector (num_bits-1 downto 0);
           n,z,ov,co: out std_logic
           );
end aluN;

architecture Behavioral of aluN is
component alu1 is
    Port ( a, b, sela, selb, cin : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           res : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;
signal c :std_logic_vector(num_bits downto 0);
signal aux :std_logic_vector(num_bits-1 downto 0);
begin

c(0) <= aluop(2);
    ciclo: for i in 0 to num_bits-1 generate
    bitA: alu1 Port map(
    a => a(i),
    b =>b(i),
    sela =>aluop(3),
    selb => aluop(2),
    cin => c(i),
    op => aluop(1 downto 0),
    res => aux(i),
    cout => c(i+1)
    );
    
    end generate;
    
    n<= aux(num_bits-1); --signo
    co <= c(num_bits); --carry
        
    --flags(1) <= '1' when aux = "0000" else '0';
    z <= not(aux(15) or aux(14) or aux(13) or aux(12) or aux(11) or aux(10) or aux(9) or aux(8) or aux(7) or aux(6) or aux(5) or aux(4) or aux(3) or aux(2) or aux(1) or aux(0)); --zero    falta por parametrizar
    ov <= c(num_bits) xor c(num_bits-1); -- overflow
    
    res <= aux;
end Behavioral;
