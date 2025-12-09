with Interfaces; use Interfaces;

package Day4 is

   function Process_Step1 return Unsigned_64;
   function Process_Step2 return Unsigned_64;

private

   type Paper_Roll is record
      Seat_Taken   : Boolean := False;
      Liberated_At : Natural := 0;
   end record;

   type Matrix is array (Positive range <>, Positive range <>) of Paper_Roll;
   type Matrix_Acc is access all Matrix;

end Day4;
