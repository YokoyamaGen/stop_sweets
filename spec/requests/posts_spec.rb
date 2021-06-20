require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe  "Logind" do
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    describe "GET #index" do
      subject { get(posts_path) }

      context "投稿が存在するとき" do
        let(:post) { create(:post, user_id: user.id) }
        before do
          create(:like, user_id: user.id, post_id: post.id)
        end

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "user.name が表示されている" do
          subject
          expect(response.body).to include post.user.name
        end

        it "content が表示されている" do
          subject
          expect(response.body).to include post.content
        end
      end
    end

    describe "GET #new" do
      subject { get(new_post_path) }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end
    end

    describe "POST #create" do
      subject { post(posts_path, params: params) }

      context "パラメータが正常なとき" do
        let(:params) { { post: attributes_for(:post) } }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "投稿が保存される" do
          expect { subject }.to change { Post.count }.by(1)
        end

        it "投稿一覧ページにリダイレクトされる" do
          subject
          expect(response).to redirect_to posts_path
        end
      end

      context "パラメータが異常なとき" do
        let(:params) { { post: attributes_for(:post, :invalid) } }

        it "レンダリングが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "ユーザーが保存されない" do
          expect { subject }.not_to change(Post, :count)
        end

        it "ユーザ投稿画面ページがレンダリングされる" do
          subject
          expect(response.body).to include "つぶやき"
        end
      end
    end

    describe "GET #show" do
      subject { get(post_path(post_id)) }

      context "投稿が存在するとき" do
        let(:post) { create(:post) }
        let(:post_id) { post.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "user.name が表示されている" do
          subject
          expect(response.body).to include post.user.name
        end

        it "content が表示されている" do
          subject
          expect(response.body).to include post.content
        end
      end
    end

    describe "GET #edit" do
      subject { get(edit_post_path(post_id)) }

      context "投稿が存在するとき" do
        let(:post) { create(:post, user_id: user.id) }
        let(:post_id) { post.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "content が表示されている" do
          subject
          expect(response.body).to include post.content
        end
      end

      context "idに対応する投稿が存在しないとき" do
        let(:post_id) { 1 }

        it "エラーが発生する" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end

    describe 'PATCH #update' do
      subject { patch(post_path(post.id), params: params) }
      let(:post) { create(:post, user_id: user.id) }

      context 'パラメータが正常な場合' do
        let(:params) { { post: attributes_for(:post) } }

        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(302)
        end

        it 'content が更新される' do
          origin_content = post.content
          new_content = params[:post][:content]
          expect { subject }.to change { post.reload.content }.from(origin_content).to(new_content)
        end

        it "投稿一覧ページにリダイレクトされる" do
          subject
          expect(response).to redirect_to posts_path
        end
      end

      context 'パラメータが異常なとき' do
        let(:params) { { post: attributes_for(:post, :invalid) } }

        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(200)
        end

        it 'content が更新されない' do
          expect { subject }.not_to change(post.reload, :content)
        end

        it '編集ページがレンダリングされる' do
          subject
          expect(response.body).to include '編集'
        end
      end
    end

    describe 'DELETE #destroy' do
      subject { delete(post_path(post.id)) }
      let!(:post) { create(:post, user_id: user.id) }

      context 'パラメータが正常な場合' do
        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(302)
        end

        it '投稿が削除される' do
          expect { subject }.to change(Post, :count).by(-1)
        end

        it '投稿一覧にリダイレクトすること' do
          subject
          expect(response).to redirect_to(posts_path)
        end
      end
    end
  end
  describe  "Not Logged in" do
    describe "GET #new" do
      subject { get(new_post_path) }

      it "リダイレクトが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "ログインページにリダイレクトされる" do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end