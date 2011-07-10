Library IEEE;

Use ieee.std_logic_1164.all;

Entity LTVC is
	
Port (
		KAV, MIV	:	IN STD_logic;
		KON, MON	:	Out STD_Logic
		);
		
End Entity LTVC;

Architecture beh of LTVC is

Begin
	
	KON 	<= 	KAV;
	MON	<=		MIV;
	
End Architecture beh;
