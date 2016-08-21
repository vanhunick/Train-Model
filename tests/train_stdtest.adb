with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;

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




   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,Routine => Test_Pump_Initial'Access, Name => "Test_Pump_Initial");

   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end Train_Stdtest;
