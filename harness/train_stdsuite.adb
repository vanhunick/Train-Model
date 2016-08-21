with Train_Stdtest;

package body Train_Stdsuite is

   use AUnit.Test_Suites;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      TS_Ptr : constant Access_Test_Suite := new Test_Suite;
   begin
      TS_Ptr.Add_Test (new Train_Stdtest.TC) ;
      return TS_Ptr;
   end Suite;

end Train_Stdsuite;
