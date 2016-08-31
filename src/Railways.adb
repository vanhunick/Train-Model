with Track_Lists; use Track_Lists;
with Train_Lists; use Train_Lists;
with Station_Lists; use Station_Lists;
with Tracks; use Tracks;
with Trains; use Trains;
with Stations; use Stations;

package body Railways with SPARK_Mode => on is

   -- Creates and returns a new Railway
   function Create return Railway is
      New_Railway : Railway;
   begin
      New_Railway.All_Tracks := Track_Lists.Create;
      New_Railway.All_Trains := Train_Lists.Create;
      New_Railway.All_Stations := Station_Lists.Create;
      return New_Railway;
   end Create;

   procedure Start(A_Railway : in out Railway) is
   begin
      A_Railway.Started := True;
   end start;


   function Get_Started(A_Railway : in Railway)return Boolean is (A_Railway.Started);

   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return true;
   end Check_Collision;



   -- Add inbound track to station
   procedure Add_Inbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track) is
   begin
       for I in 1.. Station_Lists.Get_Count(A_Railway.All_Stations) loop
         if  A_Railway.All_Stations(I) = Station_ID then                  -- Here we have found the station to add the track to
            Stations.Add_Inbound(A_Railway.All_Stations(I), A_Track);   -- Add the inbound track to the Station
            return;
         end if;
      end loop;
   end Add_Inbound;


   -- Add outbound track to station
   procedure Add_Outbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track) is
   begin
       for I in 1.. Station_Lists.Get_Count(A_Railway.All_Stations) loop
         if  A_Railway.All_Stations(I) = Station_ID then                   -- Here we have found the station to add the track to
            Stations.Add_Outbound(A_Railway.All_Stations(I), A_Track);   -- Add the outbound track to the Station
            return;
         end if;
      end loop;
   end Add_Outbound;


   -- Add station
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) is
   begin
      Station_Lists.Add_Station(A_Railway.All_Stations, A_Station);
   end Add_Station;


   -- Add track
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) is
   begin
      Track_Lists.Add_Track(A_Railway.All_Tracks, A_Track);
   end Add_Track;


   -- Add train
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) is
   begin
      Train_Lists.Add_Train(A_Railway.All_Trains, A_Train);
   end Add_Train;

   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean is
   begin
      return True; -- TO IMPLEMENT
   end Check_Reachability;


   -- Moves a train to its destination
   procedure Move_Train(A_Railway : in Railway; ID : Natural) is
   begin
      for I in 1.. Train_Lists.Get_Count(A_Railway.All_Trains) loop
         if  A_Railway.All_Trains(I) = ID then -- Found the train
                                               -- Move it
                                               null;
         end if;
      end loop;
   end Move_Train;


   -- Returns if the Train ID exists in the railway
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      for I in 1.. Train_Lists.Get_Count(A_Railway.All_Trains) loop
         if  A_Railway.All_Trains(I) = ID then return true;
         end if;
      end loop;
      return False;
   end Valid_Train_ID;


   -- Returns if the Station ID exists in the railway
   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      for I in 1.. Station_Lists.Get_Count(A_Railway.All_Stations) loop
         if  A_Railway.All_Stations(I) = ID then return true;
         end if;
      end loop;
      return False;
   end Valid_Station_ID;


   -- Returns if the Track ID exists in the railway
   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      for I in 1.. Track_Lists.Get_Count(A_Railway.All_Tracks) loop
         if  A_Railway.All_Tracks(I) = ID then return true;
         end if;
      end loop;
      return False;
   end Valid_Track_ID;

end Railways;
