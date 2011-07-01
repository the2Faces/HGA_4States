-- dT-Zaehler

ENTITY dt_Zaehler IS
	
	PORT
	(
		CLK, POR, START, dt_50_50 : IN BIT;
		A_STOP : OUT BIT
	);
	
END dt_Zaehler;


ARCHITECTURE beh OF dt_Zaehler IS

	signal teiler : integer range 0 to 500000000;
	signal schritte_pro_sekunde : integer range 0 to 2;
	
BEGIN

	Faktor_Prozess: process (dt_50_50)
	begin
		if dt_50_50 = '0' then
				schritte_pro_sekunde <= 1; -- dT = 10s
		else 
				schritte_pro_sekunde <= 2; -- dT/2 = 5s
		end if;
	end process Faktor_Prozess;

	dt_Zaehler_Prozess: process (CLK, POR, START, teiler, schritte_pro_sekunde)
	begin
		if (POR = '1') then		-- asynchroner Reset
			teiler <= 0;
			A_STOP <= '1';
		elsif (CLK'event and CLK = '1') then
			if (START = '1') then
					if teiler = (500000000/schritte_pro_sekunde) then -- 10s oder 5s (bei CLK 50MHz)
						A_STOP <= '0';
					else
						teiler <= teiler + 1;
						A_STOP <= '1';
					end if;
			else 
				A_STOP <= '1';
				teiler <= 0; 
			end if;
		end if;
	end process dt_Zaehler_Prozess;

END beh;
