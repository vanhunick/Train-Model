with Locations;
package body Trains is

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural; Start_Location_ID : in Natural; Start_Location_Type : in Location)return Train is
      A_Train : Train;
   begin
      A_Train.Destination := 0;
      A_Train.Destination_Type := OTHER;
      A_Train.Cur_Location_Type := Start_Location_Type;
      A_Train.Cur_Location_ID := Start_Location_ID;
      A_Train.ID := ID;
      return A_Train;
   end Create;

   -- MIGHT CHANGE TO JUST UPDATE IT TO DESTINATION
   procedure Update_Location(A_Train : in out Train) is
   begin
      A_Train.Cur_Location_ID := A_Train.Destination;
      A_Train.Cur_Location_Type := A_Train.Destination_Type;
   end Update_Location;

   procedure Set_Destination(A_Train : in out Train; ID : in Natural; Location_Type : in Location) is
   begin
      A_Train.Destination := ID;
      A_Train.Destination_Type := Location_Type;
   end Set_Destination;


   function Get_ID(A_Train : in Train)return Natural is (A_Train.ID);

   function Get_Location(A_Train : in Train)return Natural is (A_Train.Cur_Location_ID);

   function Get_Location_Type(A_Train : in Train)return Location is (A_Train.Cur_Location_Type);

   function Get_Destination(A_Train : in Train)return Natural is (A_Train.Destination);

   function Get_Destination_Type(A_Train : in Train)return Location is (A_Train.Destination_Type);

end Trains;
