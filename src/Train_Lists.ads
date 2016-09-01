with Trains; use Trains;

package Train_Lists with SPARK_Mode => on is

   Type Train_List is private;

   -- The underlying array of Trains
   type Train_Array is array (Positive range 1..100) of Train;

   -- Creates and returns an empty Train list
   function Create return Train_List;

   -- Add a Train to the list
   procedure Add_Train(A_Train_List : in out Train_List; A_Train : in Train) with
     pre => Get_Count(A_Train_List) < Get_Max(A_Train_List),
     post => Get_Count(A_Train_List) - 1 = Get_Count(A_Train_List)'old;

   function Get_Count(A_Train_List : in Train_List)return Integer;

   function Get_Max(A_Train_List : in Train_List)return Integer;

   function Get_Train(A_Train_List : in Train_List; ID : in Natural)return Train with
     pre => Contains_Train(A_Train_List,ID),
     post => Get_ID(Get_Train'Result) = ID;

   function Contains_Train(A_Train_List : in Train_List; ID : in Natural)return Boolean;


   private
   type Train_List is
      record
         Count : Integer;
         Trains : Train_Array;
         Max : Integer;
      end record;
end Train_Lists;
