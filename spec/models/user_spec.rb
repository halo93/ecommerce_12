require "rails_helper"

RSpec.describe User, type: :model do
  let(:user){FactoryGirl.create :user}

  it ".admin_email" do
    user = FactoryGirl.create :user, role: :admin
    (User.admin_email).should include(user)
  end

  context "relationship" do
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :orders}
    it{is_expected.to have_many :favorites}
    it{is_expected.to have_many :suggests}
  end

  context "columns" do
    it{expect have_db_column(:name).of_type(:string)}
    it{expect have_db_column(:email).of_type(:string)}
    it{expect have_db_column(:encrypted_password).of_type(:string)}
    it{expect have_db_column(:avatar).of_type(:string)}
    it{expect have_db_column(:role).of_type(:integer)}
    it{expect have_db_column(:phone).of_type(:string)}
  end

  it "init role methods" do
    user = FactoryGirl.create :user
    user.role.should == "user"
  end

  auth_hash = OmniAuth::AuthHash.new(provider: "facebook",
    uid: "12345678",
    info: {
      email: "user@example.com",
      name: "User Example"
    })

  describe ".from_omniauth" do
    it "retrieves an existing user" do
      user = User.new(
        name: "User Example",
        provider: "facebook",
        uid: 12_345_678,
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      omniauth_user = User.from_omniauth auth_hash
      expect(user).to eq(omniauth_user)
    end

    it "creates a new user as long as it doesn't exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end
end
