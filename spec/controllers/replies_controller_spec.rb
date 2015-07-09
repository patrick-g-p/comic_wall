require 'spec_helper'

describe RepliesController do
  describe 'POST create' do
    let(:cool_comic) {Fabricate(:comic)}
    let(:another_user) {Fabricate(:user)}
    let(:active_discussion) {Fabricate(:discussion, comic: cool_comic, creator: another_user)}
    let(:new_reply) {Fabricate.attributes_for(:reply)}

    context 'with valid input' do
      before do
        set_current_user
        post :create, comic_id: cool_comic.id, discussion_id: active_discussion.id, reply: new_reply
      end

      it 'redirects back to the comic page' do
        expect(response).to redirect_to comic_discussion_path(cool_comic, active_discussion)
      end

      it 'creates a reply' do
        expect(Reply.all.count).to eq(1)
      end

      it 'associates the reply with the current user' do
        expect(Reply.first.creator).to eq(current_user)
      end

      it 'associates the reply with the discussion' do
        expect(Reply.first.discussion).to eq(active_discussion)
      end
    end

    context 'with invalid input' do
      before do
        set_current_user
        post :create, comic_id: cool_comic.id, discussion_id: active_discussion.id, reply: {body: ''}
      end

      it 'does not create a new reply' do
        expect(Reply.all.count).to eq(0)
      end

      it 'renders the discussion page' do
        expect(response).to render_template 'discussions/show'
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {post :create, comic_id: cool_comic.id, discussion_id: active_discussion.id, reply: {body: 'gotta login!'}}
    end
  end
end
