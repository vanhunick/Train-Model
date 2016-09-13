with Trains; use Trains;

package Train_Lists with SPARK_Mode => on is

   -- The underlying array of Trains
   type Train_Array is array (Positive range 1..100) of Train;

--     Type Train_List is private;
   type Train_List is
      record
         Count : Natural;
         Trains : Train_Array;
         Max : Natural;
      end record;


   -- Creates and returns an empty Train list
   function Create return Train_List with
     post => Get_Count(Create'Result) = 0
     and Create'Result.Max = 100;

   procedure Set_Destination(A_Train_List : in out Train_List; Train_ID : in Natural; Destination_ID : in Natural) with
     pre => Contains_Train(A_Train_List, Train_ID);

   -- Add a Train to the list
   procedure Add_Train(A_Train_List : in out Train_List; A_Train : in Train) with
     pre => Space_Left(A_Train_List),
     post => (A_Train_List.Count = A_Train_List.Count'old + 1 and then
     A_Train_List.Count <= A_Train_List.Trains'Last and then  -- Make sure count less than the last array index
   (A_Train_List.Trains(A_Train_List.Count) = A_Train)) or A_Train_List.Count = A_Train_List.Count'old; -- Check the train is somewhere in the array

   function Get_Count(A_Train_List : in Train_List)return Natural with
   Post => Get_Count'Result = A_Train_List.Count;

   function Get_Max(A_Train_List : in Train_List)return Natural with
   Post => Get_Max'Result = A_Train_List.Max;

   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train with
     pre => Contains_Train(A_Train_List,ID),
     post => Get_ID(Get_Train'Result) = ID;

   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean with
     Post => (if Contains_Train'Result then
          (for some I in 1..Get_Count(A_Train_List) => Get_ID(A_Train_List.Trains(I)) = ID)
             else
        (for all I in 1..Get_Count(A_Train_List) => Get_ID(A_Train_List.Trains(I)) /= ID));


   function On_Destination(A_Train_List : in Train_List; Dest_ID : in Natural)return Boolean;-- with


   procedure Move_Train(A_Train_List : in out Train_List; ID : in Natural) with
     pre => Contains_Train(A_Train_List,ID), -- There need to be a train that matched the id in the list
     post => Get_Location(Get_Train(A_Train_List,ID)'old) /= Get_Location(Get_Train(A_Train_List,ID)); -- Make sure location has changed

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
