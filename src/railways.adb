with Track_Lists; use Track_Lists;
with Train_Lists; use Train_Lists;
with Station_Lists; use Station_Lists;
with Tracks; use Tracks;
with Trains; use Trains;
with Stations; use Stations;
with Text_IO; use Text_IO;

package body Railways with SPARK_Mode => on is


   -- Creates and returns a new Railway
   function Create return Railway is
      New_Railway : Railway;
   begin
      -- Creates the empty lists for tracks, trains, and stations
      New_Railway.All_Tracks := Track_Lists.Create;
      New_Railway.All_Trains := Train_Lists.Create;
      New_Railway.All_Stations := Station_Lists.Create;
      New_Railway.Started := False;
      return New_Railway;
   end Create;

   -- Starts the simulation, from this poinst no more tracks can be added
   procedure Start(A_Railway : in out Railway) is
   begin

      if(Check_Reachability(A_Railway)) then
         A_Railway.Started := True;
      end if;
   end start;




   function Check_Valid_Destination(A_Railway : in Railway; ID_Train : Natural; ID_Destination : in Natural)return Boolean is
      A_Train : Train;
      Cur_Location_ID : Natural;
   begin
      if not (Contains_Train(A_Railway.All_Trains, ID_Train))then return False; end if; -- Check for valid train ID

      A_Train := Train_Lists.Get_Train(A_Railway.All_Trains,ID_Train); -- Find the train we care about

      Cur_Location_ID := Get_Location(A_Train); -- Get the location of the train

      if Cur_Location_ID = 0 then -- The train is currently not on a track or station
         return Contains_Station(A_Railway.All_Stations, ID_Destination); -- We can move from unknown to any station
      elsif Contains_Station(A_Railway.All_Stations, Cur_Location_ID) then -- Check if the cur location is in station

         return Go_To_Track(Get_Station(A_Railway.All_Stations,Cur_Location_ID), ID_Destination); -- Check if the cur station has outgoing that meets destination id
      elsif Contains_Track(A_Railway.All_Tracks, Cur_Location_ID) then

         return Get_Destination(Get_Track(A_Railway.All_Tracks, Cur_Location_ID)) = ID_Destination; -- Return if the destination of the current track is the destination ID
      else
         return False; -- The destination ID does not exist
      end if;
   end Check_Valid_Destination;

   -- Set Destination of a train the destination can only be the next location
   procedure Set_Destination(A_Railway : in out Railway; Train_ID : in Natural; Destination_ID : in Natural) is
   begin
      if not Contains_Train(A_Railway.All_Trains,Train_ID) then return; end if;

      Set_Destination(A_Railway.All_Trains, Train_ID, Destination_ID);
   end Set_Destination;


   -- Check if the train with the ID passed in will collide with something if it moves to its destination
   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean is
      Destination : Natural; -- The ID of the destination of the train
   begin
      if not Contains_Train(A_Railway.All_Trains, ID) Then return False; end if;

      Destination := Trains.Get_Destination(Train_Lists.Get_Train(A_Railway.All_Trains,ID)); -- Get the destination of the train from the train list
      if Train_Lists.On_Destination(A_Railway.All_Trains,Destination) then -- Checks if any trains are on the destination
         return True; -- There will be a collision
      else
         return False; -- No collision
      end if;
   end Check_Collision;


   -- Adds a station to the model railway
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) is
   begin
      -- First check if we can still fit more trains
      if Get_Count(A_Railway.All_Stations) < Get_Max(A_Railway.All_Stations) and then
        not Valid_Station_ID(A_Railway, Get_ID(A_Station)) and then Space_Left(A_Railway.All_Stations) then
         Station_Lists.Add_Station(A_Railway.All_Stations, A_Station);
      end if;
   end Add_Station;


   -- Add a track to the model railway
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) is
   begin
      -- First check if we can still fit more tracks
      if Get_Count(A_Railway.All_Tracks) < Get_Max(A_Railway.All_Tracks) and then
        not Valid_Track_ID(A_Railway, Get_ID(A_Track)) then
         Track_Lists.Add_Track(A_Railway.All_Tracks, A_Track);
         Station_Lists.Add_Track(A_Railway.All_Stations,A_Track); -- Might need to seperate this out
      end if;

   end Add_Track;


   -- Add a train to the model railway
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) is
   begin
      -- First check if we can still fit more tracks
      if Get_Count(A_Railway.All_Trains) < Get_Max(A_Railway.All_Trains) and then
        not Valid_Train_ID(A_Railway, Get_ID(A_Train)) and then Space_Left(A_Railway.All_Trains) then
         Train_Lists.Add_Train(A_Railway.All_Trains, A_Train);
      end if;
   end Add_Train;

   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean is
   begin
      if Get_Count(A_Railway.All_Stations) = 1 then return True; end if; -- Special case for only one Station

      -- Iterates through all stations calling a function that checks all other station are reachable from the one passed in
      for I in 1.. Get_Count(A_Railway.All_Stations) loop
         if  not Check_Reachability_Node(A_Railway, Get_Station_Index(A_Railway.All_Stations,I)) then return False;
         end if;
      end loop;
      return True;
   end Check_Reachability;

   -- Does DFS to find out of all stations are reachable from A_Station passed in
   function Check_Reachability_Node(A_Railway : in Railway; A_Station : in Station)return Boolean is
--        Station_Count : Natural; -- The total number of Stations in the railway
      Stack_Kinda : Station_Array := (others => Stations.Create(0)); -- Create a array max size number of stations
      Discovered : Nat_Array := (others => 0); -- An array to store the IDs of the stations init to 0
      Stack_Height_Index : Natural; -- The current height of the stack
      Popped_Station : Station; -- The Station popped that is being processed
      Dest_Station : Natural; -- The ID of the destination of the track being processed
      Max_Index_Discovered : Natural; -- The max index in the array of discovered stations
      Index : Natural; -- Var used for checks
   begin
      Stack_Height_Index := 0; -- Init stack index to 0 since nothing is on the stack yet
      Max_Index_Discovered := 0; -- Init discovered index

      Index := 1;

      if (Index in Stack_Kinda'First..Stack_Kinda'Last) then -- Index check
         Stack_Kinda(Stack_Height_Index + 1) := Station_Lists.Get_Station_Index(A_Railway.All_Stations,1); -- Put the first station on the stack +1 because stack is empty
         Stack_Height_Index := 1; -- Increment stack height now points to the top of the stack

         while Stack_Height_Index /= 0 and Stack_Height_Index <= Stack_Kinda'Last and Stack_Height_Index >= Stack_Kinda'First -- Keep looping untill stack is empty
         loop
            Popped_Station := Stack_Kinda(Stack_Height_Index); -- Assign top item on stack
            Stack_Height_Index := Stack_Height_Index -1; -- Decrement stack height

            if (not Contains_ID(Discovered,Max_Index_Discovered,Get_ID(Popped_Station))) and then Max_Index_Discovered < Natural'Last then
               Put_Line("Adding");
               Max_Index_Discovered := Max_Index_Discovered + 1; -- Increment discovered
               Discovered(Max_Index_Discovered) := Get_ID(Popped_Station); -- Add to discovered array
            end if;


            for I in 1.. Track_Lists.Get_Count(Popped_Station.Out_Tracks) loop -- Loop through all outgoing tracks of the popped stations tracks

               Dest_Station := Tracks.Get_Destination(Track_Lists.Get_Track_Index(Popped_Station.Out_Tracks,I)); -- Get the destination of the track going out of the station

               if not Contains_ID(Discovered,Max_Index_Discovered,Dest_Station) then -- Check to make sure not already processed


                  if not (Stack_Height_Index < Natural'Last) then return false; end if; -- Overflow Check

                  if not Contains_Station(A_Railway.All_Stations,Dest_Station) then return False; end if; -- Check Station exists
                  Put_Line("In here 2");

                  Index := Stack_Height_Index + 1;

                  if (Index in Stack_Kinda'First..Stack_Kinda'Last) then
                     Stack_Kinda(Index) := Station_Lists.Get_Station(A_Railway.All_Stations,Dest_Station); -- Put the  dest station on the stack
                     Stack_Height_Index := Stack_Height_Index + 1; -- Increment stack height
                  end if;


                  if Max_Index_Discovered < Natural'Last then
                     Max_Index_Discovered := Max_Index_Discovered + 1; -- Increment discovered
                     Discovered(Max_Index_Discovered) := Dest_Station; -- Add to discovered array
                  end if;
               end if;
            end loop;
         end loop;

      end if;
               Put_Line("Max Index");
      return Max_Index_Discovered = Station_Lists.Get_Count(A_Railway.All_Stations); -- If the nodes in the railway is equal to the ones found then it is reachable
   end Check_Reachability_Node;

   -- helper function for DFS for checking ID in array of discovered IDs
   function Contains_ID(IDs : in Nat_Array; Max_Index : in Natural; ID : in Natural)return Boolean is
   begin
      for I in 1..Max_Index loop
           if I <= Nat_Array'Last then
            if  IDs(I) = ID then -- The ID already Exists
               return True;
            end if;
           end if;
      end loop;
      return False; -- ID does not exist
   end Contains_ID;


   -- Moves a train to its destination
   procedure Move_Train(A_Railway : in out Railway; ID : Natural) is
   begin
      if not Get_Started(A_Railway) then return; end if;
      if not Train_Lists.Contains_Train(A_Railway.All_Trains, ID) then return; end if;

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

   -- Returns true if the Track ID exists in the railway
   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return Track_Lists.Contains_Track(A_Railway.All_Tracks, ID);
   end Valid_Track_ID;

   -- Returns true if the Track or station ID exists in the railway
   function Valid_Track_Or_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean is
   begin
      return Valid_Track_ID(A_Railway, ID) or else Valid_Station_ID(A_Railway, ID);
   end Valid_Track_Or_Station_ID;

   function Get_Started(A_Railway : in Railway)return Boolean is (A_Railway.Started);

end Railways;
