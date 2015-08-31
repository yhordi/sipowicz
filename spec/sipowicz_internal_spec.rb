describe SipowiczInternal do
  let(:new_user) {User.create(name: 'Topher', password: 'supermanz')}
  let(:params) { {user: {password: 'Canadian Travis'}, confirmation: 'Canadian Travis', old_password: 'supermanz'} }
  let(:good_config) {
    Sipowicz.configure(
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
      expect(SipowiczInternal.valid_credentials?(new_user, params[:old_password])).to eq(true)
    end
  end
  describe '#new_passwords_match?' do
    it 'returns true if the user typed their password and confirmation correctly' do
      expect(SipowiczInternal.new_passwords_match?(params[:user][:password], params[:confirmation])).to eq(true)
    end
    it 'returns false if the user types their password or confirmation incorrectly' do
      expect(SipowiczInternal.new_passwords_match?(params[:user][:password], 'blargh')).to eq(false)
    end
  end
end