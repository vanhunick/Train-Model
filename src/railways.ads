with Track_Lists; use Track_Lists;
with Train_Lists; use Train_Lists;
with Station_Lists; use Station_Lists;
with Tracks; use Tracks;
with Trains; use Trains;
with Stations; use Stations;

package Railways with SPARK_Mode => on is

   Type Railway is private;

   type Nat_Array is array (Positive range <>) of Natural;

   type Station_Array is array (Positive range <>) of Station;


   function Create return Railway;

   procedure start(A_Railway : in out Railway) with
     Pre => Get_Started(A_Railway) = False and then Check_Reachability(A_Railway) = True,
     post => Get_Started(A_Railway) = True;

   -- Moves a train
   procedure Move_Train(A_Railway : in out Railway; ID : Natural)with
   pre => Valid_Train_ID(A_Railway, ID) and then Get_Started(A_Railway) = True and then Check_Collision(A_Railway,ID);

   -- Add inbound track to station
   procedure Add_Inbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track);

   -- Add outbound track to station
   procedure Add_Outbound(A_Railway : in out Railway; Station_ID : Natural; A_Track : in Track);

   -- Add station
   procedure Add_Station(A_Railway : in out Railway; A_Station : in Station) with
   pre => Valid_Station_ID(A_Railway, Get_ID(A_Station)) = False;

   -- Add track
   procedure Add_Track(A_Railway : in out Railway; A_Track : in Track) with
   pre => Valid_Track_ID(A_Railway, Get_ID(A_Track)) = False;


   -- Adds a train to the Railway
   procedure Add_Train(A_Railway : in out Railway; A_Train : in Train) with
   pre => Valid_Train_ID(A_Railway, Get_ID(A_Train)) = False;

   -- Checks if everything is still reachable after adding a track
   function Check_Reachability(A_Railway : Railway)return Boolean;

   -- Helper function for Depth first search
   function Contains_ID(IDs : in Nat_Array; Max_Index : in Natural; ID : in Natural)return Boolean;


   -- Returns if the passed in ID is allowed to be used
   function Valid_Train_ID(A_Railway : in Railway; ID : in Natural)return Boolean;
   function Valid_Station_ID(A_Railway : in Railway; ID : in Natural)return Boolean;
   function Valid_Track_ID(A_Railway : in Railway; ID : in Natural)return Boolean;

   function Get_Started(A_Railway : in Railway)return Boolean;

   function Check_Collision(A_Railway : in Railway; ID : in Natural)return Boolean with
     pre => Valid_Train_ID(A_Railway, ID);

   function Check_Reachability_Node(A_Railway : in Railway; A_Station : in Station)return Boolean;



private
   type Railway is
      record
         Started : Boolean;
         All_Tracks : Track_List;
         All_Stations : Station_List;
         All_Trains : Train_List;
      end record;
end Railways;
