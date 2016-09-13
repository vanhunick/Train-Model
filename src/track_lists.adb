with Tracks; use Tracks;

package body Track_Lists with SPARK_Mode => on is

      Defualt_Track : Track := Tracks.Create(0,0,0);

   -- Creates and returns an empty track list
   function Create return Track_List is
      New_List : Track_List;
   begin
      New_List.Count := 0;
      New_List.Max := 100;
      New_List.Tracks := (others => Defualt_Track);
      return New_List;
   end Create;

   -- Add a track to the list
   procedure Add_Track(A_Track_List : in out Track_List; A_Track : in Track) is
   begin
      for I in 1..A_Track_List.Tracks'Last  loop
         if  Get_Count(A_Track_List) < Natural'Last and then I = Get_Count(A_Track_List) + 1 then
            A_Track_List.Tracks(I) := A_Track;
            A_Track_List.Count := A_Track_List.Count + 1;
         end if;
      end loop;
   end Add_Track;

   function Get_Count(A_Track_List : in Track_List)return Natural is (A_Track_List.Count);

   function Get_Max(A_Track_List : in Track_List)return Natural is (A_Track_List.Max);

   function Get_Track(A_Track_List : in Track_List; ID : in Natural)return Track is
   begin
      for I in 1.. Get_Count(A_Track_List) loop
         if  Get_ID(A_Track_List.Tracks(I)) = ID then                  -- Here we have found the station to add the track to
            return A_Track_List.Tracks(I);
         end if;
      end loop;
      return A_Track_List.Tracks(1); -- Should never get here
   end Get_Track;

   function Get_Track_Index(A_Track_List : in Track_List; Index : in Natural)return Track is
   begin
      return A_Track_List.Tracks(Index);
   end Get_Track_Index;


   function Contains_Track(A_Track_List : in Track_List; ID : in Natural)return Boolean is
   begin
--        if not Get_Count(A_Train_List) <= A_Train_List.Trains'Last then return False;

      for I in 1.. Get_Count(A_Track_List) loop
         if  Get_ID(A_Track_List.Tracks(I)) = ID then
            return True;
         end if;
      end loop;
      return False;
   end Contains_Track;


end Track_Lists;
