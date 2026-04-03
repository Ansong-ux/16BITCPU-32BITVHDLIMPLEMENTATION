library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Data_Memory is
    Port (
        clk             : in  STD_LOGIC;
        mem_access_addr : in  STD_LOGIC_VECTOR(31 downto 0);
        mem_write_data  : in  STD_LOGIC_VECTOR(31 downto 0);
        mem_write_en    : in  STD_LOGIC;
        mem_read        : in  STD_LOGIC;
        mem_read_data   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end Data_Memory;

architecture Behavioral of Data_Memory is
    type data_mem_type is array(0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal RAM      : data_mem_type := (others => (others => '0'));
    signal ram_addr : STD_LOGIC_VECTOR(7 downto 0);
begin
    ram_addr <= mem_access_addr(7 downto 0);

    process(clk)
    begin
        if rising_edge(clk) then
            if mem_write_en = '1' then
                RAM(to_integer(unsigned(ram_addr))) <= mem_write_data;
            end if;
        end if;
    end process;

    mem_read_data <= RAM(to_integer(unsigned(ram_addr))) when mem_read = '1'
                     else (others => '0');
end Behavioral;
