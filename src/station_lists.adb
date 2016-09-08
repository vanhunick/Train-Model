with Stations; use Stations;
with Text_IO; use Text_IO;

package body Station_Lists with SPARK_Mode => on is

   -- Creates and returns an empty Station list
   function Create return Station_List is
      New_List : Station_List;
   begin
         New_List.Count := 0;
         New_List.Max := 100;
         return New_List;
   end Create;

   -- Add a Station to the list
   procedure Add_Station(A_Station_List : in out Station_List; A_Station : in Station) is
   begin
      A_Station_List.Stations(A_Station_List.Count+1) := A_Station;
      A_Station_List.Count := A_Station_List.Count+1;
   end Add_Station;

   -- Add an inbound track to the station
   procedure Add_Inbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track) is
   begin
      Put_Line("Adding Inbound");
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID then                  -- Here we have found the station to add the track to
            Put_Line("Found Inbound");
            Stations.Add_Inbound(A_Station_List.Stations(I), A_Track);
         end if;
      end loop;
   end Add_Inbound;

   procedure Add_Track(A_Station_List : in out Station_List; A_Track : in Track) is
   begin
      Put_Line("Adding Track");
      Add_Outbound(A_Station_List, Get_Origin(A_Track), A_Track);
      Add_Inbound(A_Station_List, Get_Destination(A_Track), A_Track);
   end Add_Track;


   -- Add an outbound track to the station
   procedure Add_Outbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track) is
   begin
      Put_Line("Adding Outbound");
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID then
            Put_Line("Found Outbound");
            Stations.Add_Outbound(A_Station_List.Stations(I), A_Track);
         end if;
      end loop;
   end Add_Outbound;


   function Get_Count(A_Station_List : in Station_List)return Integer is (A_Station_List.Count);

   function Get_Max(A_Station_List : in Station_List)return Integer is (A_Station_List.Max);

      function Get_Station(A_Station_List : in Station_List; ID : in Natural)return Station is
      begin
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = ID then                  -- Here we have found the station to add the track to
            return A_Station_List.Stations(I);
         end if;
      end loop;
      return A_Station_List.Stations(1); -- Should never get here
   end Get_Station;

   -- Used to iterate through the list
   function Get_Station_Index(A_Station_List : in Station_List; Index : in Natural)return Station is
   begin
      return A_Station_List.Stations(Index);
   end Get_Station_Index;




   function Contains_Station(A_Station_List : in Station_List; ID : Natural)return Boolean is
   begin
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = ID then
            return True;
         end if;
      end loop;
      return False;
   end Contains_Station;



end Station_Lists;
