package Tracks with SPARK_Mode => on is

--     Type Track is private;

   type Track is
      record
         ID : Natural;
         Destination : Natural;
         Origin : Natural;
      end record;

   -- Creates and returns a Track type instance
   function Create(ID : in Natural; Destination : in Natural; Origin : in Natural)return Track with
     Post => Get_ID(Create'Result) = ID and then
     Get_Destination(Create'Result) = Destination and then
     Get_Origin(Create'Result) = Origin;

   -- Returns the ID of the track
   function Get_ID(A_Track : in Track)return Natural with
   post => Get_ID'Result = A_Track.ID;

   -- Returns the Destination of the track
   function Get_Destination(A_Track : in Track)return Natural with
   Post => Get_Destination'Result = A_Track.Destination;

   -- Returns the ID of the track
   function Get_Origin(A_Track : in Track)return Natural with
     post => Get_Origin'Result = A_Track.Origin;

--  private
--     type Track is
--        record
--           ID : Integer;
--           Destination : Integer;
--           Origin : Integer;
--        end record;
end Tracks;
