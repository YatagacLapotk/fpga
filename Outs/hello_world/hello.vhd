
use std.textio.all;


entity hello_world is
end entity;

architecture sim of hello_world is
begin
    process
    begin
        write(output,"Hello World!" & LF);
        wait;        
    end process;

end architecture;