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
   type Nat_Array is array (Positive range <>) of Natural;

   -- Station stack
   type Station_Array is array (Positive range <>) of Station;

   -- Creates an empty railway, Creates lists for trains, tracks, and stations
   function Create return Railway with
   Post => Create'Result.Started = False;

   -- ===========================================================
   --                 Interactive procedures
   -- ===========================================================

   -- Starts the simulation, only if the railway is fully reachable
   procedure start(A_Railway : in out Railway) with
     Pre => Get_Started(A_Railway) = False and then Check_Reachability(A_Railway) = True,
     post => Get_Started(A_Railway) = True;


   -- Moves a train to its current destination
   procedure Move_Train(A_Railway : in out Railway; ID : Natural)with
     pre => Valid_Train_ID(A_Railway, ID) and then Get_Started(A_Railway) = True and then Check_Collision(A_Railway,ID);


   -- Add station to the model railway
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) with
   pre => Valid_Station_ID(A_Railway, Get_ID(A_Station)) = False and then Get_Count(A_Railway.All_Stations) < Get_Max(A_Railway.All_Stations);


   -- Add track to the model railway
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) with
   pre => Valid_Track_ID(A_Railway, Get_ID(A_Track)) = False;


   -- Adds a train to the Railway
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) with
   pre => Valid_Train_ID(A_Railway, Get_ID(A_Train)) = False;


   -- Updates the destination of the train
   procedure Set_Destination(A_Railway : in out Railway; Train_ID : in Natural; Destination_ID : in Natural) with
     Post => (if Valid_Train_ID(A_Railway, Train_ID) and then Check_Valid_Destination(A_Railway, Train_ID,Destination_ID) then -- Checks if the train exists that is had the new destination
                               Get_Destination(Get_Train(A_Railway.All_Trains, Train_ID)) = Destination_ID );


   -- ===========================================================
   --                 Checking Function
   -- ===========================================================


   -- Helper function for Depth first search
   function Contains_ID(IDs : in Nat_Array; Max_Index : in Natural; ID : in Natural)return Boolean;


   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean;

   -- Returns if the passed in ID is allowed to be used
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean with
     post => (if not Valid_Train_ID'Result then
                (for all I in 1..Get_Count(A_Railway.All_Trains) => Get_ID(Get_Train_Index(A_Railway.All_Trains,I)) /= ID)
                  else
             ((for some I in 1..Get_Count(A_Railway.All_Trains) => Get_ID(Get_Train_Index(A_Railway.All_Trains,I)) = ID)));

   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean;

   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean;

   function Check_Valid_Destination(A_Railway : in Railway; ID_Train : Natural; ID_Destination : in Natural)return Boolean;

   function Check_Reachability_Node(A_Railway : in Railway; A_Station : in Station)return Boolean;

   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean with
     pre => Valid_Train_ID(A_Railway, ID);

   -- Returns
   function Valid_Track_Or_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean;

   -- ===========================================================
   --                 Get Functions
   -- ===========================================================

   -- Returns if the simulation has been started
   function Get_Started(A_Railway : in Railway)return Boolean;

--  private
--     type Railway is
--        record
--           Started : Boolean;
--           All_Tracks : Track_List;
--           All_Stations : Station_List;
--           All_Trains : Train_List;
--        end record;
end Railways;
