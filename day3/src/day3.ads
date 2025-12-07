with Ada.Text_IO; use Ada.Text_IO;

package Day3 is

   function Process return Positive;

private
   subtype Joltage is Positive range 1 .. 9;
   type Battery_Bank is array (Positive range <>) of Joltage;

   function Read_Line (File : File_Type) return Battery_Bank;

end Day3;
