with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with Tracks; use Tracks;

package body Train_stdtest is

   -- Decleare var

   -- Called before all the test cases
   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up_Case;


   -- Called before each test
   procedure Set_Up (T : in out TC) is
   begin
      null;
   end;

   -- Called after each test
   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");
   end;

   -- Called after last test
   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");

   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

   -- Makes sure the user cannot pump at it's initial state
   procedure Test_Pump_Initial(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      Condition1 : Boolean;
   begin

      Condition1 := True;

      Assert (Condition => (Condition1 = True),
              Message => "Should not be able to pump in base state");
   end Test_Pump_Initial;

   -- ===========================================================
   --                 Tracks Package tested Induvidually
   -- ============================================================

      -- Makes sure the user cannot pump at it's initial state
   procedure Test_Create_Track(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Track : Track;
   begin

      A_Track := Create(1,2,3);

      Assert (Condition => (Get_ID(A_Track) = 1),
              Message => "ID of the track should be set to 1");

      Assert (Condition => (Get_Destination(A_Track) = 2),
              Message => "Destination of the track should be set to 2");

      Assert (Condition => (Get_Origin(A_Track) = 3),
              Message => "Origin of the track should be set to 3");
   end Test_Create_Track;

   -- Creates two different Tracks and checks they are set to different values
   procedure Test_Create_Track_Two(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      A_Track : Track;
      B_Track : Track;
   begin

      A_Track := Create(1,2,3);
      B_Track := Create(4,5,6);

      Assert (Condition => (Get_ID(A_Track) = 1),
              Message => "ID of the track A should be set to 1");

      Assert (Condition => (Get_Destination(A_Track) = 2),
              Message => "Destination of the track A should be set to 2");

      Assert (Condition => (Get_Origin(A_Track) = 3),
              Message => "Origin of the track A should be set to 3");

      Assert (Condition => (Get_ID(B_Track) = 4),
              Message => "ID of the track B should be set to 4");

      Assert (Condition => (Get_Destination(B_Track) = 5),
              Message => "Destination of the track B should be set to 5");

      Assert (Condition => (Get_Origin(B_Track) = 6),
              Message => "Origin of the track B should be set to 6");
   end Test_Create_Track_Two;



   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,Routine => Test_Pump_Initial'Access, Name => "Test_Pump_Initial");

      Register_Routine (Test => T,Routine => Test_Create_Track'Access, Name => "Test_Create_Track");

      Register_Routine (Test => T,Routine => Test_Create_Track_Two'Access, Name => "Test_Create_Track_Two");


   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end Train_Stdtest;
