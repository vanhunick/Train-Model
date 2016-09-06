with Locations; use Locations;

package Trains with SPARK_Mode => on is

   -- Type that holds the pump data
   --     type Train is private;

   -- Public for proving
   type Train is
      record
         Destination : Natural;
         Destination_Type : Location;
         ID : Natural;
         Cur_Location_Type : Location;
         Cur_Location_ID : Natural;
      end record;


   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural; Start_Location_ID : in Natural; Start_Location_Type : in Location)return Train with
     Post => Get_ID(Create'Result) = ID and then
     Get_Location(Create'Result) = Start_Location_ID and then
     Get_Location_Type(Create'Result) = Start_Location_Type;


   procedure Update_Location(A_Train : in out Train) with
     Pre => Get_Destination(A_Train) /= 0, -- 0 is the default value
     Post => Get_Location(A_Train) = Get_Destination(A_Train'old) and then
     Get_Location_Type(A_Train) = Get_Destination_Type(A_Train'old) ; -- Check current location is the old destination

   procedure Set_Destination(A_Train : in out Train; ID : in Natural; Location_Type : in Location) with
     post => Get_Destination(A_Train) = ID and then
     Get_Location_Type(A_Train) = Location_Type;

   function Get_ID(A_Train : in Train)return Natural with
     post => Get_ID'Result = A_Train.ID;

   function Get_Location(A_Train : in Train)return Natural with
     Post => Get_Location'Result = A_Train.Cur_Location_ID;

   function Get_Location_Type(A_Train : in Train)return Location with
     Post => Get_Location_Type'Result = A_Train.Cur_Location_Type;

   function Get_Destination(A_Train : in Train)return Natural with
     Post => Get_Destination'Result = A_Train.Destination;

   function Get_Destination_Type(A_Train : in Train)return Location with
     Post => Get_Destination_Type'Result = A_Train.Destination_Type;

--  private
--     type Train is
--        record
--           Destination : Natural;
--           Destination_Type : Location;
--           ID : Natural;
--           Cur_Location_Type : Location;
--           Cur_Location_ID : Natural;
--        end record;
end Trains;
