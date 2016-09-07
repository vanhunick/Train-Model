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

   -- Starts the sim, from this poinst no more tracks can be added if it makes the model unreachable
   procedure Start(A_Railway : in out Railway) is
   begin
      A_Railway.Started := True;
   end start;

   function Get_Started(A_Railway : in Railway)return Boolean is (A_Railway.Started);

   -- Check if the train with the ID passed in will collide with something if it moves to its destination
   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean is
      Destination : Natural;
   begin
      Destination := Trains.Get_Destination(Train_Lists.Get_Train(A_Railway.All_Trains,ID));
      if Train_Lists.On_Destination(A_Railway.All_Trains,Destination) then
         return True;
      else
         return False;
      end if;
   end Check_Collision;


   -- Add inbound track to station
   procedure Add_Inbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track) is
   begin
      Station_Lists.Add_Inbound(A_Railway.All_Stations, Station_ID,A_Track);
   end Add_Inbound;


   -- Add outbound track to station
   procedure Add_Outbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track) is
   begin
      Station_Lists.Add_Outbound(A_Railway.All_Stations, Station_ID,A_Track);
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
      for I in 1.. Get_Count(A_Railway.All_Stations) loop
         if  not Check_Reachability_Node(A_Railway, Get_Station_Index(A_Railway.All_Stations,I)) then return False;
         end if;
      end loop;
      return True;
   end Check_Reachability;

   -- Check count of stations not 0

   function Check_Reachability_Node(A_Railway : in Railway; A_Station : in Station)return Boolean is
      Station_Count : Natural;
      Stack_Kinda : Station_Array(1.. Station_Lists.Get_Count(A_Railway.All_Stations));
      Discovered : Nat_Array(1.. Station_Lists.Get_Count(A_Railway.All_Stations));
      Stack_Height : Natural;
      Popped_Station : Station;

      Dest_Station : Natural;
      Max_Index_Discovered : Natural;
   begin
      Station_Count := Station_Lists.Get_Count(A_Railway.All_Stations);
      Stack_Height := 0; -- Init stack kinda
      Max_Index_Discovered := 0;

      Stack_Kinda(Stack_Height + 1) := Station_Lists.Get_Station_Index(A_Railway.All_Stations,1);
      Stack_Height := Stack_Height + 1; -- Increment stack height

      while Stack_Height /= 0
      loop
         -- Pop v well decrement the count of the stack
         Popped_Station := Stack_Kinda(Stack_Height);
         Stack_Height := Stack_Height -1;


         for I in 1.. Track_Lists.Get_Count(Popped_Station.Out_Tracks) loop -- Loop through all outgoing tracks of stations stations
            Dest_Station := Tracks.Get_Destination(Track_Lists.Get_Track_Index(Popped_Station.Out_Tracks,I));

            if not Contains_ID(Discovered,Max_Index_Discovered,Dest_Station) then
               Stack_Kinda(Stack_Height + 1) := Station_Lists.Get_Station(A_Railway.All_Stations,Dest_Station); -- Grab the station it goes to
               Stack_Height := Stack_Height + 1; -- Increment stack height
               Max_Index_Discovered := Max_Index_Discovered + 1;
               Discovered(Max_Index_Discovered) := Dest_Station;
            end if;
         end loop;
      end loop;

      return Max_Index_Discovered = Station_Count-1;
   end Check_Reachability_Node;

   -- helper for checking something in array
   function Contains_ID(IDs : in Nat_Array; Max_Index : in Natural; ID : in Natural)return Boolean is
   begin
      for I in 1.. Max_Index loop
         if  IDs(I) = ID then
            return True;
         end if;
      end loop;
      return False;
   end Contains_ID;


   -- Moves a train to its destination
   procedure Move_Train(A_Railway : in out Railway; ID : Natural) is
   begin
      Train_Lists.Move_Train(A_Railway.All_Trains, ID);
   end Move_Train;

   -- Returns if the Train ID exists in the railway
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return Train_Lists.Contains_Train(A_Railway.All_Trains, ID);
   end Valid_Train_ID;

   -- Returns if the Station ID exists in the railway
   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return Station_Lists.Contains_Station(A_Railway.All_Stations, ID);
   end Valid_Station_ID;

   -- Returns if the Track ID exists in the railway
   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return Track_Lists.Contains_Track(A_Railway.All_Tracks, ID);
   end Valid_Track_ID;

end Railways;
