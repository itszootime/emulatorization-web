describe Emulator do

  let(:project) { FactoryGirl.build(:trained_emulator_project) }
  let(:emulator) { project.emulator }

  describe "#generate" do
    describe "returned hash" do
      subject(:hash) { emulator.generate }

      it { should_not be_nil }
      it { should have_key(:type) }
      its([:type]) { should eql "LearningRequest" }
    end
  end

end
