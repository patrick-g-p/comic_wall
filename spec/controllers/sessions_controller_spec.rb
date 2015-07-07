require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it 'renders the login form/new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    let(:a_user) {Fabricate(:user)}

    context 'with valid email and password' do
      before(:each) do
        post :create, {email: a_user.email, password: a_user.password}
      end

      it 'puts the user in the session' do
        expect(session[:user_id]).to eq(a_user.id)
      end

      it 'redirects to the homepage/root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with an invalid email/password' do
      before(:each) do
        post :create, {email: a_user.email, password: 'password123'}
      end

      it 'does not set the session user_id' do
        expect(session[:user_id]).to be_nil
      end

      it 'redirects to the login page' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET destroy' do
    let(:a_logged_in_user) {Fabricate(:user)}

    before(:each) do
      session[:user_id] = a_logged_in_user.id
      get :destroy
    end

    it 'sets the session user_id to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to the homepage/root path' do
      expect(response).to redirect_to root_path
    end
  end
end
