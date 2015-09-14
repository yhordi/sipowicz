describe CopDetectiveValidator do
  let(:user) {User.create(name: 'Topher', password: 'supermanz')}
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let!(:old_salt) { user.password_digest }

  let(:good_config) {
    CopDetective.configure(
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      })
  }

  describe '#valid_credentials?' do

    before(:each) do
      good_config
    end
    it 'returns true when passed an authentic user' do
      expect(CopDetectiveValidator.valid_credentials?(user, params[:old_password])).to eq(true)
    end
  end

  describe '#new_passwords_match?' do
    it 'returns true if the user typed their password and confirmation correctly' do
      expect(CopDetectiveValidator.new_passwords_match?(params[:user][:password], params[:confirmation])).to eq(true)
    end
    it 'returns false if the user types their password or confirmation incorrectly' do
      expect(CopDetectiveValidator.new_passwords_match?(params[:user][:password], 'blargh')).to eq(false)
    end
  end

  describe '#validate_new_passwords' do

    describe 'with valid params' do
      it "responds with a success message" do
        CopDetectiveValidator.validate_new_passwords(user, params[:user][:password], params[:confirmation])
        expect(CopDetectiveValidator.messages[:notice]).to eq("Password updated")
      end
    end

    describe 'with invalid params' do
      it "responds with an error" do
        expect(CopDetectiveValidator.validate_new_passwords(user, params[:user][:password], 'blargh')).to include("Your new password was not saved. Your new passwords don't match.")
      end
    end
  end
end