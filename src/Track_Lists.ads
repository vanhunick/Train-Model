with Tracks; use Tracks;

package Track_Lists with SPARK_Mode => on is

   Type Track_List is private;

   -- The underlying array of tracks
   type Track_Array is array (Positive range 1..10000) of Track;

   -- Creates and returns an empty track list
   function Create return Track_List;

   -- Add a track to the list
   procedure Add_Track(A_Track_List : in out Track_List; A_Track : in Track) with
     pre => Get_Count(A_Track_List) < Get_Max(A_Track_List),
     post => Get_Count(A_Track_List) - 1 = Get_Count(A_Track_List)'old;

   function Get_Count(A_Track_List : in Track_List)return Integer;

   function Get_Max(A_Track_List : in Track_List)return Integer;

   function Get_Track(A_Track_List : in Track_List; ID : in Natural)return Track with
     pre => Contains_Track(A_Track_List,ID),
     post => Get_ID(Get_Track'Result) = ID;


   function Contains_Track(A_Track_List : in Track_List; ID : in Natural)return Boolean;



   private
   type Track_List is
      record
         Count : Integer;
         Tracks : Track_Array;
         Max : Integer;
      end record;
end Track_Lists;
