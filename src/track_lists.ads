with Tracks; use Tracks;

package Track_Lists with SPARK_Mode => on is

   -- The underlying array of tracks
   type Track_Array is array (Positive range 1..100) of Track;

--     Type Track_List is private;
   type Track_List is
      record
         Count : Integer;
         Tracks : Track_Array;
         Max : Integer;
      end record;


   -- Creates and returns an empty track list
   function Create return Track_List with
   Post => Get_Count(Create'Result) = 0;

   -- Add a track to the list
   procedure Add_Track(A_Track_List : in out Track_List; A_Track : in Track) with
     pre => Get_Count(A_Track_List) < Get_Max(A_Track_List),
     post => Get_Count(A_Track_List) - 1 = Get_Count(A_Track_List'old) and then
   (for some I in A_Track_List.Tracks'Range => A_Track_List.Tracks(I) = A_Track); -- Check the Track is somewhere in the array


   function Get_Count(A_Track_List : in Track_List)return Integer with
      Post => Get_Count'Result = A_Track_List.Count;

   function Get_Max(A_Track_List : in Track_List)return Integer with
   Post => Get_Max'Result = A_Track_List.Max;

   function Get_Track(A_Track_List : in Track_List; ID : in Natural)return Track with
     pre => Contains_Track(A_Track_List,ID),
     post => Get_ID(Get_Track'Result) = ID;

   function Get_Track_Index(A_Track_List : in  Track_List; Index : in Natural)return Track with
     pre => Index <= Get_Count(A_Track_List),
     post => Get_Track_Index'Result = A_Track_List.Tracks(Index);


   function Contains_Track(A_Track_List : in Track_List; ID : in Natural)return Boolean with
     Post => (if Contains_Track'Result then
                (for some I in A_Track_List.Tracks'Range => Get_ID(A_Track_List.Tracks(I)) = ID)
                  else
                (for all I in A_Track_List.Tracks'Range => Get_ID(A_Track_List.Tracks(I)) /= ID));


--     private
--     type Track_List is
--        record
--           Count : Integer;
--           Tracks : Track_Array;
--           Max : Integer;
--        end record;
end Track_Lists;
