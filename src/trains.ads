package Trains with SPARK_Mode => on is
   -- Type that holds the pump data
   --     type Train is private;
   -- Public for proving
   type Train is
      record
         Destination : Natural;
         ID : Natural;
         Cur_Location_ID : Natural;
      end record;

   -- Creates an instance of the pump type and returns it
   function Create(ID : in Natural; Start_Location_ID : in Natural)return Train with
     Post => Get_ID(Create'Result) = ID and then
     Get_Location(Create'Result) = Start_Location_ID;

   -- Sets the current location of the train to be the destination
   procedure Update_Location(A_Train : in out Train) with
     Post => A_Train.Cur_Location_ID = A_Train'old.Destination;

   -- A setter method for the destination of the train
   procedure Set_Destination(A_Train : in out Train; ID : in Natural) with
     post => A_Train.Destination = ID;

   -- Returns the ID of the trains
   function Get_ID(A_Train : in Train)return Natural with
     post => Get_ID'Result = A_Train.ID;

   -- Returns the Current location of the train
   function Get_Location(A_Train : in Train)return Natural with
     Post => Get_Location'Result = A_Train.Cur_Location_ID;

   -- Returns the destination of the train
   function Get_Destination(A_Train : in Train)return Natural with
     Post => Get_Destination'Result = A_Train.Destination;

--  private
--     type Train is
--        record
--           Destination : Natural;
--           ID : Natural;
--           Cur_Location_ID : Natural;
--        end record;
end Trains;
