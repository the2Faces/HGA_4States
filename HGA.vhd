Library IEEE;
Use ieee.std_logic_1164.all;

Entity HGA is
	Port (
			POR, KMM, KOM, MIL, ASTOP, ESTOP, Clk		:	IN std_logic;
			START, HLF, KAV, MIV								:	Out std_logic
			);
			
End Entity;

Architecture beh of HGA is

	Type states is (IGZ, KMMZ, KOMZ, MILZ);
	Signal current_state, next_state	:	states;
	Signal STOP, KMMi, KOMi, MILi , Make50p , ButtonEN	:	STD_LOGIC;
		
	Begin
	
	STOP <= ASTOP or ESTOP;
	KMMi <= KMM and ButtonEN;
	KOMi <= KOM and ButtonEN;
	MILi <= MIL and ButtonEN;

	
		next_state_register	:	Process (POR, Clk)
		
		Begin
			IF (POR = '1') Then
				current_state <= IGZ;
				Elsif (Clk'Event and Clk = '1') Then
					current_state <= next_state;
			End IF;
		End Process;
		
		next_state_logic		:	Process (KMMi, KOMi, MILi, STOP, Make50p, current_state)
		Begin
			Case current_state is
			
				When IGZ =>
					IF (KMMi = '1') Then
						next_state <= KMMZ;
					Elsif (KOMi = '1') Then
						next_state <= KOMZ;
					Elsif	(MILi = '1') Then
						next_state <= MILZ;
					Else next_state <= IGZ;
					End IF;
					
				When	KMMZ =>
					IF (STOP = '1') THEN
						next_state <= IGZ;
					Elsif (STOP = '1' and Make50p = '1') THEN
						next_state <= MILZ;
					Else next_state <= KMMZ;
					End IF;
							
				WHEN KOMZ =>
					IF (STOP = '1') THEN
						next_state <= IGZ;
					Else next_state <= KOMZ;
					END IF;
					
				WHEN MILZ =>
					IF (STOP = '1') THEN
						next_state <= IGZ;
					Else next_state <= MILZ;
					END IF;
					
			End Case;
	End Process next_state_logic;
	
	output_logic	:	Process (current_state)
	Begin
		Case current_state is
			
			WHEN IGZ =>
				ButtonEN	<= '1';
				Make50p 	<= '0';
				START		<= '0';
				KAV 		<= '0';
				MIV			<= '0';
				
			WHEN KMMZ =>
				ButtonEN	<= '0';
				Make50p		<= '1';
				START 		<= '1';
				KAV			<= '1';
				MIV			<= '0';
				
			WHEN KOMZ =>
				ButtonEN	<= '0';
				START 		<= '1';
				KAV			<= '1';
				MIV			<= '0';
				
			WHEN MILZ =>
				ButtonEN 	<= '0';
				START 		<= '1';
				KAV 		<= '0';
				MIV			<= '1';
					
		END CASE;
	END Process;	
	
HLF <= Make50p;


	
End Architecture beh;		