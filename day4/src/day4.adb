with Ada.Text_IO; use Ada.Text_IO;

package body Day4 is

   function Read_Input return Matrix is
      File : File_Type;
   begin
      Open (File, In_File, "input/day4.txt");

      declare
         Line_Length : constant Natural := Get_Line (File)'Length;
         Line_Count  : Natural := 1;
      begin
         while not End_Of_File (File) loop
            Skip_Line (File);
            Line_Count := Line_Count + 1;
         end loop;

         declare
            Result : Matrix (1 .. Line_Count, 1 .. Line_Length) :=
              (others => (others => (Seat_Taken => False, Liberated_At => 0)));
         begin
            Reset (File);
            for I in Result'Range (1) loop
               declare
                  Line : constant String := Get_Line (File);
               begin
                  for J in Result'Range (2) loop
                     if Line (J) = '@' then
                        Result (I, J).Seat_Taken := True;
                     end if;
                  end loop;
               end;
            end loop;

            Close (File);
            return Result;
         end;
      end;
   end Read_Input;

   function Check_Roll_Access
     (Data : Matrix; Row : Positive; Col : Positive; Round : Positive)
      return Boolean is
   begin
      declare
         Neighbors_Count : Natural := 0;
      begin
         for I in
           Positive'Max (Row - 1, 1) .. Positive'Min (Row + 1, Data'Length (1))
         loop
            for J in
              Positive'Max (Col - 1, 1)
              .. Positive'Min (Col + 1, Data'Length (2))
            loop
               if (I /= Row or else J /= Col)
                 and then (Data (I, J).Seat_Taken
                           or else Data (I, J).Liberated_At = Round)
               then
                  Neighbors_Count := Neighbors_Count + 1;
               end if;
            end loop;
         end loop;

         return Neighbors_Count < 4;

      end;
   end Check_Roll_Access;

   function Process_Step1 return Unsigned_64 is
      Data  : constant Matrix := Read_Input;
      Total : Unsigned_64 := 0;
   begin
      for I in Data'Range (1) loop
         for J in Data'Range (2) loop
            if Data (I, J).Seat_Taken then
               if Check_Roll_Access (Data, I, J, 1) then
                  Total := Total + 1;
               end if;
            end if;
         end loop;
      end loop;

      return Total;
   end Process_Step1;

   function Process_Step2 return Unsigned_64 is
      Data        : Matrix := Read_Input;
      Total       : Unsigned_64 := 0;
      Round       : Positive := 1;
      Round_Total : Unsigned_64 := 1;
   begin
      while Round_Total > 0 loop
         Round_Total := 0;
         for I in Data'Range (1) loop
            for J in Data'Range (2) loop
               if Data (I, J).Seat_Taken then
                  if Check_Roll_Access (Data, I, J, Round) then
                     Round_Total := Round_Total + 1;
                     Data (I, J).Liberated_At := Round;
                     Data (I, J).Seat_Taken := False;
                  end if;
               end if;
            end loop;
         end loop;

         Total := Total + Round_Total;
         Round := Round + 1;
      end loop;

      return Total;
   end Process_Step2;
end Day4;
