with Text_IO; use Text_IO;
with Trains; use Trains;
with Tracks; use Tracks;
with Railways;
with Stations;

procedure Main with SPARK_Mode => on is

   The_Railway : Railways.Railway;

   Train_1 : Train;

   Track_1 : Track;
   Track_2 : Track;

   Station_1 : Stations.Station;
   Station_2 : Stations.Station;

begin
   The_Railway := Railways.Create;

   Train_1 := Trains.Create(1); -- ID DEST ORIG

   Track_1 := Create(1,1,2);
   Track_2 := Create(2,2,1);

   Station_1 := Stations.Create(1);
   Station_2 := Stations.Create(2);

   Railways.Add_Train(The_Railway,Train_1);

   Railways.Add_Track(The_Railway,Track_1);
   Railways.Add_Track(The_Railway,Track_2);

   Railways.Add_Station(The_Railway,Station_1);
   Railways.Add_Station(The_Railway,Station_2);


end Main;
