library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registerunit is
	port(
		Read_register1  : in std_logic_vector(4 downto 0);
		Read_register2  : in std_logic_vector(4 downto 0);
		Write_register  : in std_logic_vector(4 downto 0);
		Write_data 		 : in std_logic_vector(31 downto 0);
		RegWrite			 : in std_logic;
		Reg2Loc         : in std_logic;
		Read_data1		 : out std_logic_vector(31 downto 0);
		Read_data2		 : out std_logic_vector(31 downto 0);
		clk     			 : in std_logic;
		reset   			 : in std_logic
	);
end registerunit;

architecture Behavioral of registerunit is

TYPE ram_memory IS ARRAY ( 2**5 - 1 downto 0 ) OF std_logic_vector(31 downto 0);

signal bank: ram_memory:=(others=>"00000000000000000000000000000001");

begin

Registros : process (clk, Write_register, RegWrite, Write_data, reset) is
begin
	if reset = '1' then
		bank <= (others=>std_logic_vector(to_unsigned(0,32)));
	elsif (rising_edge(clk) and RegWrite = '1' and to_integer(unsigned(Write_register))/=0) then
		bank(to_integer(unsigned(Write_register))) <= Write_data;
	end if;
end process Registros;
Read_data1 <= bank(to_integer(unsigned(Read_register1)));
Read_data2 <= bank(to_integer(unsigned(Read_register2)));	

end Behavioral;