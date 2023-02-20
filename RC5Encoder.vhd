


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RC5Encoder is
    Port (
        clk: in std_logic;
        rst: in std_logic;
        d_in: in std_logic_vector(63 downto 0);
        d_out: out std_logic_vector(63 downto 0)
    );

end RC5Encoder;

architecture Behavioral of RC5Encoder is
    Signal a_reg,b_reg,ab_xor,ba_xor,b_rot,a_rot,a,b :  std_logic_vector(31 downto 0);
    signal count:std_logic_vector(3 downto 0):="0001";
    TYPE rom is ARRAY(2 to 25)of std_logic_vector(31 downto 0);
    CONSTANT skey:rom := rom'(X"46F8E8C5",X"460C6085",X"70F83B8A",X"284B8303",X"513E1454",X"F621ED22",X"3125065D",X"11A83A5D",X"D427686B",X"713AD82D",X"4B792F99",X"2799A4DD",X"A7901C49",X"DEDE871A",X"36C03196",X"A7EFC249",X"61A78BB8",X"3B0A1D2B",X"4DBFCA76",X"AE162167",X"30D76B0A",X"43192304",X"F6CC1431",X"65046380");
begin        
ab_xor<=a_reg xor b_reg;
with b_reg(4 downto 0) select a_rot<=ab_xor(30 downto 0) & ab_xor(31)when"00001",
ab_xor(29 downto 0)&ab_xor(31 downto 30) when"00010",
ab_xor(28 downto 0)&ab_xor(31 downto 29)when"00011",
ab_xor(27 downto 0)&ab_xor(31 downto 28)when"00100",
ab_xor(26 downto 0)&ab_xor(31 downto 27)when"00101",
ab_xor(25 downto 0)&ab_xor(31 downto 26)when"00110",
ab_xor(24 downto 0)&ab_xor(31 downto 25)when"00111",
ab_xor(23 downto 0)&ab_xor(31 downto 24)when"01000",
ab_xor(22 downto 0)&ab_xor(31 downto 23)when"01001",
ab_xor(21 downto 0)&ab_xor(31 downto 22)when"01010",
ab_xor(20 downto 0)&ab_xor(31 downto 21)when"01011",
ab_xor(19 downto 0)&ab_xor(31 downto 20)when"01100",
ab_xor(18 downto 0)&ab_xor(31 downto 19)when"01101",
ab_xor(17 downto 0)&ab_xor(31 downto 18)when"01110",
ab_xor(16 downto 0)&ab_xor(31 downto 17)when"01111",
ab_xor(15 downto 0)&ab_xor(31 downto 16)when"10000",
ab_xor(14 downto 0)&ab_xor(31 downto 15)when"10001",
ab_xor(13 downto 0)&ab_xor(31 downto 14)when"10010",
ab_xor(12 downto 0)&ab_xor(31 downto 13)when"10011",
ab_xor(11 downto 0)&ab_xor(31 downto 12)when"10100",
ab_xor(10 downto 0)&ab_xor(31 downto 11)when"10101",
ab_xor(9 downto 0)&ab_xor(31 downto 10)when"10110",
ab_xor(8 downto 0)&ab_xor(31 downto 9)when"10111",
ab_xor(7 downto 0)&ab_xor(31 downto 8)when"11000",
ab_xor(6 downto 0)&ab_xor(31 downto 7)when"11001",
ab_xor(5 downto 0)&ab_xor(31 downto 6)when"11010",
ab_xor(4 downto 0)&ab_xor(31 downto 5)when"11011",
ab_xor(3 downto 0)&ab_xor(31 downto 4)when"11100",
ab_xor(2 downto 0)&ab_xor(31 downto 3)when"11101",
ab_xor(1 downto 0)&ab_xor(31 downto 2)when"11110",
ab_xor(0)&ab_xor(31 downto 1)when"11111",
ab_xor when others;
a<=a_rot+skey(conv_integer((count&"0")));
--B operation
ba_xor<=a xor b_reg;
with a(4 downto 0) select b_rot<=ba_xor(30 downto 0) & ba_xor(31)when"00001",
ba_xor(29 downto 0)&ba_xor(31 downto 30) when"00010",
ba_xor(28 downto 0)&ba_xor(31 downto 29)when"00011",
ba_xor(27 downto 0)&ba_xor(31 downto 28)when"00100",
ba_xor(26 downto 0)&ba_xor(31 downto 27)when"00101",
ba_xor(25 downto 0)&ba_xor(31 downto 26)when"00110",
ba_xor(24 downto 0)&ba_xor(31 downto 25)when"00111",
ba_xor(23 downto 0)&ba_xor(31 downto 24)when"01000",
ba_xor(22 downto 0)&ba_xor(31 downto 23)when"01001",
ba_xor(21 downto 0)&ba_xor(31 downto 22)when"01010",
ba_xor(20 downto 0)&ba_xor(31 downto 21)when"01011",
ba_xor(19 downto 0)&ba_xor(31 downto 20)when"01100",
ba_xor(18 downto 0)&ba_xor(31 downto 19)when"01101",
ba_xor(17 downto 0)&ba_xor(31 downto 18)when"01110",
ba_xor(16 downto 0)&ba_xor(31 downto 17)when"01111",
ba_xor(15 downto 0)&ba_xor(31 downto 16)when"10000",
ba_xor(14 downto 0)&ba_xor(31 downto 15)when"10001",
ba_xor(13 downto 0)&ba_xor(31 downto 14)when"10010",
ba_xor(12 downto 0)&ba_xor(31 downto 13)when"10011",
ba_xor(11 downto 0)&ba_xor(31 downto 12)when"10100",
ba_xor(10 downto 0)&ba_xor(31 downto 11)when"10101",
ba_xor(9 downto 0)&ba_xor(31 downto 10)when"10110",
ba_xor(8 downto 0)&ba_xor(31 downto 9)when"10111",
ba_xor(7 downto 0)&ba_xor(31 downto 8)when"11000",
ba_xor(6 downto 0)&ba_xor(31 downto 7)when"11001",
ba_xor(5 downto 0)&ba_xor(31 downto 6)when"11010",
ba_xor(4 downto 0)&ba_xor(31 downto 5)when"11011",
ba_xor(3 downto 0)&ba_xor(31 downto 4)when"11100",
ba_xor(2 downto 0)&ba_xor(31 downto 3)when"11101",
ba_xor(1 downto 0)&ba_xor(31 downto 2)when"11110",
ba_xor(0)&ba_xor(31 downto 1)when"11111",
ba_xor when others;
b<=b_rot+skey(conv_integer((count&"1")));
           
    --Register A and B
    process(clk,rst) begin
        if(rst='0') then b_reg<=d_in(31 downto 0);
        elsif(clk'event and clk='1') then b_reg<=b;
        end if;
    end process;
    process(clk,rst) begin
        if(rst='0') then a_reg <= d_in(63 downto 32);
        elsif(clk'event and clk='1') then a_reg<=a;
        end if;
    end process;

    process(rst, clk)
    Begin
        if(rst='0') then
            count<="0001";
        elsif(clk'event and clk='1') then
            if(count>="1100") then
                count<="0001";
                d_out<=a&b;
            else
                count<=count+'1';
            end if;
        end if;
    end process;

end Behavioral;
