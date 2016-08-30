with Tracks; use Tracks;

package body Stations with SPARK_Mode => on is


   -- Creates the station
   function Create(Station_ID : in Natural; Out_T : in Track_List; In_T : in Track_List)return Station is
      New_Station : Station;
   begin
      New_Station.ID := Station_ID;
      New_Station.Out_Tracks := Out_T;
      New_Station.In_Tracks := In_T;
      return New_Station;
   end Create;


   -- Returns the ID of the station
   function Get_ID(A_Station : Station)return Natural is (A_Station.ID);

end Stations;
