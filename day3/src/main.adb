with Day3;        use Day3;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;

procedure Main is
begin
   Put_Line
     ("Maximum joltage for step 1 is "
      & Unsigned_64'Image (Process (Override => False)));

   Put_Line
     ("Maximum joltage for step 2 is "
      & Unsigned_64'Image (Process (Override => True)));
end Main;
