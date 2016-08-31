with Trains; use Trains;

package body Train_Lists with SPARK_Mode => on is

   -- Creates and returns an empty Train list
   function Create return Train_List is
      New_List : Train_List;
   begin
         New_List.Count := 0;
         New_List.Max := 10000;
         return New_List;
   end Create;

   -- Add a Train to the list
   procedure Add_Train(A_Train_List : in out Train_List; A_Train : in Train) is
   begin
      A_Train_List.Trains(A_Train_List.Count+1) := A_Train;
   end Add_Train;

   function Get_Count(A_Train_List : in Train_List)return Integer is (A_Train_List.Count);

   function Get_Max(A_Train_List : in Train_List)return Integer is (A_Train_List.Max);

   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train is
      begin
      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the station to add the track to
            return A_Train_List.Trains(I);
         end if;
      end loop;
      return A_Train_List.Trains(1); -- Should never get here
   end Get_Train;


   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean is
   begin
      for I in 1.. Get_Count(A_Train_List) loop
         if  Get_ID(A_Train_List.Trains(I)) = ID then                  -- Here we have found the station to add the track to
            return True;
         end if;
      end loop;
      return False; -- Should never get here
   end Contains_Train;

end Train_Lists;
