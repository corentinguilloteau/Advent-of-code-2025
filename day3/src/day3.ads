with Interfaces; use Interfaces;

package Day3 is

   function Process (Override : Boolean) return Unsigned_64;

private
   subtype Joltage is Positive range 1 .. 9;
   type Battery_Bank is array (Positive range <>) of Joltage;

end Day3;
