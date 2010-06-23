--
-- SYS09BUG MONITOR ROM FOR SYSTEM09 SPARTAN3E
-- John Kent
-- 8th January 2008
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
       addr  : in  std_logic_vector (10 downto 0);
       rdata : out std_logic_vector (7 downto 0);
       wdata : in  std_logic_vector (7 downto 0)
    );
end mon_rom;

architecture rtl of mon_rom is

signal we : std_logic;
signal dp : std_logic;

begin

  MON_ROM : RAMB16_S9
    generic map ( 
    INIT_00 => x"A780A610C6C07F8E1060FE8EE1FE0DFB11FB82FBBDFCA8FC8AFC90FC4BF814F8",
    INIT_01 => x"17431FE4A7D0866AAFDD8C30FB265AE26F0CC6450117D07FBF00E08EF9265AA0",
    INIT_02 => x"092C2081891FF1270D817F843C0417BC021795FE8EDE01173A031770FE8E8E04",
    INIT_03 => x"FE8C02300F2780E12AFE8E20C0022F60C14C0417510417408B981F5804175E86",
    INIT_04 => x"1F6E02179DFE8E121F2D297403173B341FBC2094ADC020F9021797FE8EF52660",
    INIT_05 => x"17275E81DD271881E127088111286703170C0417AE0317A4A6140417AE031721",
    INIT_06 => x"321FAB0217BE203F31C2202131EA03173F86ED03170827A4A1A4A7390F260D81",
    INIT_07 => x"F0C4201F0634F0C41000C3101F390124E1AC2034062914031705201F30C07F8E",
    INIT_08 => x"10C69B0317370317E4AEF701179DFE8E103439623203279F03170527E4AC011F",
    INIT_09 => x"03172E8602237E810425208180A610C6E1AE8B0317F5265A93031735031780A6",
    INIT_0a => x"273F8184A60F2710355B8DFFFF8E10341A24C07F8C1E29C00217BC20EE265A7C",
    INIT_0b => x"431F39FB265A1E8D08C6D37F8E104B03163F864E03173984A73F86A4AFA0A709",
    INIT_0c => x"A60A24C07F8C21AEB3FE16ED7FBF00008E5102170C8D4AAF04272C8D1F304AAE",
    INIT_0d => x"265A0427A1ACA0A608C6D37F8E1039A0A7A0A7A0A7FF8684A7A4A604263F8184",
    INIT_0e => x"7FBFE7F98EEB7FBFC07FBEED7FBF1429390217EE02171C295F0117393D3139F7",
    INIT_0f => x"27ED7FBE24273F8184A64AAEEC011770E0B671E0B73686431F392020450017C0",
    INIT_10 => x"3B71E0B73F8673E0B7368670E0B671E0B7368670E0B70D86341FED7FBF1F301F",
    INIT_11 => x"B7368672E0B7008670E0B7FF8673E0B73A8671E0B7328622FE16C07FBFEB7FBE",
    INIT_12 => x"81260217D27F7F6402171186D2FCBD8435FD265A20C604343973E0B73E8671E0",
    INIT_13 => x"E0EBE0E61034212991011726290234A80117F12631813D2739811F0217F92653",
    INIT_14 => x"FFC102355FEB2080A70527E46AE0EB02340C2904358E01170434E46AE46AE4EB",
    INIT_15 => x"E4AF0130492562AC4D2930344A0117E26F0E02161386D27F731602173F86BA27",
    INIT_16 => x"03CB2F0017DEFE8E64E720C6022320008310062762A3E4ECF501171286D2FCBD",
    INIT_17 => x"AF5B0117981F53F526646A65011780A684EB63EB62EB68011762AE750117981F",
    INIT_18 => x"00169D011690356900178FFE8E10347120028D396532B301171486C326E4AC62",
    INIT_19 => x"8DDC8D728D3948AF0229EB8DE78D618D394AAF0229F68DF28D910017E50016F8",
    INIT_1a => x"BB8D6C8D3943A70229C78DC68D498D3944AF0229D58DD18D5E8D3946AF0229E0",
    INIT_1b => x"1739C4A7808A0429A68DA58D5F8D3941A70229B18DB08D588D3942A70229BC8D",
    INIT_1c => x"8DBFFE8EF42048AEEA8DADFE8EBF0016311FF48DA1FE8E39F726048180A63B01",
    INIT_1d => x"204AAEC58DA7FE8ED82046AECE8DB3FE8EE12044AED78DB9FE8EB4001643A6E1",
    INIT_1e => x"900016D6FE8EC4A6AA8DCFFE8ED02042A6B38DCAFE8ED92041A6BC8DC5FE8ECF",
    INIT_1f => x"098DD520CE8DC78DC08D17FF179DFE8EBF8DB88DB08DA98DA18D27FF179DFE8E",
    INIT_20 => x"4848483229118D903561A710343C29088D011F42290E8DB400172D86121F4D29",
    INIT_21 => x"22468112254181393080032239811D253081578D39E0AB04342829078D891F48",
    INIT_22 => x"4444444402340235028D0235103439021A395780032266810725618139378003",
    INIT_23 => x"3B8D3F8D2D860225E46880A608C602344D20078B022F3981308B0F840235048D",
    INIT_24 => x"84A620E08E0926018584A6D07FBE10342D207F84048D0627D27F7D8235F1265A",
    INIT_25 => x"34458D2086008D8235018520E0B605260185D07F9FA60234903501A6EE270185",
    INIT_26 => x"86016D84A7118684A70386D07FBE138D903501A70235FA27028584A6D07FBE12",
    INIT_27 => x"1B86F27F7F01E702C6F17FFD04E703E702A7EF7FFD0000CC30E08E39D27FB7FF",
    INIT_28 => x"35C5001784A70520098D042420810D20748D0427F27F7D30E08E16345986028D",
    INIT_29 => x"81990027100D814500271016818E0027101A816C0027101B8141002710088196",
    INIT_2a => x"5DEF7FFC9900168300261019C15CEF7FFC51260A81110027100B812C0027100C",
    INIT_2b => x"00CC5B00162500271050814CEF7FB66800164A3327EF7FB67400165A3C002710",
    INIT_2c => x"F27F7F39F27FB704263D81312754816E002710598116273DC1F27FF658001600",
    INIT_2d => x"20E12218C120C0F17F7FF17FF6ED224F812080F27F7F39F17FB70426F17F7D39",
    INIT_2e => x"A7EF7FFDF07FF64F39F27F7FF726508102A74C84E720C6EF7FB6168D0000CC1B",
    INIT_2f => x"F604E75F012519C15C04E6E78D5AEA2619C15C4FF02650814CEF7FFC3903E702",
    INIT_30 => x"E4205F03E7F07FF7082719C15CF07FF6F42650C15C84A702E7EF7FF72086EF7F",
    INIT_31 => x"1946FB1830FB1524FB1051FB0472FB035CFB0267FB0139F27FF702E7EF7FF75F",
    INIT_32 => x"C5F95472F958DBF853E0FB5292F84DAFFA5051FA4C8FF847E7F84546F9423BFB",
    INIT_33 => x"2E312047554239305359530000000A0DFFFFFFFF7EF991F891F891F891F87EF9",
    INIT_34 => x"202D20043F54414857043E040000000A0D4B04202D202045335320524F462034",
    INIT_35 => x"20043D58492020043D59492020043D53552020043D43502020043D5053202004",
    INIT_36 => x"315343565A4E4948464504203A43432020043D422020043D412020043D504420",
    INIT_37 => x"9F6EC87F9F6EC67F9F6EC47F9F6EC07F9F6E26F916D27FF7535FC07FCE103904",
    INIT_38 => x"C4EC10340822CE7FBC8B300F27FFFF8CCC7FBE49584F4AAF80E64AAE431FCA7F",
    INIT_39 => x"0000000000000000000000000000000000000000C27F9F6E42EE1F37F16E44AE",
    INIT_3a => x"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3b => x"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3c => x"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3d => x"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3e => x"0000000000000000000000000000000000000000000000000000000000000000",
    INIT_3f => x"E2FEEEFEFEFEFAFEF6FEF2FE02FFEEFE00000000000000000000000000000000"
    )

    port map (
	  do   => rdata,
	  dop(0) => dp,
	  addr => addr,
	  clk  => clk,
     di   => wdata,
	  dip(0) => dp,
	  en   => cs,
	  ssr  => rst,
	  we   => we
	);

my_sbug : process ( rw )
begin
	 we    <= not rw;
end process;

end architecture rtl;
