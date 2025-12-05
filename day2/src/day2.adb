with Ada.Text_IO; use Ada.Text_IO;

package body Day2 is

   function Read_Input return Entries is
      F: File_Type;
      line: String;
   begin
      Open (F, In_File, "input/day2.txt");

      -- The input is a single line
      line := Get_Line (F);

      
   end Read_Input;

   procedure Day2 is
   begin
      null;
   end Day2;

end Day2;
