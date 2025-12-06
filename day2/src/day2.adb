with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Fixed;

package body Day2 is

   function Read_Input return Ids is
      F : File_Type;
   begin
      Open (F, In_File, "input/day2.txt");

      declare
         --   The input is a single Line
         Line : constant String := Get_Line (F);

         InterId_Pattern : constant String := ",";
         Ids_Count       : constant Natural :=
           Ada.Strings.Fixed.Count (Line, InterId_Pattern) + 1;
         Results         : Ids (0 .. Ids_Count - 1);
         Id_Start        : Natural := 0;
         Id_End          : Integer := -1;
      begin

         -- Extract each Id sequence
         for I in Results'Range loop
            -- Compute the start and end of the Id entry
            Id_Start := Id_End + 2;
            Id_End :=
              Ada.Strings.Fixed.Index
                (Source => Line, Pattern => InterId_Pattern, From => Id_Start);

            if Id_End = 0 then
               Id_End := Line'Length;
            else
               Id_End := Id_End - 1;
            end if;

            -- Extract the Id entry and split it into its two components
            declare
               Id_Entry    : constant String := Line (Id_Start .. Id_End);
               Entry_Split : constant Natural :=
                 Ada.Strings.Fixed.Index (Id_Entry, "-");
            begin
               Results (I).First_Id :=
                 Unsigned_64'Value (Id_Entry (Id_Start .. Entry_Split - 1));
               Results (I).Last_Id :=
                 Unsigned_64'Value (Id_Entry (Entry_Split + 1 .. Id_End));
            end;
         end loop;

         Close (F);
         return Results;
      end;
   end Read_Input;

   function Process_Entry (E : IdSequence) return Unsigned_64 is
      Result : Unsigned_64 := 0;
   begin
      -- Process each Id in the sequence
      for Id in E.First_Id .. E.Last_Id loop
         if Process_Id (Id) then
            Result := Result + Id;
         end if;
      end loop;

      return Result;
   end Process_Entry;

   function Process_Id (Id : Unsigned_64) return Boolean is
      Pattern_Mask        : Unsigned_64 := 10;
      Pattern_Mask_Length : Unsigned_64 := 1;
      Id_Digits           : Unsigned_64 := 0;
   begin

      --  Compute the number of digits in the Id
      declare
         Temp_Id : Unsigned_64 := Id;
      begin
         Id_Digits := 0;
         while Temp_Id /= 0 loop
            Id_Digits := Id_Digits + 1;
            Temp_Id := Temp_Id / 10;
         end loop;
      end;

      --  We loop over possible pattern lengths
      --  Pattern_Mask > 1 and we incement by factor 10 each time
      --  Therefore, this loop terminates
      while Pattern_Mask <= Id loop
         --  Check if the current pattern length divides the Id length
         -- If not we cannot have a valid pattern of this length and therefore
         -- we skip to the next length
         if Id_Digits mod Pattern_Mask_Length = 0 then
            declare
               Pattern    : constant Unsigned_64 := Id mod Pattern_Mask;
               Rebuilt_Id : Unsigned_64 := 0;
               Base       : Unsigned_64 := 1;
            begin
               --  Rebuild the Id from the pattern
               for I in 1 .. Id_Digits / Pattern_Mask_Length loop
                  --  This may raise Constraint_Error if the update overflows
                  --  but this would mean that no valid pattern was found anyway
                  --  as the Id would be too large to exist
                  begin
                     Rebuilt_Id := Rebuilt_Id + Pattern * Base;
                     Base := Base * Pattern_Mask;
                  exception
                     when Constraint_Error =>
                        exit;
                  end;
               end loop;

               --  Check if we have a match
               if Rebuilt_Id = Id then
                  return True;
               end if;
            end;
         end if;

         --  Update the mask
         --  This may raise Constraint_Error if the Pattern_Mask overflows
         --  but this would mean that no valid pattern was found anyway
         --  as the Id would be too large to exist
         begin
            Pattern_Mask := Pattern_Mask * 10;
            Pattern_Mask_Length := Pattern_Mask_Length + 1;
         exception
            when Constraint_Error =>
               return False;
         end;
      end loop;

      return False;
   end Process_Id;

end Day2;
