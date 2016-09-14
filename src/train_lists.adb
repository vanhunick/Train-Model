with Trains; use Trains;
with Text_IO; use Text_IO;
package body Train_Lists with SPARK_Mode => on is

   Defualt_Train : Train := Trains.Create(0,0);

   -- Creates and returns an empty Train list
   function Create return Train_List is
      New_List : Train_List;
   begin
      New_List.Count := 0;
      New_List.Max := 100;
      New_List.Trains := (others => Defualt_Train);
      return New_List;
   end Create;

   -- Add a Train to the list
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
      if not (Get_Count(A_Train_List) < A_Train_List.Trains'Last) then return;  end if;


      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = Train_ID then                  -- Here we have found the Train to add the track to
            Trains.Set_Destination(A_Train_List.Trains(I),Destination_ID);
         end if;
      end loop;
   end Set_Destination;



   function Get_Count(A_Train_List : in Train_List)return Natural is (A_Train_List.Count);

   function Get_Max(A_Train_List : in Train_List)return Natural is (A_Train_List.Max);

   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train is
   begin
      if not (Get_Count(A_Train_List) < A_Train_List.Trains'Last) then return A_Train_List.Trains(1); end if; -- I know this is not ideal


      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the Train to add the track to
            return A_Train_List.Trains(I);
         end if;
      end loop;
      return A_Train_List.Trains(1); -- Should never get here
   end Get_Train;


   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean is
   begin
      if not (Get_Count(A_Train_List) < A_Train_List.Trains'Last) then return False; end if;

      for I in 1..Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the Train to add the track to
            return True;
         end if;
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
      if not (Get_Count(A_Train_List) < A_Train_List.Trains'Last) then return ; end if;


      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the Train to add the track to
            Trains.Update_Location(A_Train_List.Trains(I));
         end if;
      end loop;
   end Move_Train;

   function Get_Train_Index(A_Train_List : in Train_List; Index : in Natural)return Train is (A_Train_List.Trains(Index));

   function Space_Left(A_Train_List : in Train_List) Return Boolean is
   begin
      if not (A_Train_List.Count < Natural'Last) then return False; end if;

      if not (A_Train_List.Count + 1 < A_Train_List.Trains'Last) then return False; end if;

      if not (A_Train_List.Count >= Natural'First) then return False; end if;

      return True;
   end Space_Left;


end Train_Lists;
