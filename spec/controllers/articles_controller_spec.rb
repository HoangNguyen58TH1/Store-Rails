require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
	let!(:article_1) { create(:article) }
	let!(:article_2) { create(:article) }

	describe 'GET #index' do
		specify do
			get :index
			expect(response).to be_successful
			expect(assigns(:articles)).to eq ([article_1, article_2])
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		specify do
			get :show, params: { id: article_1 }
			expect(assigns(:article)).to eq (article_1)
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		specify do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'POST #create' do
		let!(:params) do
			{
				article: {
					title: "Title ne",
					body: body
				}
			}
		end
		
		context 'success' do
			let!(:body) { 'Body > 10 ky tu' }

			specify do
				expect do
					post :create, params: params
				end.to change(Article, :count).by(1)
				article = Article.last
				expect(article).to have_attributes(title: 'Title ne', body: 'Body > 10 ky tu')
				expect(response).to redirect_to article_path(article)
				expect(flash[:success]).to eq nil
			end
		end

		context 'failure' do
			let!(:body) { 'Body < 10' }

			specify do
				expect do
					post :create, params: params
				end.to_not change { Article.count }
				expect(response).to render_template :new
				expect(flash[:error]). to eq nil
			end
		end
	end

	describe 'GET #edit' do
		specify do
			get :edit, params: { id: article_1 }
			expect(assigns(:article)). to eq (article_1)
			expect(response).to render_template :edit
		end
	end

	describe 'PUT #update' do
		let!(:params) do
			{
				id: article_1,
				article: {
					title: 'Title ne',
					body: body
				}
			}
		end

		context 'success' do
			let!(:body) { 'Body > 10 ky tu' }

			specify do
				put :update, params: params
				article_1.reload
				expect(article_1).to have_attributes(title: 'Title ne', body: 'Body > 10 ky tu')
				expect(response).to redirect_to article_path(article_1)
				expect(flash[:success]).to eq nil
			end
		end

		context 'failure' do
			let!(:body) { 'Body' }

			specify do
				put :update, params: params
				expect(response).to render_template :edit
				expect(flash[:error]).to eq nil
			end
		end
	end

	describe 'DELETE #destroy' do
		context 'success' do
			specify do
				expect do
					delete :destroy, params: { id: article_1 }
				end.to change(Article, :count).by(-1)
				expect(response).to redirect_to :root
				expect(flash[:success]).to eq nil
			end
		end

		context 'failure' do
			before { allow_any_instance_of(Article).to receive(:destroy).and_return(false) }

			specify do
				expect do
					delete :destroy, params: { id: article_1 }
				end.to_not change { Article.count }
				expect(flash[:error]).to eq nil
			end
		end
	end

end
