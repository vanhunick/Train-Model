with Track_Lists; use Track_Lists;
with Train_Lists; use Train_Lists;
with Station_Lists; use Station_Lists;
with Tracks; use Tracks;
with Trains; use Trains;
with Stations; use Stations;

package Railways with SPARK_Mode => on is

   --Type Railway is private;

   -- Public for pre and post conditions
   type Railway is
      record
         Started : Boolean;
         All_Tracks : Track_List;
         All_Stations : Station_List;
         All_Trains : Train_List;
      end record;

   -- Array of found IDs for reachability
   type Nat_Array is array (Natural range 1..100) of Natural;

   -- Station stack
   type Station_Array is array (Positive range 1..100) of Station;

   -- Creates an empty railway, Creates lists for trains, tracks, and stations
   function Create return Railway with
   Post => Create'Result.Started = False;

   -- ===========================================================
   --                 Interactive procedures
   -- ===========================================================

   -- Starts the simulation, only if the railway is fully reachable
   procedure start(A_Railway : in out Railway) with
     Post=> (if A_Railway.Started then A_Railway'old.Started or Check_Reachability(A_Railway'old));


   -- Moves a train to its current destination
   procedure Move_Train(A_Railway : in out Railway; ID : Natural)with
     Post => (if Contains_Train(A_Railway.All_Trains, ID) and then not check_Collision(A_Railway'old,ID) and then Get_Started(A_Railway'old) then
        		Get_Train(A_Railway.All_Trains,ID).Cur_Location_ID = Get_Train(A_Railway'old.All_Trains,ID).Destination);



   -- Add station to the model railway
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) with
     -- Check if the ID is valid and the count will not be more than can fit in the array
     Post => (if Space_Left(A_Railway'old.All_Stations) and  not Valid_Station_ID(A_Railway'old, A_Station.ID) then
                  Contains_Station(A_Railway.All_Stations , A_Station.ID)
                    else
                      A_Railway = A_Railway'old);



   -- Add track to the model railway
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) with
     Post => (if (Valid_Track_ID(A_Railway'old, Get_ID(A_Track)) and then Get_Count(A_Railway'old.All_Tracks) < Get_Max(A_Railway'old.All_Tracks)) then
                Get_Count(A_Railway'old.All_Tracks) = Get_Count(A_Railway.All_Tracks) + 1
              and then Get_Track(A_Railway.All_Tracks,A_Track.ID) = A_Track
                  else
                    A_Railway = A_Railway'old);


   -- Adds a train to the Railway
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) with
     Post => (if (Valid_Train_ID(A_Railway'old, Get_ID(A_Train)) and then Get_Count(A_Railway'old.All_Trains) < Get_Max(A_Railway'old.All_Trains)) then
                Get_Count(A_Railway'old.All_Trains) = Get_Count(A_Railway.All_Trains) + 1
              and then Get_Train(A_Railway.All_Trains,A_Train.ID) = A_Train
                  else
                    A_Railway = A_Railway'old);


   -- Updates the destination of the train
   procedure Set_Destination(A_Railway : in out Railway; Train_ID : in Natural; Destination_ID : in Natural);-- with
--       Post => (if Contains_Train(A_Railway'old.All_Trains, Train_ID) and then Check_Valid_Destination(A_Railway'old, Train_ID,Destination_ID) then -- Checks if the train exists that is had the new destination
--                                 Get_Destination(Get_Train(A_Railway.All_Trains, Train_ID)) = Destination_ID );


   -- ===========================================================
   --                 Checking Function
   -- ===========================================================


   -- Helper function for Depth first search
   function Contains_ID(IDs : in Nat_Array; ID : in Natural)return Boolean with
     post => (if not Contains_ID'Result then
                (for all I in 1..Nat_Array'Last => IDs(I) /= ID)
                  else
                (for some I in 1..Nat_Array'Last => IDs(I) = ID));


   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean;

   -- Returns if the passed in ID is allowed to be used
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean with
     Post => (if Valid_Train_ID'Result then
                Contains_Train(A_Railway.All_Trains,ID));

   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean with
          Post => (if Valid_Station_ID'Result then
              Contains_Station(A_Railway.All_Stations,ID));


   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean with
     Post => (if Valid_Track_ID'Result then
              Contains_Track(A_Railway.All_Tracks,ID));

   function Check_Valid_Destination(A_Railway : in Railway; ID_Train : Natural; ID_Destination : in Natural)return Boolean;

   function Check_Reachability_Node(A_Railway : in Railway; A_Station : in Station)return Boolean;

   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean with
     pre => Contains_Train(A_Railway.All_Trains, ID),
     Post => (if Check_Collision'Result then
                (for some I in A_Railway.All_Trains.Trains'First..A_Railway.All_Trains.Trains'Last => A_Railway.All_Trains.Trains(I).Cur_Location_ID = Trains.Get_Destination(Train_Lists.Get_Train(A_Railway.All_Trains,ID)))
             else (for all I in A_Railway.All_Trains.Trains'First..A_Railway.All_Trains.Trains'Last => A_Railway.All_Trains.Trains(I).Cur_Location_ID /= Trains.Get_Destination(Train_Lists.Get_Train(A_Railway.All_Trains,ID))));

   -- Returns
   function Valid_Track_Or_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean with
   Post => (if Valid_Track_Or_Station_ID'Result then Valid_Track_ID(A_Railway,ID) or Valid_Station_ID(A_Railway,ID));

   -- ===========================================================
   --                 Get Functions
   -- ===========================================================

   -- Returns if the simulation has been started
   function Get_Started(A_Railway : in Railway)return Boolean with
     Post => Get_Started'Result = A_Railway.Started;


--  private
--     type Railway is
--        record
--           Started : Boolean;
--           All_Tracks : Track_List;
--           All_Stations : Station_List;
--           All_Trains : Train_List;
--        end record;
end Railways;
