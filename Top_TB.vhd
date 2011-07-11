Library IEEE;

Use ieee.std_logic_1164.all;

Entity Top_TB is
End Entity Top_TB;

Architecture stimulus of Top_TB is

Signal nClk, nPOR, nMON, nKON, nESTOP				:	STD_LOGIC:= '0';
Signal nKMM, nKOM, nMIL									: 	STD_Logic:= '1';

Constant period:		Time :=20ns;

Component Top
	Port
	(
	KMM, KOM, MIL, CLOCK_50, POR, ESTOP	:	IN STD_LOGIC;
	KAV, MIV										:	OUT STD_LOGIC
	);
	
End Component Top;

Begin

DUT: Top Port Map
		(
		KMM => nKMM,
		KOM => nKOM,
		MIL => nMIL,
		CLOCK_50 => nClk,
		POR => nPOR,
		ESTOP => nESTOP,
		KAV => nKON,
		MIV => nMON
		);

		generate_clock		: Process (nClk)
			Begin
					nClk <= NOT nClk After period/2;
			End Process;
			
nPOR <= '1', '0' after 20ns;

nKOM <= '1', '0' after 50ns, '1' after 100ns;

End Architecture stimulus;
	
				