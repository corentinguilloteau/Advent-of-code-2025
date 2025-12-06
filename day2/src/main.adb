with Day2;        use Day2;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;

procedure Main is
   Entries : constant Ids := Read_Input;
   I       : Unsigned_64 := 0;
begin
   for E of Entries loop
      declare
         Result : constant Unsigned_64 := Process_Entry (E);
      begin
         I := I + Result;
      end;
   end loop;

   Put_Line ("Total Processed Value: " & Unsigned_64'Image (I));
end Main;
