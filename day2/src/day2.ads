with Interfaces; use Interfaces;

package Day2 is

   type IdSequence is private;
   type Ids is array (Natural range <>) of IdSequence;

   function Read_Input return Ids;
   function Process_Entry (E : IdSequence) return Unsigned_64;

private

   type IdSequence is record
      First_Id : Unsigned_64;
      Last_Id  : Unsigned_64;
   end record;

   function Process_Id (Id : Unsigned_64) return Boolean;

end Day2;
