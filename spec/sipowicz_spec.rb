
describe Sipowicz do
  let(:user) { FactoryGirl.create :user }
  describe 'configure' do
    context 'on good params' do
      it 'assigns sipowicz class variables' do
        params = {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis'}
        expect(Sipowicz.configure({password: params[:user][:password], confirmation: params[:confirmation]})).to eq(true)
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do

      end
      it 'raises an error when an empty string is passed' do
      end
    end
  end
  describe '#valid_credentials?' do
    xit 'authenticates a user' do
      Sipowicz.valid_credentials?(user)
      expect(user.authenticate).to eq(true)
    end
    xit 'returns true if an a user object is authentic' do
    end
  end
  describe '#new_passwords_match?' do
    xit 'returns true if the user typed their password and confirmation correctly' do
    end
    xit 'returns false if the user types their password or confirmation incorrectly' do
    end
  end
  describe '#validate_user' do
  end
  describe '#fields_empty?' do
  end
  describe '#validation_redirect' do
  end
  describe '#validate_new_passwords' do
  end
end