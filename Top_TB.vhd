Library IEEE;

Use ieee.std_logic_1164.all;

Entity Top_TB is
End Entity Top_TB;

Architecture stimulus of Top_TB is

Signal nKMM, nKOM, nMIL, nClk, nPOR, nMON, nKON	:	STD_LOGIC:= '0';
Signal nESTOP												:	STD_LOGIC:= '0';

Constant period:		Time :=20ns;

Component Top
	Port
	(
	KMM, KOM, MIL, Clk, POR, ESTOP	:	IN STD_LOGIC;
	KON, MON									:	OUT STD_LOGIC
	);
	
End Component Top;

Begin

DUT: Top Port Map
		(
		KMM => nKMM,
		KOM => nKOM,
		MIL => nMIL,
		Clk => nClk,
		POR => nPOR,
		ESTOP => nESTOP,
		KON => nKON,
		MON => nMON
		);

		generate_clock		: Process (nClk)
			Begin
					nClk <= NOT nClk After period/2;
			End Process;
			
nPOR <= '1', '0' after 10ns;

nKMM <= '0', '1' after 50ns, '0' after 100ns;

End Architecture stimulus;
	
				