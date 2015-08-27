
describe Sipowicz do
  # let(:user) { FactoryGirl.create :user }
  let(:new_user) {User.create(name: 'Topher', password: 'supermanz')}
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis'} }
  describe 'configure' do
    context 'on good params' do
      it 'assigns sipowicz class variables' do
        expect(Sipowicz.configure({password: params[:user][:password], confirmation: params[:confirmation]})).to eq('Canadian Travis')
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do
        expect{Sipowicz.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
      end
      it 'raises an error when an empty string is passed' do
        expect{Sipowicz.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
      end
    end
  end
  describe '#valid_credentials?' do
    before(:each) do
      Sipowicz.configure({password: 'password', confirmation: 'password'})
    end
    it 'authenticates a user' do
      p Sipowicz.valid_credentials?(new_user)
      # expect(Sipowicz.valid_credentials?(new_user)).to eq(true)
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