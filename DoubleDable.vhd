library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package bcd_funcs is
	function double_dabble (data:std_logic_vector(12 downto 0)) return std_logic_vector;
end;

package body bcd_funcs is	


function double_dabble (data:std_logic_vector(12 downto 0)) return std_logic_vector is
	variable i : integer:=0;
	variable bcd : std_logic_vector(28 downto 0);
begin
	bcd(12 downto 0) := data; 
	for i in 0 to 12 loop --for each bit in data
		
		--Add 3 to any BCD codes greater than 4
		if 	bcd(28 downto 25)>"0100" then
			bcd(28 downto 25) := bcd(28 downto 25)+3;
		end if;
		if bcd(24 downto 21)>"0100" then
			bcd(24 downto 21) := bcd(24 downto 21)+3;
		end if;
		if bcd(20 downto 17)>"0100" then
			bcd(20 downto 17) := bcd(20 downto 17)+3;
		end if;
		if bcd(16 downto 13)>"0100" then
			bcd(16 downto 13) := bcd(16 downto 13)+3;
		end if;
		
		--Shift BCD codes and original data
		bcd(28 downto 1) := bcd(27 downto 0);
		bcd(0) := '0';
		
	end loop;
	return bcd(28 downto 13);
end function;

end package body;