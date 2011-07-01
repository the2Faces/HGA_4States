LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Frequenzteiler IS
	PORT
	(
	CLOCK_50, Reset : IN STD_LOGIC;
	Clk_En : OUT STD_LOGIC
	);
END ENTITY Frequenzteiler;

ARCHITECTURE beh OF Frequenzteiler IS

SIGNAL nClk_En : STD_LOGIC;
Signal counter	:	Natural Range 0 to 500 := 0;

BEGIN
Clk_En <= nClk_En;

freqt : PROCESS(CLOCK_50, Reset, counter)

	BEGIN
		IF Reset='1' THEN
			counter <= 0;
			nClk_En <= '0';
		ELSIF CLOCK_50'EVENT AND CLOCK_50 = '1' THEN
			counter <= counter + 1;
			nClk_En <= '0';
			IF counter = 500 THEN
				nClk_En <= '1';
				counter <= 0;
		END IF;
		END IF;

END PROCESS freqt;

END ARCHITECTURE beh;
	
	