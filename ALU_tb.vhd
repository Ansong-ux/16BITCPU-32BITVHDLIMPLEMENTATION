library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tb is
end ALU_tb;

architecture test of ALU_tb is
    component ALU
        Port (
            a           : in  STD_LOGIC_VECTOR(31 downto 0);
            b           : in  STD_LOGIC_VECTOR(31 downto 0);
            alu_control : in  STD_LOGIC_VECTOR(2 downto 0);
            alu_result  : out STD_LOGIC_VECTOR(31 downto 0);
            zero        : out STD_LOGIC
        );
    end component;

    signal a           : STD_LOGIC_VECTOR(31 downto 0);
    signal b           : STD_LOGIC_VECTOR(31 downto 0);
    signal alu_control : STD_LOGIC_VECTOR(2 downto 0);
    signal alu_result  : STD_LOGIC_VECTOR(31 downto 0);
    signal zero        : STD_LOGIC;
begin
    uut: ALU port map(
        a           => a,
        b           => b,
        alu_control => alu_control,
        alu_result  => alu_result,
        zero        => zero
    );

    process
    begin
        -- i. ADD: 2500 + 25000 = 27500 (0x00006B6C)
        a <= x"000009C4"; b <= x"000061A8"; alu_control <= "000"; wait for 10 ns;
        -- ii. SUB: 540250 - 37800 = 502450 (0x0007A8B2)
        a <= x"00083BFA"; b <= x"00009348"; alu_control <= "001"; wait for 10 ns;
        -- iii. AND: 53957 & 30000 = 20528 (0x00005030)
        a <= x"0000D2F5"; b <= x"00007530"; alu_control <= "010"; wait for 10 ns;
        -- iv. OR: 746353 | 846465 = 1044449 (0x000FEBE1)
        a <= x"000B63C1"; b <= x"000CE9A1"; alu_control <= "011"; wait for 10 ns;
        -- v. SLT: 58847537 < 72464383 => result=1
        a <= x"0382A1F1"; b <= x"0452B3FF"; alu_control <= "100"; wait for 10 ns;
        wait;
    end process;
end test;
