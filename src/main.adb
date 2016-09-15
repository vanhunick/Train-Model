with Text_IO; use Text_IO;
with Trains; use Trains;
with Tracks; use Tracks;
with Railways; use Railways;
with Stations; use Stations;

procedure Main with SPARK_Mode => on is
      A_Railway : Railway;

      Station_1 : Stations.Station;
      Station_2 : Stations.Station;
      Station_3 : Stations.Station;
      Station_4 : Stations.Station;

      Track_1_To_2 : Tracks.Track;
      Track_2_To_3 : Tracks.Track;
      Track_3_To_4 : Tracks.Track;
      Track_4_To_5 : Tracks.Track;

   Train_1 : Train;
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

      Train_1 := Create(1, 0); -- Station the train off the tracks and stations

      Add_Station(A_Railway, Station_1);
      Add_Station(A_Railway, Station_2);
      Add_Station(A_Railway, Station_3);
      Add_Station(A_Railway, Station_4);

      Add_Track(A_Railway,Track_1_To_2);
      Add_Track(A_Railway,Track_2_To_3);
      Add_Track(A_Railway,Track_3_To_4);
      Add_Track(A_Railway,Track_4_To_5);

      Add_Train(A_Railway, Train_1);

      Set_Destination(A_Railway, 1, 1); -- Set destination of train 1 to station 1

      Move_Train(A_Railway, 1); -- Move train 1 to its destination


end Main;
