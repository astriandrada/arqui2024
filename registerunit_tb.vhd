LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY registerunit_tb IS
END registerunit_tb;
 
ARCHITECTURE behavior OF registerunit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerunit
    PORT(
         Read_register1 : IN  std_logic_vector(4 downto 0);
         Read_register2 : IN  std_logic_vector(4 downto 0);
         Write_register : IN  std_logic_vector(4 downto 0);
         Write_data : IN  std_logic_vector(31 downto 0);
         RegWrite : IN  std_logic;
         Reg2Loc : IN  std_logic;
         Read_data1 : OUT  std_logic_vector(31 downto 0);
         Read_data2 : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Read_register1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Read_register2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Write_register : std_logic_vector(4 downto 0) := (others => '0');
   signal Write_data : std_logic_vector(31 downto 0) := (others => '0');
   signal RegWrite : std_logic := '0';
   signal Reg2Loc : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal Read_data1 : std_logic_vector(31 downto 0);
   signal Read_data2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerunit PORT MAP (
          Read_register1 => Read_register1,
          Read_register2 => Read_register2,
          Write_register => Write_register,
          Write_data => Write_data,
          RegWrite => RegWrite,
          Reg2Loc => Reg2Loc,
          Read_data1 => Read_data1,
          Read_data2 => Read_data2,
          clk => clk,
          reset => reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 


	-- Stimulus process
	stim_proc: process
	begin
		 -- Inicialización de señales
		 Read_register1 <= "00000";
		 Read_register2 <= "00000";
		 Write_register <= "00000";
		 Reg2Loc <= '0';
		 Write_data <= "00000000000000000000000000000001";
		 RegWrite <= '1';
		 wait for 7.5 ns;

		 -- Bucle for para los ciclos de prueba
		 for i in 1 to 31 loop
			  -- Convertir el índice del bucle en una representación binaria de 5 bits
			  Read_register1 <= std_logic_vector(to_unsigned(i, 5));
			  Read_register2 <= std_logic_vector(to_unsigned(i - 1, 5));
			  Write_register <= std_logic_vector(to_unsigned(i, 5));
				Write_data <= std_logic_vector(to_unsigned(2**(i-1), 32));  -- Generar potencias de 2 en formato binario
			  wait for 10 ns;
		 end loop;
		 wait for 10 ns;
		 Reg2Loc <= '1';
		 wait for 10 ns;
		 Write_register <= "00100";
		 RegWrite <= '0';
		 Write_data <= "10101010101010101010101010101010";
		 wait for 10 ns;
		 reset <= '1';
		 wait;
	end process;

END;
