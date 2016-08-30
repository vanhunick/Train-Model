with Tracks; use Tracks;

package body Track_Lists with SPARK_Mode => on is

   -- Creates and returns an empty track list
   function Create return Track_List is
      New_List : Track_List;
   begin
         New_List.Count := 0;
         New_List.Max := 10000;
         return New_List;
   end Create;

   -- Add a track to the list
   procedure Add_Track(A_Track_List : in out Track_List; A_Track : in Track) is
   begin
      A_Track_List.Tracks(A_Track_List.Count+1) := A_Track;
   end Add_Track;

   function Get_Count(A_Track_List : in Track_List)return Integer is (A_Track_List.Count);

   function Get_Max(A_Track_List : in Track_List)return Integer is (A_Track_List.Max);

end Track_Lists;
