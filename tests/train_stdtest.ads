with AUnit;
with AUnit.Test_Cases;

package Train_Stdtest is

   type TC is new AUnit.Test_Cases.Test_Case with null record;

   -- before first scenario
   overriding procedure Set_Up_Case (T: in out TC);

   --before each scenario
   overriding procedure Set_Up (T: in out TC);

   -- after each scenario
   overriding procedure Tear_Down (T: in out TC);

   -- after last
   overriding procedure Tear_Down_Case (T: in out TC);

   procedure Register_Tests (T: in out TC);
   function Name (T: TC) return AUnit.Message_String;

end Train_Stdtest;
