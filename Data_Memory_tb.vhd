library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_Memory_tb is
end Data_Memory_tb;

architecture test of Data_Memory_tb is
    component Data_Memory
        Port (
            clk             : in  STD_LOGIC;
            mem_access_addr : in  STD_LOGIC_VECTOR(31 downto 0);
            mem_write_data  : in  STD_LOGIC_VECTOR(31 downto 0);
            mem_write_en    : in  STD_LOGIC;
            mem_read        : in  STD_LOGIC;
            mem_read_data   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal clk             : STD_LOGIC := '0';
    signal mem_access_addr : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal mem_write_data  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal mem_write_en    : STD_LOGIC := '0';
    signal mem_read        : STD_LOGIC := '0';
    signal mem_read_data   : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    uut: Data_Memory port map(
        clk             => clk,
        mem_access_addr => mem_access_addr,
        mem_write_data  => mem_write_data,
        mem_write_en    => mem_write_en,
        mem_read        => mem_read,
        mem_read_data   => mem_read_data
    );

    clk_process: process
    begin
        clk <= '0'; wait for CLK_PERIOD / 2;
        clk <= '1'; wait for CLK_PERIOD / 2;
    end process;

    process
    begin
        -- i. Write 1024 (0x00000400) into Address 2
        mem_access_addr <= x"00000002";
        mem_write_data  <= x"00000400";
        mem_write_en    <= '1';
        mem_read        <= '0';
        wait for CLK_PERIOD;

        -- Read back from Address 2
        mem_write_en    <= '0';
        mem_read        <= '1';
        wait for CLK_PERIOD;

        -- ii. Write 429496 (0x00068EB8) into Address 4
        mem_access_addr <= x"00000004";
        mem_write_data  <= x"00068EB8";
        mem_write_en    <= '1';
        mem_read        <= '0';
        wait for CLK_PERIOD;

        -- Read back from Address 4
        mem_write_en    <= '0';
        mem_read        <= '1';
        wait for CLK_PERIOD;

        wait;
    end process;
end test;
