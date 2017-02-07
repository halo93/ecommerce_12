require "rails_helper"

RSpec.describe User, type: :model do
  describe "User validation" do
    context "association" do
      it {expect have_many(:orders)}
      it {expect have_many(:comments)}
      it {expect have_many(:favorites)}
      it {expect have_many(:suggests)}
    end

    context "column_specifications" do
      it {expect have_db_column(:name).of_type(:string)}
      it {expect have_db_column(:email).of_type(:string)}
      it {expect have_db_column(:avatar).of_type(:string)}
      it {expect have_db_column(:phone).of_type(:string)}
      it {expect have_db_column(:role).of_type(:integer)}
      it {expect have_db_column(:encrypted_password).of_type(:string)}
    end
  end

  it "init role methods" do
    user = FactoryGirl.create :user
    expect(user.role).to eql "user"
  end

  auth_hash = OmniAuth::AuthHash.new({
    provider: "facebook",
    uid: "1102",
    info: {
      name: "Conan",
      email: "shinichi@framgia.com"
    }
  })

  describe "social login" do
    it ".from_omniauth" do
      user = FactoryGirl.create(:user, provider: "facebook",
        uid: "1102",
        email: "shinichi@framgia.com",
        password: "foobar",
        password_confirmation: "foobar")
      user.save
      fb_user = User.from_omniauth(auth_hash)
      expect(user).to eq(fb_user)
    end

    it "create new user if one does no exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end
end
