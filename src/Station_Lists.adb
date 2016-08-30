with Stations; use Stations;

package body Station_Lists with SPARK_Mode => on is

   -- Creates and returns an empty Station list
   function Create return Station_List is
      New_List : Station_List;
   begin
         New_List.Count := 0;
         New_List.Max := 10000;
         return New_List;
   end Create;

   -- Add a Station to the list
   procedure Add_Station(A_Station_List : in out Station_List; A_Station : in Station) is
   begin
      A_Station_List.Stations(A_Station_List.Count+1) := A_Station;
   end Add_Station;

   function Get_Count(A_Station_List : in Station_List)return Integer is (A_Station_List.Count);

   function Get_Max(A_Station_List : in Station_List)return Integer is (A_Station_List.Max);

end Station_Lists;
