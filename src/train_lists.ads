with Trains; use Trains;

package Train_Lists with SPARK_Mode => on is

   -- The underlying array of Trains
   type Train_Array is array (Positive range 1..100) of Train; -- Change 100 to another number to increase number of possible trains

   --     Type Train_List is private;
   type Train_List is
      record
         Count : Natural; -- The count of trains currently in the list
         Trains : Train_Array;
         Max : Natural;
      end record;

   -- Creates and returns an empty Train list
   function Create return Train_List with
     post => Get_Count(Create'Result) = 0
     and Create'Result.Max = 100;

   -- Sets the destination of the train
   procedure Set_Destination(A_Train_List : in out Train_List; Train_ID : in Natural; Destination_ID : in Natural) with
     pre => Contains_Train(A_Train_List, Train_ID);

   -- Add a Train to the list
   procedure Add_Train(A_Train_List : in out Train_List; A_Train : in Train) with
     pre => Space_Left(A_Train_List), -- Check there is still place in the list
     post => (A_Train_List.Count = A_Train_List.Count'old + 1 and then -- The count should be incremented
                A_Train_List.Count <= A_Train_List.Trains'Last and then  -- Check it has not gone over array
                  (A_Train_List.Trains(A_Train_List.Count) = A_Train)) or A_Train_List.Count = A_Train_List.Count'old; -- Check the train is in the array

   -- Returns the count of the list
   function Get_Count(A_Train_List : in Train_List)return Natural with
     Post => Get_Count'Result = A_Train_List.Count;

   -- Returns the maximum number of elements that can be in the list
   function Get_Max(A_Train_List : in Train_List)return Natural with
     Post => Get_Max'Result = A_Train_List.Max;

   -- Returns the train with the given ID
   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train with
     pre => Contains_Train(A_Train_List,ID),
     post => Get_ID(Get_Train'Result) = ID;

   -- Returns if the list contains the train given by the ID
   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean with
     Post => (if Contains_Train'Result then
                (for some I in 1..A_Train_List.Trains'Last => Get_ID(A_Train_List.Trains(I)) = ID)
                  else
                (for all I in 1..A_Train_List.Trains'Last => Get_ID(A_Train_List.Trains(I)) /= ID));

   -- Returns if a train is on a the destination with the id Dest_ID
   function On_Destination(A_Train_List : in Train_List; Dest_ID : in Natural)return Boolean with
     Post => (if On_Destination'Result then
                (for some I in A_Train_List.Trains'First..A_Train_List.Trains'Last => A_Train_List.Trains(I).Cur_Location_ID = Dest_ID)
                  else
                    (for all I in A_Train_List.Trains'First..A_Train_List.Trains'Last => A_Train_List.Trains(I).Cur_Location_ID /= Dest_ID
             ));

   -- Moves the train to its destination
   procedure Move_Train(A_Train_List : in out Train_List; ID : in Natural) with
     pre => Contains_Train(A_Train_List,ID), -- There need to be a train that matched the id in the list
     post => (if Contains_Train(A_Train_List,ID) then Get_Location(Get_Train(A_Train_List,ID)) = Get_Destination(Get_Train(A_Train_List,ID))); -- Make sure location is the old destination

   -- Returns the train at the given index
   function Get_Train_Index(A_Train_List : in Train_List; Index : in Natural)return Train with
     pre => Index <= Get_Count(A_Train_List) and then Get_Count(A_Train_List) < A_Train_List.Trains'Last and then Index /= 0,
     post => Get_Train_Index'Result = A_Train_List.Trains(Index);

   -- Bounds Check function
   function Space_Left(A_Train_List : in Train_List) Return Boolean
     With Post => (if Space_Left'Result then
                     A_Train_List.Count < Natural'Last and then
                       A_Train_List.Count >= Natural'First and then
                         A_Train_List.Count + 1 < A_Train_List.Trains'Last);

   --     private
   --     type Train_List is
   --        record
   --           Count : Integer;
   --           Trains : Train_Array;
   --           Max : Integer;
   --        end record;
end Train_Lists;
