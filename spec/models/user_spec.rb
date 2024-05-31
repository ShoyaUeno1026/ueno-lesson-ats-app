require "rails_helper"

RSpec.describe User, type: :model do
  describe "#save" do
    context "値が正しい場合" do
      let(:user) { build(:user, email: "test@example.com", password: "abcd1234", name: "名前 苗字", terms_of_service: true) }

      specify "保存できること" do
        expect do
          user.save
        end.to change { User.count }.by(1)

        last_user = User.last
        expect(last_user.email).to eq "test@example.com"
        expect(last_user.first_name).to eq "名前"
        expect(last_user.last_name).to eq "苗字"
      end
    end
  end
end
