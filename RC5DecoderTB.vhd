


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RC5DecoderTB is
--  Port ( );
end RC5DecoderTB;

architecture Behavioral of RC5DecoderTB is
signal d_in:std_logic_vector(63 downto 0);
signal d_out:std_logic_vector(63 downto 0);
signal rst :std_logic;
signal clk :std_logic;
file file_pointer:text ;
begin
dut:entity work.RC5Decoder port map(
clk=>clk,
rst=>rst,
d_in=>d_in,
d_out=>d_out
);

clk_process : process
    begin
        clk <= '0';
        wait for 25ns;
        clk <= '1';
        wait for 25ns;
    end process;
---Please comment below if you want to use clr in Run_Test process
clr_process : process
    begin
        rst <= '0';
        wait for 25ns;
        rst <= '1';
        wait for 575ns;
    end process;
Run_Test : process
variable file_line:line;
variable file_in:std_logic_vector(63 downto 0);
variable file_out:std_logic_vector(63 downto 0);
variable line_space:character;
begin
file_open(file_pointer,"encoded_message.mem",read_mode);
while not endfile(file_pointer)loop
readline(file_pointer,file_line);
hread(file_line,file_in);
read(file_line,line_space);
hread(file_line,file_out);
d_in<=file_in;
wait for 1150ns;

assert(d_out=file_out)report"The output does not match the expected value"severity failure;
end loop;
report"All test cases passed successfully";
std.env.stop;
end process;
end Behavioral;
