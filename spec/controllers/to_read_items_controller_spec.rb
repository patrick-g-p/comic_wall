require 'spec_helper'

describe ToReadItemsController do
  let(:barbara_gordon) {Fabricate(:user)}

  describe 'GET index' do
    context 'user is logged in' do
      before do
        set_current_user(barbara_gordon)
      end

      it 'sets the to read items variable' do
        a_comic = Fabricate(:comic)
        a_reading_item = Fabricate(:to_read_item, user: current_user, comic: a_comic)
        get :index
        expect(assigns(:to_read_items)).to eq([a_reading_item])
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {get :index}
    end
  end

  describe 'POST create' do
    let(:a_comic) {Fabricate(:comic)}

    context 'user is logged in' do
      before(:each) do
        set_current_user(barbara_gordon)
      end

      it 'redirects to the reading list' do
        post :create, comic_id: a_comic.id
        expect(response).to redirect_to reading_list_path
      end

      it 'sets the comic variable' do
        post :create, comic_id: a_comic.id
        expect(assigns(:comic)).to eq(a_comic)
      end

      it 'adds the reading item' do
        post :create, comic_id: a_comic.id
        expect(ToReadItem.count).to eq(1)
      end

      it 'associates the reading item with the comic' do
        post :create, comic_id: a_comic.id
        expect(ToReadItem.first.comic).to eq(a_comic)
      end

      it 'associates the reading item with the current user' do
        post :create, comic_id: a_comic.id
        expect(ToReadItem.first.user).to eq(current_user)
      end

      it 'places the reading item at the end of the list' do
        current_user.to_read_items << Fabricate(:to_read_item)
        post :create, comic_id: a_comic.id
        expect(ToReadItem.last.list_position).to eq(2)
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {post :create, comic_id: 1}
    end
  end

  describe 'DELETE destroy' do
    let(:a_decent_comic) {Fabricate(:comic)}
    let(:unwanted_to_read_item) {Fabricate(:to_read_item, comic: a_decent_comic, user: barbara_gordon)}

    context 'user is logged in' do
      before(:each) do
        set_current_user(barbara_gordon)
      end

      it 'redirects to the reading list' do
        delete :destroy, id: unwanted_to_read_item.id
        expect(response).to redirect_to reading_list_path
      end

      it 'removes the item' do
        delete :destroy, id: unwanted_to_read_item.id
        expect(barbara_gordon.to_read_items.count).to eq(0)
      end

      it 'does not remove the item if it does not belong to the user' do
        another_user = Fabricate(:user)
        another_to_read_item = Fabricate(:to_read_item, comic: a_decent_comic, user_id: another_user.id)
        delete :destroy, id: another_to_read_item.id
        expect(another_user.to_read_items).to eq([another_to_read_item])
      end

      it 'normalizes the list positions of the remaining reading items' do
        remaining_item = Fabricate(:to_read_item, user: barbara_gordon, comic: Fabricate(:comic))
        delete :destroy, id: unwanted_to_read_item.id
        expect(remaining_item.reload.list_position).to eq(1)
      end
    end

    it_behaves_like 'login_is_required' do
      let(:action) {post :create, comic_id: 1}
    end
  end

  describe 'POST update_list' do
    let(:reading_item_1) {Fabricate(:to_read_item, list_position: 1, user: barbara_gordon)}
    let(:reading_item_2) {Fabricate(:to_read_item, list_position: 2, user: barbara_gordon)}

    context 'user is logged in' do
      before(:each) do
        set_current_user(barbara_gordon)
      end

      context 'valid input' do
        it 'redirects to the reading list' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 2}, {id: reading_item_2.id, list_position: 1}]
          expect(response).to redirect_to reading_list_path
        end

        it 'updates the list positions of all reading items' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 2}, {id: reading_item_2.id, list_position: 1}]
          expect(reading_item_1.reload.list_position).to eq(2)
        end

        it 'normalizes the positions of the reading list items' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 11}, {id: reading_item_2.id, list_position: 3}]
          expect(reading_item_1.reload.list_position).to eq(2)
          expect(reading_item_2.reload.list_position).to eq(1)
        end
      end

      context 'invalid input' do
        it 'redirects back to the reading list' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 2}, {id: reading_item_2.id, list_position: 42.11}]
          expect(response).to redirect_to reading_list_path
        end

        it 'shows an error message' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 2}, {id: reading_item_2.id, list_position: 42.11}]
          expect(flash[:danger]).to be_present
        end

        it 'does not update the reading list items' do
          post :update_list, to_read_items: [{id: reading_item_1.id, list_position: 2}, {id: reading_item_2.id, list_position: 42.11}]
          expect(reading_item_1.reload.list_position).to eq(1)
        end

        it "does not update the read list items if they dont't belong to that user" do
          another_user = Fabricate(:user)
          other_reading_item = Fabricate(:to_read_item, list_position: 1, user: another_user)
          post :update_list, to_read_items: [{id: other_reading_item.id, list_position: 2}]
          expect(other_reading_item.reload.list_position).to eq(1)
        end
      end
    end
  end
end
