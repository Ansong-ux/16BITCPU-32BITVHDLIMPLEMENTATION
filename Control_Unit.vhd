library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    Port (
        opcode       : in  STD_LOGIC_VECTOR(2 downto 0);
        reset        : in  STD_LOGIC;
        reg_dst      : out STD_LOGIC_VECTOR(1 downto 0);
        mem_to_reg   : out STD_LOGIC_VECTOR(1 downto 0);
        alu_op       : out STD_LOGIC_VECTOR(1 downto 0);
        jump         : out STD_LOGIC;
        branch       : out STD_LOGIC;
        mem_read     : out STD_LOGIC;
        mem_write    : out STD_LOGIC;
        alu_src      : out STD_LOGIC;
        reg_write    : out STD_LOGIC;
        sign_or_zero : out STD_LOGIC
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
begin
    process(reset, opcode)
    begin
        if reset = '1' then
            reg_dst      <= "00";
            mem_to_reg   <= "00";
            alu_op       <= "00";
            jump         <= '0';
            branch       <= '0';
            mem_read     <= '0';
            mem_write    <= '0';
            alu_src      <= '0';
            reg_write    <= '0';
            sign_or_zero <= '0';
        else
            case opcode is

                -- add / sub / and / or / slt  (R-type, opcode = 000)
                when "000" =>
                    reg_dst      <= "01";
                    mem_to_reg   <= "00";
                    alu_op       <= "10";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '0';
                    reg_write    <= '1';
                    sign_or_zero <= '0';

                -- addi (opcode = 001)
                when "001" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "11";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '1';
                    reg_write    <= '1';
                    sign_or_zero <= '1';

                -- j (opcode = 010)
                when "010" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "00";
                    jump         <= '1';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '0';
                    reg_write    <= '0';
                    sign_or_zero <= '0';

                -- jal (opcode = 011)
                when "011" =>
                    reg_dst      <= "10";
                    mem_to_reg   <= "10";
                    alu_op       <= "00";
                    jump         <= '1';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '0';
                    reg_write    <= '1';
                    sign_or_zero <= '0';

                -- lw (opcode = 100)
                when "100" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "01";
                    alu_op       <= "00";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '1';
                    mem_write    <= '0';
                    alu_src      <= '1';
                    reg_write    <= '1';
                    sign_or_zero <= '1';

                -- sw (opcode = 101)
                when "101" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "00";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '1';
                    alu_src      <= '1';
                    reg_write    <= '0';
                    sign_or_zero <= '1';

                -- beq (opcode = 110)
                when "110" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "01";
                    jump         <= '0';
                    branch       <= '1';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '0';
                    reg_write    <= '0';
                    sign_or_zero <= '1';

                -- slti (opcode = 111)
                when "111" =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "10";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '1';
                    reg_write    <= '1';
                    sign_or_zero <= '1';

                when others =>
                    reg_dst      <= "00";
                    mem_to_reg   <= "00";
                    alu_op       <= "00";
                    jump         <= '0';
                    branch       <= '0';
                    mem_read     <= '0';
                    mem_write    <= '0';
                    alu_src      <= '0';
                    reg_write    <= '0';
                    sign_or_zero <= '0';

            end case;
        end if;
    end process;
end Behavioral;
