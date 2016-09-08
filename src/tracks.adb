package body Tracks with SPARK_Mode => on is


   -- Creates and returns a Track type instance
   function Create(ID : in Natural; Destination : in Natural; Origin : in Natural)return Track is
      New_Track : Track;
   begin
      New_Track.ID := ID;
      New_Track.Destination := Destination;
      New_Track.Origin := Origin;
      return New_Track;
   end Create;

   -- Returns the ID of the track
   function Get_ID(A_Track : in Track)return Natural is
   begin
      return A_Track.ID;
   end Get_ID;

   -- Returns the Destination of the track
   function Get_Destination(A_Track : in Track)return Natural is
   begin
      return A_Track.Destination;
   end Get_Destination;

   -- Returns the ID of the track
   function Get_Origin(A_Track : in Track)return Natural is
   begin
      return A_Track.Origin;
   end Get_Origin;

end Tracks;
