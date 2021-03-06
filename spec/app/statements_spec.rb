require File.expand_path '../../spec_helper.rb', __FILE__

describe 'routes' do
  describe '/' do
    it 'redirects to /statements' do
      get '/'
      expect(last_response.header['Location']).to end_with '/statements'
    end

    it 'gives status code 303' do
      get '/'
      expect(last_response).to have_attributes status: 303
    end
  end

  describe '/statements' do
    it 'responds ok' do
      get '/statements'
      expect(last_response).to be_ok
    end
  end

  describe '/statements/{id}' do
    it 'responds ok' do
      get '/statements/fk'
      expect(last_response).to be_ok
    end
  end

  describe '/statements/{version}/{id}' do
    it 'gives 404 if no statement has name' do
      get '/statements/0.1/fk'
      expect(last_response.status).to eq 404
    end

    it 'gives 404 if no statement has id' do
      get '/statements/10000.01/ic-permission'
      expect(last_response.status).to eq 404
    end

    context 'with matching statement' do
      it 'responds ok' do
        get '/statements/0.0/ic-permission'
        expect(last_response).to be_ok
      end
    end
  end
end
