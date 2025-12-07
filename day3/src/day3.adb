with Ada.Text_IO; use Ada.Text_IO;

package body Day3 is

   function Read_Line (File : File_Type) return Battery_Bank is
   begin
      declare
         Line        : constant String := Get_Line (File);
         Line_Length : constant Natural := Line'Length;
         Result      : Battery_Bank (1 .. Line_Length);
      begin
         for I in Line'Range loop
            Result (I) := Joltage'Value (Line (I .. I));
         end loop;

         return Result;
      end;
   end Read_Line;

   function Get_Max_Joltage
     (Bank : Battery_Bank; Battery_Count : Positive) return Unsigned_64
   is
      Max       : Joltage := Bank (Bank'First);
      Max_Index : Positive := Bank'First;
   begin
      for I in Bank'First .. Bank'Last - (Battery_Count - 1) loop
         if Bank (I) > Max then
            Max := Bank (I);
            Max_Index := I;
         end if;
      end loop;

      if Battery_Count > 1 then
         return
           Unsigned_64 (Max)
           * Unsigned_64 (10**(Battery_Count - 1))
           + Get_Max_Joltage
               (Bank (Max_Index + 1 .. Bank'Last), Battery_Count - 1);
      else
         return Unsigned_64 (Max);
      end if;

   end Get_Max_Joltage;

   function Process (Override : Boolean) return Unsigned_64 is
      File          : File_Type;
      Total         : Unsigned_64 := 0;
      Battery_Count : constant Positive := (if Override then 12 else 2);
   begin
      Open (File, In_File, "input/day3.txt");

      while not End_Of_File (File) loop
         declare
            Bank        : constant Battery_Bank := Read_Line (File);
            Max_Joltage : constant Unsigned_64 :=
              Get_Max_Joltage (Bank, Battery_Count);
         begin
            Total := Total + Max_Joltage;
         end;
      end loop;

      Close (File);
      return Total;
   end Process;
end Day3;
