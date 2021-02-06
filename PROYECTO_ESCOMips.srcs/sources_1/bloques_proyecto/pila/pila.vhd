library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity pila is
    generic(
		N : integer := 3;
		M : integer := 16
	);
    Port ( PCin : in STD_LOGIC_VECTOR (M-1 downto 0);
           PCout : out STD_LOGIC_VECTOR (M-1 downto 0):= (others => '0');
           SPout : out STD_LOGIC_VECTOR (N-1 downto 0);
           clk,clr,wpc,up,dw : in STD_LOGIC);
end pila;

architecture Behavioral of pila is
type banco is array (0 to (2**N)-1) of std_logic_vector(M-1 downto 0);
signal aux : banco;
signal sp1: integer range 0 to (2**N)-1;

begin

process(clk,clr)
variable sp: integer range 0 to (2**N)-1;
begin
	if(clr = '1') then
		SP := 0;
		aux <= (others => (others => '0'));
	elsif(clk' event and clk = '1') then
		if(wpc = '0' and up = '0' and dw = '0') then
			aux(sp) <= aux(sp) + 1;
		elsif(wpc = '1' and up = '1' and dw = '0') then
			sp := sp + 1;
			if(SP = 2**N) then
                    SP := 0;
                end if;
			aux(sp) <= PCin;
		elsif(wpc = '1' and up = '0' and dw = '0') then
		     aux(sp) <= PCin;
		elsif(wpc = '1' and up = '0' and dw = '1') then
		      sp := sp - 1;
		      if(SP = -1) then
                    SP := (2**N)-1;
                end if;
		      aux(sp) <= aux(sp) + 1;
		end if;
	end if;
	sp1 <= sp;
	--pcout <= aux(sp1);
    --SPout <= conv_std_logic_vector(sp, N);
end process;

pcout <= aux(sp1);

end Behavioral;
