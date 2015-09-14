describe CopDetectiveAssigner do

  let(:params) { {user: {new_password: 'Canadian Travis'}, password_again: 'Canadian Travis', password: 'supermanz'} }
  let(:keys) { {password: :new_password, confirmation: :password_again, old_password: :password} }
  let(:assigner) { CopDetectiveAssigner.new }

  describe '#set_keychain' do
    it 'sets the @@keychain array' do
      expect(assigner.set_keychain(keys)).to eq([:new_password, :password_again, :password])
    end
  end

  describe '#build_params' do
    it 'builds the @params hash' do
      assigner.set_keychain(keys)
      expect(assigner.build_params(params)).to eq({:new_password=>"Canadian Travis", :password_again=>"Canadian Travis", :password=>"supermanz"})
    end
  end

  describe '#translate_keys' do
    it 'sets the @@internal_keys hash' do
      assigner.set_keychain(keys)
      assigner.build_params(params)
      expect(assigner.translate_keys).to eq({:password=>"Canadian Travis", :confirmation=>"Canadian Travis", :old_password=>"supermanz"})
    end
  end

  describe '#configure' do
    it 'assigns class variables for the CopDetective class' do
      assigner.set_keychain(keys)
      assigner.build_params(params)
      assigner.translate_keys
      expect(assigner.configure).to eq('Canadian Travis')
    end
  end

end