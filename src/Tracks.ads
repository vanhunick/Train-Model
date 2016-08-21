package Tracks with SPARK_Mode => on is

   Type Track is private;

   -- Creates and returns a Track type instance
   function Create(ID : in Integer; Destination : in Integer; Origin : in Integer)return Track;

   -- Returns the ID of the track
   function Get_ID(A_Track : in Track)return Integer;

   -- Returns the Destination of the track
   function Get_Destination(A_Track : in Track)return Integer;

   -- Returns the ID of the track
   function Get_Origin(A_Track : in Track)return Integer;

private
   type Track is
      record
         ID : Integer;
         Destination : Integer;
         Origin : Integer;
      end record;
end Tracks;
