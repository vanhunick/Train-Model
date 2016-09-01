with Locations; use Locations;

package Trains with SPARK_Mode => on is

   -- Type that holds the pump data
   type Train is private;

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural)return Train with
   Post => Get_ID(Create'Result) = ID; -- Checks the correct ID set

   procedure Update_Location(A_Train : in out Train; Loc : in Location; ID : in Natural);

   procedure Set_Destination(A_Train : in out Train; ID : in Natural); -- Need to make sure the id is a station

   function Get_ID(A_Train : in Train)return Natural;

   function Get_Location(A_Train : in Train)return Natural;

   function Get_Location_Type(A_Train : in Train)return Location;

   function Get_Destination(A_Train : in Train)return Natural;

private
   type Train is
      record
         Destination : Natural;
         ID : Natural;
         Cur_Location_Type : Location;
         Cur_Location_ID : Natural;
      end record;
end Trains;
