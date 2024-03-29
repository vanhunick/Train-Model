package body Trains is

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural; Start_Location_ID : in Natural)return Train is
      A_Train : Train;
   begin
      A_Train.Destination := Start_Location_ID;
      A_Train.Cur_Location_ID := Start_Location_ID;
      A_Train.ID := ID;
      return A_Train;
   end Create;

   procedure Update_Location(A_Train : in out Train) is
   begin
      A_Train.Cur_Location_ID := A_Train.Destination;
   end Update_Location;

   procedure Set_Destination(A_Train : in out Train; ID : in Natural) is
   begin
      A_Train.Destination := ID;
   end Set_Destination;

   function Get_ID(A_Train : in Train)return Natural is (A_Train.ID);

   function Get_Location(A_Train : in Train)return Natural is (A_Train.Cur_Location_ID);

   function Get_Destination(A_Train : in Train)return Natural is (A_Train.Destination);

end Trains;
