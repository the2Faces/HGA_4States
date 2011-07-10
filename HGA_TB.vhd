Library IEEE;

USE ieee.std_logic_1164.all;

Entity HGA_TB is
End Entity;

Architecture stimulus of HGA_TB is

Signal nKMM, nKOM, nMIL, nClk, nPOR, nMIV, nKAV	: STD_LOGIC:='0';
Signal nESTOP, nASTOP	:	STD_LOGIC:='0';

constant period:	TIME:=20ns;

Component HGA is
Port
	(
	KMM, KOM, MIL, Clk, POR, ESTOP, ASTOP	:	IN STD_LOGIC;
	MIV, KAV											: OUT STD_LOGIC
	);
END COMPONENT HGA;

Begin
	
	DUT:	HGA PORT MAP
			(
			KMM => nKMM,
			KOM => nKOM,
			MIL => nMIL,
			Clk => nClk,
			POR => nPOR,
			ESTOP => nESTOP,
			ASTOP => nASTOP,
			MIV => nMIV,
			KAV => nKAV
			);
			
			generate_clock		: Process (nClk)
				Begin
					nClk <= NOT nClk after period/2;
				END Process;
nPOR <= '1', '0' after 20ns;

nKMM <= '0', '1' after 50ns, '0' after 100ns;

nASTOP <= '0', '1' after 350ns, '0' after 370ns, '1' after 800ns, '0' after 820ns;

End Architecture stimulus;