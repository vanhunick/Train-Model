with Tracks; use Tracks;
with Track_Lists;

package body Stations with SPARK_Mode => on is

   -- Creates the station
   function Create(Station_ID : in Natural)return Station is
      New_Station : Station;
   begin
      New_Station.ID := Station_ID;
      New_Station.Out_Tracks := Track_Lists.Create;
      New_Station.In_Tracks := Track_Lists.Create;
      return New_Station;
   end Create;

   -- Returns the ID of the station
   function Get_ID(A_Station : Station)return Natural is (A_Station.ID);

   procedure Add_Inbound(A_Station : in out Station; A_Track : in Track) is
   begin
      Track_Lists.Add_Track(A_Station.In_Tracks, A_Track);
   end Add_Inbound;

   procedure Add_Outbound(A_Station : in out Station; A_Track : in Track) is
   begin
      Track_Lists.Add_Track(A_Station.Out_Tracks, A_Track);
   end Add_Outbound;


   function Add_Inbound_Check(A_Station : in Station; A_Track : in Track)return Boolean is
   begin
      return not Track_Lists.Contains_Track(A_Station.In_Tracks, Get_ID(A_Track));
   end Add_Inbound_Check;

   --
   function Add_Outbound_Check(A_Station : in Station; A_Track : in Track)return Boolean is
   begin
      return Track_Lists.Contains_Track(A_Station.Out_Tracks, Get_ID(A_Track)); -- ?????
   end Add_Outbound_Check;

   function Go_To_Track(A_Station : in Station; Track_ID : in Natural)return Boolean is
   begin
      return Track_Lists.Contains_Track(A_Station.Out_Tracks, Track_ID); -- If it contains the track it should be able to go to it
   end Go_To_Track;


end Stations;
