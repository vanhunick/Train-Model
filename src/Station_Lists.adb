with Stations; use Stations;

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
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID then                  -- Here we have found the station to add the track to
            Stations.Add_Inbound(A_Station_List.Stations(I), A_Track);
         end if;
      end loop;
   end Add_Inbound;

   -- Add an outbound track to the station
   procedure Add_Outbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track) is
   begin
      for I in 1.. Get_Count(A_Station_List) loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID then                  -- Here we have found the station to add the track to
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
