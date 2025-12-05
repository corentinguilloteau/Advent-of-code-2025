package Day2 is

   type Entries is private;

   function Read_Input return Entries;

private

   type IdCompound is record
      First_Id : String;
      Second_Id : String;
   end record;

   type Entries is array (Natural range <>) of IdCompound;

end Day2;