----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:34:04 02/06/2014 
-- Design Name: 
-- Module Name:    DigitDriver - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DigitDriver is
    Port ( bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			  a,b,c,d,e,f,g : out  STD_LOGIC);
end DigitDriver;

architecture Behavioral of DigitDriver is

begin
	a<=bcd(1)or(bcd(2)and bcd(0)) or (bcd(3) and (not bcd(1))) or ( (not bcd(2)) and (not bcd(1)) and (not bcd(0)));
	b<=not bcd(2) or ((not bcd(1))and (not bcd(0))) or (bcd(1) and bcd(0));
	c<=bcd(3) or bcd(2) or not bcd(1) or bcd(0);
	d<=(bcd(1)and (not bcd(0))) or ((not bcd(2))and bcd(1) and bcd(0)) or (bcd(2) and (not bcd(1)) and bcd(0))or (not(bcd(2)or bcd(1)or bcd(0)));
	e<=(bcd(1)and (not(bcd(0)))) or not(bcd(2)or bcd(1)or bcd(0));
	f<=(bcd(2)and not(bcd(0))) or (bcd(2) and not(bcd(1))) or (not(bcd(1)or bcd(0))) or bcd(3);
	g<=(bcd(2)and not bcd(1)) or (bcd(1)and not bcd(0)) or ((not bcd(2)) and bcd(1)) or bcd(3);
end Behavioral;

