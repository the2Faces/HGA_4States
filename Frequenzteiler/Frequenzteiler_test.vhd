LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY Frequenzteiler_test IS
END ENTITY Frequenzteiler_test;

ARCHITECTURE stimulus OF Frequenzteiler_test IS

SIGNAL nRESET, nOUT : STD_LOGIC;
SIGNAL nCLOCK : STD_LOGIC := '0';
CONSTANT period : TIME :=20 ns;

COMPONENT Frequenzteiler
PORT
(
	CLOCK_50, Reset : IN STD_LOGIC;
	Clk_En : OUT STD_LOGIC
);
END COMPONENT Frequenzteiler;


BEGIN
	DUT : Frequenzteiler PORT MAP (CLOCK_50 => nCLOCK,Reset => nRESET, Clk_EN => nOUT);
	
generate_clock : PROCESS (nCLOCK)
	BEGIN
			nCLOCK <= NOT nCLOCK AFTER period/2;
	END PROCESS;
	
	nReset <= '1', '0' AFTER 10ns;
	
		
END ARCHITECTURE stimulus;