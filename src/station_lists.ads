with Stations; use Stations;
with Tracks; use Tracks;

package Station_Lists with SPARK_Mode => on is

   -- The underlying array of Stations
   type Station_Array is array (Positive range 1..100) of Station;

   --     Type Station_List is private;

   type Station_List is
      record
         Count : Natural;
         Stations : Station_Array;
         Max : Natural;
      end record;

   -- Creates and returns an empty Station list
   function Create return Station_List with
     post => Get_Count(Create'Result) = 0
     and Create'Result.Max = 100;


   -- Add a Station to the list
   procedure Add_Station(A_Station_List : in out Station_List; A_Station : in Station) with
     pre => Space_Left(A_Station_List),
     post => (A_Station_List.Count = A_Station_List.Count'old + 1 and then
                A_Station_List.Count <= A_Station_List.Stations'Last and then  -- Make sure count less than the last array index
                  (A_Station_List.Stations(A_Station_List.Count) = A_Station)) or A_Station_List.Count = A_Station_List.Count'old; -- Check the Station is somewhere in the array

   function Get_Count(A_Station_List : in Station_List)return Natural with
     Post => Get_Count'Result = A_Station_List.Count;


   function Get_Max(A_Station_List : in Station_List)return Natural with
     Post => Get_Max'Result = A_Station_List.Max;


   function Get_Station(A_Station_List : in Station_List; ID : in Natural)return Station with
     pre => Contains_Station(A_Station_List,ID),
     post => Get_ID(Get_Station'Result) = ID;

   function Contains_Station(A_Station_List : in Station_List; ID : Natural)return Boolean with
   Post => (if Contains_Station'Result then
              (for some I in 1..A_Station_List.Stations'Last => Get_ID(A_Station_List.Stations(I)) = ID)
            else
              (for all I in 1..A_Station_List.Stations'Last => Get_ID(A_Station_List.Stations(I)) /= ID));

   function Get_Station_Index(A_Station_List : in Station_List; Index : in Natural)return Station with
     pre => In_Range(A_Station_List, Index),
     post => Get_Station_Index'Result = A_Station_List.Stations(Index);

   function In_Range(A_Station_List : in Station_List; Index : in Natural) return Boolean with
        Post => (if In_Range'Result then Index in A_Station_List.Stations'First..A_Station_List.Stations'Last
                          else
                            (Index not in A_Station_List.Stations'First..A_Station_List.Stations'Last));


   procedure Add_Track(A_Station_List : in out Station_List; A_Track : Track);


   procedure Add_Outbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track);

   procedure Add_Inbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track);

      -- Bounds Check function
   function Space_Left(A_Station_List : in Station_List) Return Boolean
     With Post => (if Space_Left'Result then
                     A_Station_List.Count < Natural'Last and then
                       A_Station_List.Count >= Natural'First and then
                         A_Station_List.Count < A_Station_List.Max and then
                           A_Station_List.Count + 1 < A_Station_List.Stations'Last);


   --     type Station_List is
   --        record
   --           Count : Natural;
   --           Stations : Station_Array;
   --           Max : Natural;
   --        end record;
end Station_Lists;
