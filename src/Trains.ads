with Location; use Location;

package Trains with SPARK_Mode => on is

   -- Type that holds the pump data
   type Train is private;

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Integer)return Train with
     Post => Get_Fuel_Type(Create'Result) = Fuel; -- Checks the correct fuel type assigned

   procedure Update_Location(A_Train : in out Train; Loc : in Location; ID : in Integer);


private
   type Train is
      record
         ID : Integer;
         Cur_Location_Type : Location;
         Cur_Location_ID : Integer;
      end record;
end Trains;
