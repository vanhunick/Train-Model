with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with Tracks; use Tracks;
with Train_Lists;
with Track_Lists;
with Station_Lists;
with Stations; use Stations;
with Trains; use Trains;
with Railways; use Railways;

package body Train_stdtest is

   -- Decleare var

   -- Called before all the test cases
   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up_Case;


   -- Called before each test
   procedure Set_Up (T : in out TC) is
   begin
      null;
   end;

   -- Called after each test
   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");
   end;

   -- Called after last test
   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");

   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================


   -- ===========================================================
   --                 Tracks Package tested Induvidually
   -- ============================================================

   procedure Test_Create_Track(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Track : Tracks.Track;
   begin

      A_Track := Create(1,2,3);

      Assert (Condition => (Get_ID(A_Track) = 1),
              Message => "ID of the track should be set to 1");

      Assert (Condition => (Get_Destination(A_Track) = 2),
              Message => "Destination of the track should be set to 2");

      Assert (Condition => (Get_Origin(A_Track) = 3),
              Message => "Origin of the track should be set to 3");
   end Test_Create_Track;

   -- Creates two different Tracks and checks they are set to different values
   procedure Test_Create_Track_Two(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Track : Tracks.Track;
      B_Track : Tracks.Track;
   begin

      A_Track := Create(1,2,3);
      B_Track := Create(4,5,6);

      Assert (Condition => (Get_ID(A_Track) = 1),
              Message => "ID of the track A should be set to 1");

      Assert (Condition => (Get_Destination(A_Track) = 2),
              Message => "Destination of the track A should be set to 2");

      Assert (Condition => (Get_Origin(A_Track) = 3),
              Message => "Origin of the track A should be set to 3");

      Assert (Condition => (Get_ID(B_Track) = 4),
              Message => "ID of the track B should be set to 4");

      Assert (Condition => (Get_Destination(B_Track) = 5),
              Message => "Destination of the track B should be set to 5");

      Assert (Condition => (Get_Origin(B_Track) = 6),
              Message => "Origin of the track B should be set to 6");
   end Test_Create_Track_Two;

   -- ===========================================================
   --                 Lists Packages tested Induvidually
   -- ============================================================

   procedure Test_Create_Train_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Train_Lists.Train_List;
   begin
      A_List := Train_Lists.Create;

      Assert (Condition => (Train_Lists.Get_Count(A_List) = 0),
              Message => "The count of the List should be 0");
   end Test_Create_Train_List;

   procedure Test_Create_Track_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Track_Lists.Track_List;
   begin
      A_List := Track_Lists.Create;

      Assert (Condition => (Track_Lists.Get_Count(A_List) = 0),
              Message => "The count of the List should be 0");
   end Test_Create_Track_List;

   procedure Test_Create_Station_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Station_Lists.Station_List;
   begin
      A_List := Station_Lists.Create;

      Assert (Condition => (Station_Lists.Get_Count(A_List) = 0),
              Message => "The count of the List should be 0");
   end Test_Create_Station_List;


   procedure Test_Add_Station_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Station_Lists.Station_List;
      A_Station : Stations.Station;
   begin
      A_Station := Create(1);
      A_List := Station_Lists.Create;
      Station_Lists.Add_Station(A_List,A_Station);

      Assert (Condition => (Station_Lists.Get_Count(A_List) = 1),
              Message => "The count of the List should be 1 after adding station");
   end Test_Add_Station_List;

   procedure Test_Add_Track_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Track_Lists.Track_List;
      A_Track : Tracks.Track;
   begin
      A_Track := Create(1,1,1);
      A_List := Track_Lists.Create;
      Track_Lists.Add_Track(A_List,A_Track);

      Assert (Condition => (Track_Lists.Get_Count(A_List) = 1),
              Message => "The count of the List should be 1 after adding Track");
   end Test_Add_Track_List;

   procedure Test_Add_Train_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Train_Lists.Train_List;
      A_Train : Trains.Train;
   begin
      A_Train := Create(1, 0);
      A_List := Train_Lists.Create;
      Train_Lists.Add_Train(A_List,A_Train);

      Assert (Condition => (Train_Lists.Get_Count(A_List) = 1),
              Message => "The count of the List should be 1 after adding Train");
   end Test_Add_Train_List;

   procedure Test_Contains_Train_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Train_Lists.Train_List;
      A_Train : Trains.Train;
   begin
      A_Train := Create(1, 0);
      A_List := Train_Lists.Create;
      Train_Lists.Add_Train(A_List,A_Train);

      Assert (Condition => (Train_Lists.Contains_Train(A_List,1)),
              Message => "The list should contain the train with ID 1");

      Assert (Condition => ( not Train_Lists.Contains_Train(A_List,2)),
              Message => "The list should not contain the train with ID 2");
   end Test_Contains_Train_List;


   procedure Test_Contains_Track_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Track_Lists.Track_List;
      A_Track : Tracks.Track;
   begin
      A_Track := Create(1,1,1);
      A_List := Track_Lists.Create;
      Track_Lists.Add_Track(A_List,A_Track);

      Assert (Condition => (Track_Lists.Contains_Track(A_List,1)),
              Message => "The list should contain the Track with ID 1");

      Assert (Condition => ( not Track_Lists.Contains_Track(A_List,2)),
              Message => "The list should not contain the Track with ID 2");
   end Test_Contains_Track_List;

   procedure Test_Contains_Station_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Station_Lists.Station_List;
      A_Station : Stations.Station;
   begin
      A_Station := Create(1);
      A_List := Station_Lists.Create;
      Station_Lists.Add_Station(A_List,A_Station);

      Assert (Condition => (Station_Lists.Contains_Station(A_List,1)),
              Message => "The list should contain the Station with ID 1");

      Assert (Condition => ( not Station_Lists.Contains_Station(A_List,2)),
              Message => "The list should not contain the Station with ID 2");
   end Test_Contains_Station_List;

   procedure Test_Get_Station_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Station_Lists.Station_List;
      A_Station : Stations.Station;
   begin
      A_Station := Create(1);
      A_List := Station_Lists.Create;
      Station_Lists.Add_Station(A_List,A_Station);

      Assert (Condition => (Get_ID(Station_Lists.Get_Station(A_List,1)) = 1),
              Message => "The list should contain the Station with ID 1");
   end Test_Get_Station_List;

   procedure Test_Get_Track_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Track_Lists.Track_List;
      A_Track : Tracks.Track;
   begin
      A_Track := Create(1,1,1);
      A_List := Track_Lists.Create;
      Track_Lists.Add_Track(A_List,A_Track);

      Assert (Condition => (Get_ID(Track_Lists.Get_Track(A_List,1)) = 1),
              Message => "The list should contain the Track with ID 1");
   end Test_Get_Track_List;

   procedure Test_Get_Train_List(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_List : Train_Lists.Train_List;
      A_Train : Trains.Train;
   begin
      A_Train := Create(1,0);
      A_List := Train_Lists.Create;
      Train_Lists.Add_Train(A_List,A_Train);

      Assert (Condition => (Get_ID(Train_Lists.Get_Train(A_List,1)) = 1),
              Message => "The list should contain the Train with ID 1");
   end Test_Get_Train_List;

   -- Train list contains destination test

   procedure Test_Train_List_On_Destination(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Train_List : Train_Lists.Train_List;
      A_Train : Trains.Train;
   begin
      A_Train_List := Train_Lists.Create;
      A_Train := Create(1,0);
      Trains.Set_Destination(A_Train,2);
      Trains.Update_Location(A_Train);
      Trains.Update_Location(A_Train);
      Train_Lists.Add_Train(A_Train_List, A_Train);



      Assert (Condition => (Train_Lists.On_Destination(A_Train_List, 2) = True),
              Message => "The List should contain a train with of ID 2");


      Assert (Condition => (Train_Lists.On_Destination(A_Train_List, 1) = False),
              Message => "The List should not contain a train with of ID 1");


   end Test_Train_List_On_Destination;


   -- ===========================================================
   --                 Train Packages tested Induvidually
   -- ===========================================================

   procedure Test_Train_Create(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Train : Trains.Train;
   begin
      A_Train := Create(1,0);

      Assert (Condition => (Get_ID(A_Train) = 1),
              Message => "The Train should be created with ID 1");

      Assert (Condition => (Get_Destination(A_Train) = 0),
              Message => "The Train should be created with ID 1");


      Assert (Condition => (Get_Destination(A_Train) = 0),
              Message => "The Train should have default destination of 0");

   end Test_Train_Create;


   procedure Test_Train_Update_Location(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Train : Trains.Train;
   begin
      A_Train := Create(1,0);
      Set_Destination(A_Train, 2);
      Trains.Update_Location(A_Train);


      Assert (Condition => (Get_Location(A_Train) = 2),
              Message => "The Train should be on track with ID 2");
   end Test_Train_Update_Location;

   procedure Test_Train_Set_Destination(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Train : Trains.Train;
   begin
      A_Train := Create(1,0);
      Trains.Set_Destination(A_Train,2);

      Assert (Condition => (Get_Destination(A_Train) = 2),
              Message => "The Train should have destination of ID 2");

   end Test_Train_Set_Destination;



   -- ===========================================================
   --                 Station Packages tested Induvidually
   -- ===========================================================


   procedure Test_Create_Station(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Station : Stations.Station;
   begin
      A_Station := Create(1);

      Assert (Condition => (Stations.Get_ID(A_Station) = 1),
              Message => "The Station should have ID of 1");

   end Test_Create_Station;


   --     procedure Test_Create_Station(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   --        A_Station : Stations.Station;
   --     begin
   --        A_Station := Create(1);
   --
   --        Assert (Condition => (Stations.Get_ID(A_Station) = 1),
   --                Message => "The Station should have ID of 1");
   --
   --     end Test_Create_Station;



   -- ===========================================================
   --                 Railway Packages tested Induvidually
   -- ===========================================================


   -- ===========================================================
   --                 Test Railway Reachability
   -- ===========================================================

   procedure Test_Simple_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

      Track_To_2 : Tracks.Track;
      Track_To_1 : Tracks.Track;

   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      Track_To_2 := Create(3,2,1);
      Track_To_1 := Create(4,1,2);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);

      Add_Track(A_Railway,Track_To_1);
      Add_Track(A_Railway,Track_To_2);


      Assert (Condition => (Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should be reachable");

   end Test_Simple_Reachable;

   procedure Test_Complicated_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;
      Station_3 : Stations.Station;
      Station_4 : Stations.Station;

      Track_1_To_2 : Tracks.Track;
      Track_2_To_3 : Tracks.Track;
      Track_3_To_4 : Tracks.Track;
      Track_4_To_1 : Tracks.Track;

   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);
      Station_3 := Create(3);
      Station_4 := Create(4);

      Track_1_To_2 := Create(5,2,1);
      Track_2_To_3 := Create(6,3,2);
      Track_3_To_4 := Create(7,4,3);
      Track_4_To_1 := Create(8,1,4);


      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);
      Add_Station(A_Railway, Station_3);
      Add_Station(A_Railway, Station_4);

      Add_Track(A_Railway,Track_1_To_2);
      Add_Track(A_Railway,Track_2_To_3);
      Add_Track(A_Railway,Track_3_To_4);
      Add_Track(A_Railway,Track_4_To_1);


      Assert (Condition => (Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should be reachable");

   end Test_Complicated_Reachable;

   procedure Test_Complicated_Not_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;
      Station_3 : Stations.Station;
      Station_4 : Stations.Station;

      Track_1_To_2 : Tracks.Track;
      Track_2_To_3 : Tracks.Track;
      Track_3_To_4 : Tracks.Track;
      Track_4_To_5 : Tracks.Track;

   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);
      Station_3 := Create(3);
      Station_4 := Create(4);

      Track_1_To_2 := Create(5,2,1);
      Track_2_To_3 := Create(6,3,2);
      Track_3_To_4 := Create(7,4,3);
      Track_4_To_5 := Create(8,5,4);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);
      Add_Station(A_Railway, Station_3);
      Add_Station(A_Railway, Station_4);

      Add_Track(A_Railway,Track_2_To_3);
      Add_Track(A_Railway,Track_3_To_4);
      Add_Track(A_Railway,Track_4_To_5);

      Assert (Condition => (not Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should not be reachable");

   end Test_Complicated_Not_Reachable;


   procedure Test_Simple_Not_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

      Track_To_2 : Tracks.Track;
      Track_To_1 : Tracks.Track;

   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      Track_To_2 := Create(3,2,1);
      Track_To_1 := Create(4,1,2);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);

      Add_Track(A_Railway,Track_To_1);

      Assert (Condition => ( not Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should not be reachable");

   end Test_Simple_Not_Reachable;

      procedure Test_Edge_Case_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;
      Station_1 : Stations.Station;

   begin
      A_Railway := Create;

      Station_1 := Create(1);

      Add_Station(A_Railway, Station_1);

      Assert (Condition => (Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should be reachable");

   end Test_Edge_Case_Reachable;

   procedure Test_Case_No_Tracks_Not_Reachable(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);


      Assert (Condition => (not Railways.Check_Reachability(A_Railway)),
              Message => "The Railway Should not be reachable");

   end Test_Case_No_Tracks_Not_Reachable;


   -- ===========================================================
   --                 Test Destination check function
   -- ===========================================================

   procedure Test_Check_Valid_Destination(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

      A_Train : Train;

      Track_To_2 : Tracks.Track;
   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      A_Train := Create(1,1); -- Place on station 1

      Track_To_2 := Create(3,2,1);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);

      Add_Track(A_Railway, Track_To_2);

      Add_Train(A_Railway, A_Train);


      Assert (Condition => (Check_Valid_Destination(A_Railway,1,3)),
              Message => "Should be a valid destination");

      Assert (Condition => (not Check_Valid_Destination(A_Railway,1,4)),
              Message => "Should not be a valid destination");


   end Test_Check_Valid_Destination;

   procedure Test_Check_Valid_Destination_Other(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

      A_Train : Train;

      Track_To_1 : Tracks.Track;
   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      A_Train := Create(1,0); -- Place of station or track

      Track_To_1 := Create(3,2,1);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);

      Add_Track(A_Railway, Track_To_1);

      Add_Train(A_Railway, A_Train);


      Assert (Condition => (not Check_Valid_Destination(A_Railway,1,3)), -- Can't move to a track
              Message => "Should not be a valid destination");

      Assert (Condition => (Check_Valid_Destination(A_Railway,1,1)), -- Can move to any station from OTHER
              Message => "Should be a valid destination");

      Assert (Condition => (Check_Valid_Destination(A_Railway,1,2)),
              Message => "Should be a valid destination");
   end Test_Check_Valid_Destination_Other;

      procedure Test_Check_Valid_Destination_Track(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;

      A_Train : Train;

      Track_To_1 : Tracks.Track;
   begin
      A_Railway := Create;

      Station_1 := Create(1);
      Station_2 := Create(2);

      A_Train := Create(1,3); -- Place of station or track

      Track_To_1 := Create(3,2,1);

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);

      Add_Track(A_Railway, Track_To_1);

      Add_Train(A_Railway, A_Train);


      Assert (Condition => (not Check_Valid_Destination(A_Railway,1,1)), -- Can't move to station 1
              Message => "Should not be a valid destination");

      Assert (Condition => (Check_Valid_Destination(A_Railway,1,2)), -- Can move to station 2
              Message => "Should be a valid destination");

   end Test_Check_Valid_Destination_Track;

   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,Routine => Test_Create_Track'Access, Name => "Test_Create_Track");

      Register_Routine (Test => T,Routine => Test_Create_Track_Two'Access, Name => "Test_Create_Track_Two");

      Register_Routine (Test => T,Routine => Test_Create_Train_List'Access, Name => "Test_Create_Train_List");

      Register_Routine (Test => T,Routine => Test_Create_Track_List'Access, Name => "Test_Create_Track_List");

      Register_Routine (Test => T,Routine => Test_Create_Station_List'Access, Name => "Test_Create_Station_List");

      Register_Routine (Test => T,Routine => Test_Add_Station_List'Access, Name => "Test_Add_Station_List");

      Register_Routine (Test => T,Routine => Test_Add_Train_List'Access, Name => "Test_Add_Train_List");

      Register_Routine (Test => T,Routine => Test_Add_Track_List'Access, Name => "Test_Add_Track_List");

      Register_Routine (Test => T,Routine => Test_Contains_Train_List'Access, Name => "Test_Contains_Train_List");

      Register_Routine (Test => T,Routine => Test_Contains_Track_List'Access, Name => "Test_Contains_Track_List");

      Register_Routine (Test => T,Routine => Test_Contains_Station_List'Access, Name => "Test_Contains_Station_List");

      Register_Routine (Test => T,Routine => Test_Get_Station_List'Access, Name => "Test_Get_Station_List");

      Register_Routine (Test => T,Routine => Test_Get_Track_List'Access, Name => "Test_Get_Track_List");

      Register_Routine (Test => T,Routine => Test_Train_Create'Access, Name => "Test_Train_Create");

      Register_Routine (Test => T,Routine => Test_Train_Update_Location'Access, Name => "Test_Train_Update_Location");

      Register_Routine (Test => T,Routine => Test_Train_Set_Destination'Access, Name => "Test_Train_Set_Destination");

      Register_Routine (Test => T,Routine => Test_Create_Station'Access, Name => "Test_Create_Station");

      Register_Routine (Test => T,Routine => Test_Train_List_On_Destination'Access, Name => "Test_Train_List_On_Destination");

      Register_Routine (Test => T,Routine => Test_Simple_Reachable'Access, Name => "Test_Simple_Reachable");

      Register_Routine (Test => T,Routine => Test_Simple_Not_Reachable'Access, Name => "Test_Simple_Not_Reachable");

      Register_Routine (Test => T,Routine => Test_Complicated_Not_Reachable'Access, Name => "Test_Complicated_Not_Reachable");



      Register_Routine (Test => T,Routine => Test_Edge_Case_Reachable'Access, Name => "Test_Edge_Case_Reachable");

      Register_Routine (Test => T,Routine => Test_Case_No_Tracks_Not_Reachable'Access, Name => "Test_Case_No_Tracks_Not_Reachable");

      Register_Routine (Test => T,Routine => Test_Check_Valid_Destination'Access, Name => "Test_Check_Valid_Destination");

      Register_Routine (Test => T,Routine => Test_Check_Valid_Destination_Other'Access, Name => "Test_Check_Valid_Destination_Other");

      Register_Routine (Test => T,Routine => Test_Check_Valid_Destination_Track'Access, Name => "Test_Check_Valid_Destination_Track");

      Register_Routine (Test => T,Routine => Test_Complicated_Reachable'Access, Name => "Test_Complicated_Reachable");



   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end Train_Stdtest;
