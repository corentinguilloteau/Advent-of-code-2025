with Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO;

package body Day3 is

   function Read_Line (File : File_Type) return Battery_Bank is
   begin
      declare
         Line        : constant String := Get_Line (File);
         Line_Length : constant Natural := Line'Length;
         Result      : Battery_Bank (1 .. Line_Length);
      begin
         Put_Line ("Read line: " & Line);

         for I in Line'Range loop
            Result (I) := Joltage'Value (Line (I .. I));
         end loop;

         return Result;
      end;
   end Read_Line;

   function Get_Max_Joltage (Bank : Battery_Bank) return Positive is
      First_Digit  : Joltage := Bank (Bank'First);
      Second_Digit : Joltage := Bank (Bank'First + 1);
   begin
      for Index in Bank'First .. Bank'Last loop
         if Index /= Bank'Last and then Bank (Index) > First_Digit then
            First_Digit := Bank (Index);
            Second_Digit := Bank (Index + 1);
         elsif Bank (Index) > Second_Digit then
            Second_Digit := Bank (Index);
         end if;
      end loop;

      return First_Digit * 10 + Second_Digit;
   end Get_Max_Joltage;

   function Process return Positive is
      File  : File_Type;
      Total : Natural := 0;
   begin
      Open (File, In_File, "input/day3.txt");

      while not End_Of_File (File) loop
         declare
            Bank        : constant Battery_Bank := Read_Line (File);
            Max_Joltage : constant Positive := Get_Max_Joltage (Bank);
         begin
            Total := Total + Max_Joltage;
         end;
      end loop;

      Close (File);
      return Total;
   end Process;
end Day3;
