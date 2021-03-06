--
-- SYS09BUG Monitor Program
-- v1.0 - 21 November 2006 - John Knet
--
-- v1.1 - 22 december 2006 - John Kent
--        made into 4K ROM/RAM.
-- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
library unisim;
	use unisim.vcomponents.all;

entity mon_rom is
    Port (
       clk   : in  std_logic;
		 rst   : in  std_logic;
		 cs    : in  std_logic;
		 rw    : in  std_logic;
       addr  : in  std_logic_vector (11 downto 0);
       rdata : out std_logic_vector (7 downto 0);
       wdata : in  std_logic_vector (7 downto 0)
    );
end mon_rom;

architecture rtl of mon_rom is

  signal we     : std_logic;
  signal cs0    : std_logic;
  signal cs1    : std_logic;
  signal dp0    : std_logic;
  signal dp1    : std_logic;
  signal rdata0 : std_logic_vector(7 downto 0);
  signal rdata1 : std_logic_vector(7 downto 0);

component SYS09BUG_F000
    Port (
       clk   : in  std_logic;
       rst   : in  std_logic;
       cs    : in  std_logic;
       rw    : in  std_logic;
       addr  : in  std_logic_vector (10 downto 0);
       rdata : out std_logic_vector (7 downto 0);
       wdata : in  std_logic_vector (7 downto 0)
    );
end component;

component SYS09BUG_F800
    Port (
       clk   : in  std_logic;
       rst   : in  std_logic;
       cs    : in  std_logic;
       rw    : in  std_logic;
       addr  : in  std_logic_vector (10 downto 0);
       rdata : out std_logic_vector (7 downto 0);
       wdata : in  std_logic_vector (7 downto 0)
    );
end component;

begin

   addr_f000 : SYS09BUG_F000 port map (
       clk   => clk,
       rst   => rst,
       cs    => cs0,
       rw    => rw,
       addr  => addr(10 downto 0),
       wdata => wdata,
       rdata => rdata0
    );

   addr_f800 : SYS09BUG_F800 port map (
       clk   => clk,
       rst   => rst,
       cs    => cs1,
       rw    => rw,
       addr  => addr(10 downto 0),
       wdata => wdata,
       rdata => rdata1
    );

my_mon : process ( rw, addr, cs, rdata0, rdata1 )
begin
	 we    <= not rw;
	 case addr(11) is
	 when '0' =>
	   cs0   <= cs;
		cs1   <= '0';
		rdata <= rdata0;
    when '1' =>
	   cs0   <= '0';
		cs1   <= cs;
		rdata <= rdata1;
    when others =>
      null;
    end case;		
		
end process;

end architecture rtl;

