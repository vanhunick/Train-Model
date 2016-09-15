with Stations; use Stations;
with Text_IO; use Text_IO;

package body Station_Lists with SPARK_Mode => on is

   -- Creates and returns an empty Station list
   function Create return Station_List is
      New_List : Station_List;
   begin
      New_List.Count := 0;
      New_List.Max := 100;
      New_List.Stations := (others => Stations.Create(0));
      return New_List;
   end Create;

   -- Add a Station to the list
   procedure Add_Station(A_Station_List : in out Station_List; A_Station : in Station) is
      Index_Check : Natural;
   begin
      if Get_Count(A_Station_List) < Natural'Last then -- Overflow Check
         Index_Check := Get_Count(A_Station_List) + 1;

         if Index_Check in 1..A_Station_List.Stations'Last then -- Index check
            A_Station_List.Stations(Index_Check) := A_Station;
            A_Station_List.Count := A_Station_List.Count + 1;
         end if;
      end if;
   end Add_Station;

   -- Add an inbound track to the station
   procedure Add_Inbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track) is
   begin
      for I in 1.. A_Station_List.Stations'Last loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID and then Add_Inbound_check(A_Station_List.Stations(I), A_Track) then                  -- Here we have found the station to add the track to
            Stations.Add_Inbound(A_Station_List.Stations(I), A_Track);
         end if;
      end loop;
   end Add_Inbound;

   procedure Add_Track(A_Station_List : in out Station_List; A_Track : in Track) is
   begin
      Add_Outbound(A_Station_List, Get_Origin(A_Track), A_Track);
      Add_Inbound(A_Station_List, Get_Destination(A_Track), A_Track);
   end Add_Track;

   -- Add an outbound track to the station
   procedure Add_Outbound(A_Station_List : in out Station_List; Station_ID : in Natural; A_Track : in Track) is
   begin
      for I in 1.. A_Station_List.Stations'Last loop
         if  Get_ID(A_Station_List.Stations(I)) = Station_ID and then Add_Outbound_check(A_Station_List.Stations(I), A_Track) then
            Stations.Add_Outbound(A_Station_List.Stations(I), A_Track);
         end if;
      end loop;
   end Add_Outbound;

   function Get_Count(A_Station_List : in Station_List)return Natural is (A_Station_List.Count);

   function Get_Max(A_Station_List : in Station_List)return Natural is (A_Station_List.Max);

   function Get_Station(A_Station_List : in Station_List; ID : in Natural)return Station is
   begin
      for I in 1..A_Station_List.Stations'Last loop
         if  Get_ID(A_Station_List.Stations(I)) = ID then                  -- Here we have found the station to add the track to
            return A_Station_List.Stations(I);
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Station_List.Stations(J)) /= ID);
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
      for I in 1..A_Station_List.Stations'Last loop
         if  Get_ID(A_Station_List.Stations(I)) = ID then
            return True;
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Station_List.Stations(J)) /= ID);
      end loop;
      return False;
   end Contains_Station;

   function Space_Left(A_Station_List : in Station_List) Return Boolean is
   begin
      if not (A_Station_List.Count < Natural'Last) then return False; end if;
      if not (A_Station_List.Count + 1 < A_Station_List.Stations'Last) then return False; end if;
      if not  (A_Station_List.Count < A_Station_List.Max) then return False; end if;
      if not (A_Station_List.Count >= Natural'First) then return False; end if;
      return True;
   end Space_Left;

   function In_Range(A_Station_List : in Station_List; Index : in Natural) return Boolean is
   begin
      return Index in A_Station_List.Stations'First..A_Station_List.Stations'Last;
   end In_Range;

end Station_Lists;
