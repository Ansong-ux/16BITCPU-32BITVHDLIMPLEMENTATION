library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        a           : in  STD_LOGIC_VECTOR(31 downto 0);
        b           : in  STD_LOGIC_VECTOR(31 downto 0);
        alu_control : in  STD_LOGIC_VECTOR(2 downto 0);
        alu_result  : out STD_LOGIC_VECTOR(31 downto 0);
        zero        : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    signal result : STD_LOGIC_VECTOR(31 downto 0);
begin
    process(a, b, alu_control)
    begin
        case alu_control is
            when "000" => result <= std_logic_vector(unsigned(a) + unsigned(b));  -- ADD
            when "001" => result <= std_logic_vector(unsigned(a) - unsigned(b));  -- SUB
            when "010" => result <= a AND b;                                       -- AND
            when "011" => result <= a OR b;                                        -- OR
            when "100" =>                                                           -- SLT
                if unsigned(a) < unsigned(b) then
                    result <= x"00000001";
                else
                    result <= x"00000000";
                end if;
            when others => result <= std_logic_vector(unsigned(a) + unsigned(b));
        end case;
    end process;

    alu_result <= result;
    zero <= '1' when result = x"00000000" else '0';
end Behavioral;
