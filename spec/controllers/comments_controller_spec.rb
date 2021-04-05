require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:article) { create(:article) }
  let!(:comment_1) { create(:comment, article_id: article.id) }
  let!(:comment_2) { create(:comment, article_id: article.id) }

  describe 'POST #create' do
    let!(:params) do
      {
        article_id: article,
        comment: {
          commenter: 'Hoang Nguyen',
          body: body
        }
      }
    end

    context 'success' do
      let!(:body) { 'Body ne' }

      specify do
        expect do
          post :create, params: params
        end.to change(Comment, :count).by(1)
        comment = Comment.last
        expect(comment).to have_attributes(commenter: 'Hoang Nguyen', body: 'Body ne')
        expect(response).to redirect_to article_path(article)
        expect(flash[:success]).to eq nil
      end
    end

    context 'failure' do
      let!(:body) { '' }

        specify do
          expect do
            post :create, params: params
          end.to_not change { Comment.count }
          expect(response).to redirect_to article_path(article)
          expect(flash[:error]).to eq nil
        end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      specify do
        expect do
          delete :destroy, params: { article_id: article, id: comment_1 }
        end.to change(Comment, :count).by(-1)
        expect(response).to redirect_to article_path(article)
        expect(flash[:success]).to eq nil
      end
    end

    context 'failure' do
      before { allow_any_instance_of(Comment).to receive(:destroy).and_return(false) }

      specify do
        expect do
          delete :destroy, params: { article_id: article, id: comment_2 }
        end.to_not change { Comment.count }
        expect(response).to redirect_to article_path(article)
        expect(flash[:error]).to eq nil
      end
    end
  end
end