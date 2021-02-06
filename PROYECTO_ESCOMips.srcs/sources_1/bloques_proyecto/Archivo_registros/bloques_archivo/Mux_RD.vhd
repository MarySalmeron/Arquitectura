library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_RD is
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
end Mux_RD;

architecture Behavioral of Mux_RD is

begin

with readReg1 select
    readData1 <= q0 when "0000",
                   q1 when "0001",
                   q2 when "0010",
                   q3 when "0011",
                   q4 when "0100",
                   q5 when "0101",
                   q6 when "0110",
                   q7 when "0111",
                   q8 when "1000",
                   q9 when "1001",
                   q10 when "1010",
                   q11 when "1011",
                   q12 when "1100",
                   q13 when "1101",
                   q14 when "1110",
                   q15 when others;
                   
with readReg2 select
    readData2 <= q0 when "0000",
                   q1 when "0001",
                   q2 when "0010",
                   q3 when "0011",
                   q4 when "0100",
                   q5 when "0101",
                   q6 when "0110",
                   q7 when "0111",
                   q8 when "1000",
                   q9 when "1001",
                   q10 when "1010",
                   q11 when "1011",
                   q12 when "1100",
                   q13 when "1101",
                   q14 when "1110",
                   q15 when others;

end Behavioral;
