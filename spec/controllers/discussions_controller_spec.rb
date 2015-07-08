require 'spec_helper'

describe DiscussionsController do
  let(:a_comic) {Fabricate(:comic)}

  describe 'GET new' do
    context 'with logged in user' do
      before(:each) do
        set_current_user
        get :new, comic_id: a_comic.id
      end

      it 'sets the discussion variable' do
        expect(assigns(:discussion)).to be_a_new(Discussion)
      end

      it 'sets the comic variable' do
        expect(assigns(:comic)).to eq(a_comic)
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {get :new, comic_id: a_comic.id}
    end
  end

  describe 'POST create' do
    context 'with logged in user' do
      let(:new_discussion) {Fabricate.build(:discussion)}

      context 'with valid input' do
        before(:each) do
          set_current_user
          post :create, comic_id: a_comic.id, discussion: {title: new_discussion.title, body: new_discussion.body}
        end

        it 'creates a new discussion' do
          expect(Discussion.all.count).to eq(1)
        end

        it 'creates a discussion associated with the comic' do
          discussion = Discussion.find_by(title: new_discussion.title)
          expect(discussion.comic).to eq(a_comic)
        end

        it 'creates a discussion assoicated with the current user' do
          discussion = Discussion.find_by(title: new_discussion.title)
          expect(discussion.creator).to eq(current_user)
        end

        it 'redirects to the comics discussion page' do
          discussion = Discussion.find_by(title: new_discussion.title)
          expect(response).to redirect_to comic_discussion_path(a_comic, discussion)
        end
      end

      context 'with invalid input' do
        before(:each) do
          set_current_user
          post :create, comic_id: a_comic.id, discussion: {title: new_discussion.title, body: ''}
        end

        it 'does not create a new discussion' do
          expect(Discussion.all.count).to eq(0)
        end

        it 'renders the new discussion form/template' do
          expect(response).to render_template :new
        end
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {post :create, comic_id: a_comic.id, discussion: Fabricate.attributes_for(:discussion)}
    end
  end

  describe 'GET show' do
    let(:awesome_discussion) {Fabricate(:discussion, comic: a_comic)}

    before(:each) do
      set_current_user
      get :show, comic_id: a_comic.id, id: awesome_discussion.id
    end

    it 'sets the discussion varaible' do
      expect(assigns(:discussion)).to eq(awesome_discussion)
    end

    it 'sets the comic variable' do
      expect(assigns(:comic)).to eq(a_comic)
    end
  end
end
