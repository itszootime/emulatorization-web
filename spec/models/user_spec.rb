describe User do

  let(:user) { FactoryGirl.create(:user) }

  it "is invalid without a first name" do
    user.first_name = nil
    user.should_not be_valid
  end

  it "is invalid without a last name" do
    user.last_name = nil
    user.should_not be_valid
  end

  describe "#full_name" do
    it "returns a combination of first and last name" do
      user.full_name.should == "#{user.first_name} #{user.last_name}"
    end
  end

end