library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_File_tb is
end Register_File_tb;

architecture test of Register_File_tb is
    component Register_File
        Port (
            clk             : in  STD_LOGIC;
            rst             : in  STD_LOGIC;
            reg_write_en    : in  STD_LOGIC;
            reg_write_dest  : in  STD_LOGIC_VECTOR(2 downto 0);
            reg_write_data  : in  STD_LOGIC_VECTOR(31 downto 0);
            reg_read_addr_1 : in  STD_LOGIC_VECTOR(2 downto 0);
            reg_read_addr_2 : in  STD_LOGIC_VECTOR(2 downto 0);
            reg_read_data_1 : out STD_LOGIC_VECTOR(31 downto 0);
            reg_read_data_2 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal clk             : STD_LOGIC := '0';
    signal rst             : STD_LOGIC := '0';
    signal reg_write_en    : STD_LOGIC := '0';
    signal reg_write_dest  : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal reg_write_data  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal reg_read_addr_1 : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal reg_read_addr_2 : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal reg_read_data_1 : STD_LOGIC_VECTOR(31 downto 0);
    signal reg_read_data_2 : STD_LOGIC_VECTOR(31 downto 0);

    constant CLK_PERIOD : time := 10 ns;
begin
    uut: Register_File port map(
        clk             => clk,
        rst             => rst,
        reg_write_en    => reg_write_en,
        reg_write_dest  => reg_write_dest,
        reg_write_data  => reg_write_data,
        reg_read_addr_1 => reg_read_addr_1,
        reg_read_addr_2 => reg_read_addr_2,
        reg_read_data_1 => reg_read_data_1,
        reg_read_data_2 => reg_read_data_2
    );

    clk_process: process
    begin
        clk <= '0'; wait for CLK_PERIOD / 2;
        clk <= '1'; wait for CLK_PERIOD / 2;
    end process;

    process
    begin
        -- Reset registers to defaults
        rst <= '1'; wait for CLK_PERIOD;
        rst <= '0'; wait for CLK_PERIOD;

        reg_write_en <= '1';

        -- Write Register 1: 1934858 = 0x001D8A8A
        reg_write_dest <= "001";
        reg_write_data <= x"001D8A8A";
        wait for CLK_PERIOD;

        -- Write Register 3: 8558447 = 0x008294EF
        reg_write_dest <= "011";
        reg_write_data <= x"008294EF";
        wait for CLK_PERIOD;

        -- Write Register 5: 203848544 = 0x0C2637A0
        reg_write_dest <= "101";
        reg_write_data <= x"0C2637A0";
        wait for CLK_PERIOD;

        -- Write Register 7: 20670420 = 0x013B9F54
        reg_write_dest <= "111";
        reg_write_data <= x"013B9F54";
        wait for CLK_PERIOD;

        -- Stop writing
        reg_write_en <= '0';
        wait for CLK_PERIOD;

        -- Read Register 1 and Register 3
        reg_read_addr_1 <= "001";
        reg_read_addr_2 <= "011";
        wait for CLK_PERIOD;

        -- Read Register 5 and Register 7
        reg_read_addr_1 <= "101";
        reg_read_addr_2 <= "111";
        wait for CLK_PERIOD;

        wait;
    end process;
end test;
