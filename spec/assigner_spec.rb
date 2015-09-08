describe CopDetectiveAssigner do
  
  let(:good_config) {
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      }
  }

  describe '#set_keychain' do
    it 'sets the keychain class variable' do
      expect(CopDetectiveAssigner.set_keychain({password: :new_password, confirmation: :password_again, old_password: :password})).to eq([:new_password, :password_again, :password])
    end
  end

  # describe '#configure' do
  #   before(:each) do
  #     CopDetective.new(good_config)
  #   end
  #   context 'on good params' do
  #     it 'assigns CopDetective class variables' do
  #       expect(good_config).to eq('Canadian Travis')
  #     end
  #   end
  #   context 'on bad params' do
  #     it 'raises an error with nil params' do
  #       expect{CopDetective.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
  #     end
  #     it 'raises an error when an empty string is passed' do
  #       expect{CopDetective.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
  #     end
  #   end
  # end

end