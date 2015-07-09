require 'spec_helper'

describe ComicsController do
  describe 'GET index' do
    before(:each) do
      8.times {Fabricate(:comic)}
      get :index
    end

    it 'sets the comics variable' do
      expect(assigns(:comics)).to_not be_nil
    end

    it 'has 8 objects in the comics varaible' do
      expect(assigns(:comics).count).to eq(8)
    end
  end

  describe 'GET show' do
    let(:a_comic) {Fabricate(:comic)}

    it 'sets the comic variable' do
      get :show, id: a_comic.id
      expect(assigns(:comic)).to eq(a_comic)
    end

    context 'with a bad url' do
      it "redirects to the comic wall/rootpath if the comic isn't found" do
        get :show, id: 42
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET new' do
    context 'user is logged in' do
      before do
        set_current_user
      end

      it 'sets the comic variable' do
        get :new
        expect(assigns(:comic)).to be_a_new(Comic)
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {get :new}
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before(:each) do
        set_current_user
        post :create, comic: Fabricate.attributes_for(:comic)
      end

      it 'sets the comic variable' do
        expect(assigns(:comic)).to be_instance_of(Comic)
      end

      it 'creates a new comic' do
        expect(Comic.all.count).to eq(1)
      end

      it 'redirects to the comics show page' do
        a_comic = Comic.first
        expect(response).to redirect_to comic_path(a_comic.id)
      end
    end

    context 'with invalid input' do
      before(:each) do
        set_current_user
        post :create, comic: Fabricate.attributes_for(:comic, title: '')
      end

      it 'does not create a new comic' do
        expect(Comic.all.count).to eq(0)
      end
      it 'renders the new comic template' do
        expect(response).to render_template :new
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {post :create, comic: Fabricate.attributes_for(:comic)}
    end
  end
end
