LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;


ENTITY entpreller2 IS

PORT (
	clk       : IN STD_LOGIC;		--50MHz Quartz
	buttonin  : IN STD_LOGIC;  	--Button input
	buttonout : OUT STD_LOGIC		--button output
);
END entpreller2;

ARCHITECTURE beh OF entpreller2 IS

	SIGNAL intout: 	STD_LOGIC := '0';		--interner Platzhalter
	SIGNAL count:	NATURAL RANGE 0 TO 50000 := 0;
	
BEGIN
	PROCESS BEGIN
		WAIT UNTIL clk'EVENT AND clk ='1';
		
		IF (buttonin=intout) THEN count <= 0;
		ELSE count<=count+1;
		END IF;
		
		IF (count=50000) THEN intout <= buttonin;
		END IF;
	END PROCESS;
	buttonout<= intout;
END beh;