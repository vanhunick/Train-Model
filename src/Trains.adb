with Locations;
package body Trains is

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural)return Train is
      A_Train : Train;
   begin
      A_Train.Destination := 0;
      A_Train.Cur_Location_Type := Locations.OTHER;
      A_Train.Destination := 0;
      return A_Train;
   end Create;


   procedure Update_Location(A_Train : in out Train; Loc : in Location; ID : in Natural) is
   begin
      A_Train.Destination := ID;
      A_Train.Cur_Location_Type :=Loc;
   end Update_Location;

   procedure Set_Destination(A_Train : in out Train; ID : in Natural) is
   begin
      A_Train.Destination := ID;
   end Set_Destination;

   function Get_ID(A_Train : in Train)return Natural is (A_Train.ID);

end Trains;
