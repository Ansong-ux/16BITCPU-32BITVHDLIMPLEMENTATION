library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Memory_tb is
end Instruction_Memory_tb;

architecture test of Instruction_Memory_tb is
    component Instruction_Memory
        Port (
            pc          : in  STD_LOGIC_VECTOR(31 downto 0);
            instruction : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal pc          : STD_LOGIC_VECTOR(31 downto 0);
    signal instruction : STD_LOGIC_VECTOR(31 downto 0);
begin
    uut: Instruction_Memory port map(
        pc          => pc,
        instruction => instruction
    );

    process
    begin
        -- Address 0: add $t0, $t1, $t2
        pc <= x"00000000"; wait for 10 ns;
        -- Address 1: sub $t2, $t2, $t3
        pc <= x"00000001"; wait for 10 ns;
        -- Address 2: and $t1, $t2, $t0
        pc <= x"00000002"; wait for 10 ns;
        -- Address 3: or $t2, $t3, $t1
        pc <= x"00000003"; wait for 10 ns;
        -- Out of range - should output 0x00000000
        pc <= x"00000010"; wait for 10 ns;
        wait;
    end process;
end test;
