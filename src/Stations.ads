with Tracks; use Tracks;
with Track_Lists; use Track_Lists;

package Stations with SPARK_Mode => on is

   type Station is private;

   -- Creates the station
   function Create(Station_ID : in Natural; Out_T : in Track_List; In_T : in Track_List)return Station;

   -- Returns the ID of the station
   function Get_ID(A_Station : Station)return Natural;

private
   type Station is
      record
         Out_Tracks : Track_List;
         In_Tracks : Track_List;
         ID : Natural;
      end record;
end Stations;





