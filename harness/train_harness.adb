with AUnit.Reporter.Text;
with AUnit.Run;
with Train_Suite;
with Train_Stdsuite;

procedure Train_Harness is
   procedure Runner is new AUnit.Run.Test_Runner (Train_Stdsuite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Runner (Reporter);
end Train_Harness;
