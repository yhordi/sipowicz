describe CopDetectiveAssigner do

  let(:params) { {user: {new_password: 'Canadian Travis'}, password_again: 'Canadian Travis', password: 'supermanz'} }


  describe '#set_keychain' do
    it 'sets the @@keychain array' do
      expect(CopDetectiveAssigner.set_keychain({password: :new_password, confirmation: :password_again, old_password: :password}, params)).to eq([:new_password, :password_again, :password])
    end
  end

  describe '#build_params' do
    it 'builds the @@params hash' do
      expect(CopDetectiveAssigner.build_params(params)).to eq({:new_password=>"Canadian Travis", :password_again=>"Canadian Travis", :password=>"supermanz"})
    end
  end

  describe '#translate_keys' do
    it 'sets the @@internal_keys hash' do
      expect(CopDetectiveAssigner.translate_keys).to eq({:password=>"Canadian Travis", :confirmation=>"Canadian Travis", :old_password=>"supermanz"})
    end
  end

  describe '#configure' do
    it 'assigns class variables for the CopDetective class' do
      expect(CopDetectiveAssigner.configure).to eq('Canadian Travis')
    end
  end

end