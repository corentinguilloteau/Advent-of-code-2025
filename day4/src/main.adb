with Day4;        use Day4;
with Ada.Text_IO; use Ada.Text_IO;
with Interfaces;  use Interfaces;

procedure Main is
begin
   Put_Line
     ("Accessible rolls count for step 1 is"
      & Unsigned_64'Image (Process_Step1));

   Put_Line
     ("Accessible rolls count for step 2 is"
      & Unsigned_64'Image (Process_Step2));
end Main;
