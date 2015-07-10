require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'assigns a new user to the instance variable' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before(:each) do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it 'creates a user' do
        expect(User.all.count).to eq(1)
      end

      it 'puts the user in the session' do
        expect(session[:user_id]).to_not be_nil
      end

      it 'redirects to the homepage/root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid input' do
      before(:each) do
        post :create, user: Fabricate.attributes_for(:user, password: 'pwd123')
      end

      it 'does not create a new user' do
        expect(User.all).to be_empty
      end

      it 'renders the new user template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET show' do
    it 'sets the user variable' do
      crono = Fabricate(:user)
      get :show, id: crono.id
      expect(assigns(:user)).to eq(crono)
    end

    it "redirects to the comic wall/root path when the user isn't found" do
      get :show, id: 42
      expect(response).to redirect_to root_path
    end
  end
end
