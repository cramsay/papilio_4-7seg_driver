library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.bcd_funcs.ALL;

entity DisplayDriver is
 Port ( Clk : in  STD_LOGIC;
		  a,b,c,d,e,f,g : out  STD_LOGIC;
		  dsel: out STD_LOGIC_VECTOR(3 downto 0));
end DisplayDriver;

architecture Behavioral of DisplayDriver is
	component DigitDriver is
		 Port ( bcd : in  STD_LOGIC_VECTOR(3 downto 0);
			  a,b,c,d,e,f,g : out  STD_LOGIC);
	end component;
	
	signal na,nb,nc,nd,ne,nf,ng : STD_LOGIC;
	signal bcd_sel: STD_LOGIC_VECTOR(3 downto 0):="0000";
	signal bcd_data: STD_LOGIC_VECTOR(15 downto 0);
	signal ccount: STD_LOGIC_VECTOR(37 downto 0);
	signal dselect: STD_LOGIC_VECTOR(3 downto 0):="0001";
	constant CCOUNT_PAD: STD_LOGIC_VECTOR(27 downto 0):=(others=>'0');
begin
	dsel<=dselect;
	
	--Effectively a multiplexer for picking
	--the correct BCD to be passed to the
	--display
	with dselect select
	bcd_sel<=bcd_data(15 downto 12) when "0001",
				bcd_data(11 downto 8) when "0010",
				bcd_data(7 downto 4) when "0100",
				bcd_data(3 downto 0) when others;
	
	--Digit driver component is needed to
	--translate the 4-bit BCD to the 7-seg
	--outputs
	DD1: DigitDriver port map(bcd=>bcd_sel,
									 a=>na,
									 b=>nb,
									 c=>nc,
									 d=>nd,
									 e=>ne,
									 f=>nf,
									 g=>ng);
	--The 'nX' signals are just a layer between
	--the DigitDriver outputs and actual display cathodes
	a<=not na;b<=not nb;c<=not nc;d<=not nd;e<=not ne;f<=not nf;g<=not ng;
	
	--Process to count system clock cycles.
	--Counter used to signal for dselect 
	--changes
	count_clk : process(Clk)
	begin
		if rising_edge(Clk) then
			ccount<=ccount+1;
		end if;
	end process;
	
	--Process to left rotate the one-hot
	--digit select bus. Not using the system
	--clock due to timming issues
	change_dselect : process(ccount(5))
	begin
		if rising_edge(ccount(5)) then
				dselect<=dselect(2 downto 0)&dselect(3);
				bcd_data<=double_dabble(ccount(35 downto 23));
		end if;
	end process;
	
end Behavioral;

