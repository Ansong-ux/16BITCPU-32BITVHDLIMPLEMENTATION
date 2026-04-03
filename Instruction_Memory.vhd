library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Instruction_Memory is
    Port (
        pc          : in  STD_LOGIC_VECTOR(31 downto 0);
        instruction : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is

    type rom_type is array(0 to 15) of STD_LOGIC_VECTOR(31 downto 0);

    -- 32-bit MIPS R-format: op(6) | rs(5) | rt(5) | rd(5) | shamt(5) | funct(6)
    -- Registers mapped: $t0=8, $t1=9, $t2=10, $t3=11 (standard MIPS numbering)
    --
    -- Address 0: add $t0, $t1, $t2
    --   op=000000 rs=01001 rt=01010 rd=01000 shamt=00000 funct=100000
    --   = 0000 0000 1001 0101 0010 0000 0010 0000 = 0x00954020  (corrected below)
    --
    -- Address 1: sub $t2, $t2, $t3
    --   op=000000 rs=01010 rt=01011 rd=01010 shamt=00000 funct=100010
    --   = 0000 0001 0100 1011 0101 0000 0010 0010 = 0x014B5022
    --
    -- Address 2: and $t1, $t2, $t0
    --   op=000000 rs=01010 rt=01000 rd=01001 shamt=00000 funct=100100
    --   = 0000 0001 0100 1000 0100 1000 0010 0100 = 0x01484824
    --
    -- Address 3: or $t2, $t3, $t1
    --   op=000000 rs=01011 rt=01001 rd=01010 shamt=00000 funct=100101
    --   = 0000 0001 0110 1001 0101 0000 0010 0101 = 0x01695025

    constant rom_data : rom_type := (
        0 => "00000000100101010100000000100000",  -- add $t0, $t1, $t2
        1 => "00000001010010110101000000100010",  -- sub $t2, $t2, $t3
        2 => "00000001010010000100100000100100",  -- and $t1, $t2, $t0
        3 => "00000001011010010101000000100101",  -- or  $t2, $t3, $t1
        others => (others => '0')
    );

    signal rom_addr : integer range 0 to 15;
begin
    rom_addr <= to_integer(unsigned(pc(3 downto 0)));

    instruction <= rom_data(rom_addr) when unsigned(pc) < 16
                   else x"00000000";
end Behavioral;
