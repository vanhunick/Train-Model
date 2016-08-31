with Stations; use Stations;

package Station_Lists with SPARK_Mode => on is

   Type Station_List is private;

   -- The underlying array of Stations
   type Station_Array is array (Positive range 1..1000) of Station;

   -- Creates and returns an empty Station list
   function Create return Station_List;

   -- Add a Station to the list
   procedure Add_Station(A_Station_List : in out Station_List; A_Station : in Station) with
     pre => Get_Count(A_Station_List) < Get_Max(A_Station_List),
     post => Get_Count(A_Station_List) - 1 = Get_Count(A_Station_List)'old;

   function Get_Count(A_Station_List : in Station_List)return Integer;

   function Get_Max(A_Station_List : in Station_List)return Integer;

   function Get_Station(A_Station_List : in Station_List; ID : in Natural)return Station with
     pre => Contains_Station(A_Station_List,ID),
     post => Get_ID(Get_Station'Result) = ID;

   function Contains_Station(A_Station_List : in Station_List; ID : Natural)return Boolean;

   private
   type Station_List is
      record
         Count : Integer;
         Stations : Station_Array;
         Max : Integer;
      end record;
end Station_Lists;