describe Assigner do
  
  let(:good_config) {
      {password: params[:user][:password], 
        confirmation: params[:confirmation],
        old_password: params[:old_password]
      }
  }

  describe '#configure' do
    before(:each) do
      CopDetective.new(good_config)
    end
    context 'on good params' do
      it 'assigns CopDetective class variables' do
        expect(good_config).to eq('Canadian Travis')
      end
    end
    context 'on bad params' do
      it 'raises an error with nil params' do
        expect{CopDetective.configure({password: nil, confirmation: nil})}.to raise_error(RuntimeError)
      end
      it 'raises an error when an empty string is passed' do
        expect{CopDetective.configure({password: '', confirmation: ''})}.to raise_error(RuntimeError)
      end
    end
  end

end