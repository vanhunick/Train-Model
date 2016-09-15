with Tracks; use Tracks;
with Track_Lists; use Track_Lists;

package Stations with SPARK_Mode => on is

   --   type Station is private;
   type Station is
      record
         Out_Tracks : Track_List;
         In_Tracks : Track_List;
         ID : Natural;
      end record;

   -- Creates the station
   function Create(Station_ID : in Natural)return Station with
     post => Get_ID(Create'Result) = Station_ID;

   -- Returns the ID of the station
   function Get_ID(A_Station : Station)return Natural;

   -- Adds an inbound track to the station
   procedure Add_Inbound(A_Station : in out Station; A_Track : in Track) with
     pre => Add_Inbound_check(A_Station, A_Track) = True;

   -- Adds an outbound track to the station
   procedure Add_Outbound(A_Station : in out Station; A_Track : in Track) with
     pre => Add_Outbound_check(A_Station, A_Track) = True;

   -- Checks if the stations contains a track returns true if so
   function Add_Inbound_Check(A_Station : in Station; A_Track : in Track)return Boolean with
     Post => (if Add_Inbound_Check'Result then
                (for all I in 1..A_Station.In_Tracks.Tracks'Last => Get_ID(Get_Track_Index(A_Station.In_Tracks,I)) /= Get_ID(A_Track)));

   -- Checks if the stations contains a track returns true if so
   function Add_Outbound_Check(A_Station : in Station; A_Track : in Track)return Boolean;

   -- Returns true if a train can go from this station to the track with the ID passed in
   function Go_To_Track(A_Station : in Station; Track_ID : in Natural)return Boolean;

   --  private
   --     type Station is
   --        record
   --           Out_Tracks : Track_List;
   --           In_Tracks : Track_List;
   --           ID : Natural;
   --        end record;
end Stations;





