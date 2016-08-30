with Track_Lists; use Track_Lists;
with Train_Lists; use Train_Lists;
with Station_Lists; use Station_Lists;
with Tracks; use Tracks;
with Trains; use Trains;
with Stations; use Stations;

package body Railways with SPARK_Mode => on is



   function Create return Railway is
      New_Railway : Railway;
   begin
      New_Railway.All_Tracks := Track_Lists.Create;
      New_Railway.All_Trains := Train_Lists.Create;
      New_Railway.All_Stations := Station_Lists.Create;
      return New_Railway;
   end Create;


   -- Add inbound track to station
   procedure Add_Inbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track) is
   begin
       for I in 1.. Station_Lists.Get_Count(A_Railway.All_Stations) loop
         if  A_Railway.All_Stations(I) = Station_ID then -- Here we have found the station to add the track to
            Stations.Add_Inbound(A_Railway.All_Stations(I), Add_Track); -- Add the inbound track to the Station
            return;
         end if;
      end loop;
   end Add_Inbound;


   -- Add outbound track to station
   procedure Add_Outbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track);

   -- Add station
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) with
   pre => Valid_Station_ID(A_Railway, Get_ID(A_Station)) = False;

   -- Add track
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) with
   pre => Valid_Track_ID(A_Railway, Get_ID(A_Track)) = False;


   -- Add train
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) with
   pre => Valid_Train_ID(A_Railway, Get_ID(A_Train)) = False;

   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean;

   procedure Move_Train(A_Railway : in Railway; ID : Natural)with
   pre => Valid_Train_ID(A_Railway, ID);


   -- Returns if the passed in ID is allowed to be used
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean;
   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean;
   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean;
