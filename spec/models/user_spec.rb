require 'rails_helper'

RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do 
    @user = User.create!(name: "Test user", email: "u@g.com", password: "123")
  end
  describe "creation" do
    it "should have one item created after being created" do
      expect(User.all.count).to eq(1)
    end
  end
  describe "validation" do
    it "should not let a user be created without an email address" do
      @user.email = nil
      expect(@user).to_not be_valid
    end
  end
      
end
