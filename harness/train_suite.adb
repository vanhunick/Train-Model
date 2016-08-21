with AUnit.Test_Suites; use AUnit.Test_Suites;

function Train_Suite return Access_Test_Suite is
   TS_Ptr : constant Access_Test_Suite := new Test_Suite;
begin
   return TS_Ptr;
end Train_Suite;
