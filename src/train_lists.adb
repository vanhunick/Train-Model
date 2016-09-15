with Trains; use Trains;
with Text_IO; use Text_IO;
package body Train_Lists with SPARK_Mode => on is

   function Create return Train_List is
      New_List : Train_List;
   begin
      New_List.Count := 0;
      New_List.Max := 100;
      New_List.Trains := (others => Trains.Create(0,0));
      return New_List;
   end Create;

   procedure Add_Train(A_Train_List : in out Train_List; A_Train : in Train) is
      Index_Check : Natural;
   begin
      if Get_Count(A_Train_List) < Natural'Last then -- Overflow Check
         Index_Check := Get_Count(A_Train_List) + 1;
         if Index_Check in 1..A_Train_List.Trains'Last then -- Index check
            A_Train_List.Trains(Index_Check) := A_Train;
            A_Train_List.Count := A_Train_List.Count + 1;
         end if;
      end if;
   end Add_Train;

   procedure Set_Destination(A_Train_List : in out Train_List; Train_ID : in Natural; Destination_ID : in Natural) is
   begin
      for I in 1..A_Train_List.Trains'Last loop
         if  Get_ID(A_Train_List.Trains(I)) = Train_ID then                  -- Here we have found the Train to add the track to
            Trains.Set_Destination(A_Train_List.Trains(I),Destination_ID);
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Train_List.Trains(J)) /= Train_ID);
      end loop;
   end Set_Destination;

   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train is
   begin
      for I in 1..A_Train_List.Trains'Last loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then
            return A_Train_List.Trains(I);
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Train_List.Trains(J)) /= ID);
      end loop;
      return A_Train_List.Trains(1);
   end Get_Train;

   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean is
   begin
      for I in 1..A_Train_List.Trains'Last loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the Train to add the track to
            return True;
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Train_List.Trains(J)) /= ID);
      end loop;

      return False;
   end Contains_Train;

   function On_Destination(A_Train_List : in Train_List; Dest_ID : in Natural)return Boolean is
   begin
      if not (Get_Count(A_Train_List) < A_Train_List.Trains'Last) then return False; end if;

      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_Location(A_Train_List.Trains(I)) = Dest_ID then                  -- Here we have found the Train to add the track to
            return True;
         end if;
      end loop;
      return False;
   end On_Destination;

   procedure Move_Train(A_Train_List : in out Train_List; ID : in Natural) is
   begin
      for I in 1..A_Train_List.Trains'Last loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the Train to add the track to
            Trains.Update_Location(A_Train_List.Trains(I));
            return;
         end if;
         pragma Loop_Invariant(for all J in 1..I => Get_ID(A_Train_List.Trains(J)) /= ID);
      end loop;
   end Move_Train;

   function Space_Left(A_Train_List : in Train_List) Return Boolean is
   begin
      if not (A_Train_List.Count < Natural'Last) then return False; end if;
      if not (A_Train_List.Count + 1 < A_Train_List.Trains'Last) then return False; end if;
      if not (A_Train_List.Count >= Natural'First) then return False; end if;
      return True;
   end Space_Left;

   function Get_Count(A_Train_List : in Train_List)return Natural is (A_Train_List.Count);

   function Get_Max(A_Train_List : in Train_List)return Natural is (A_Train_List.Max);

   function Get_Train_Index(A_Train_List : in Train_List; Index : in Natural)return Train is (A_Train_List.Trains(Index));

end Train_Lists;
