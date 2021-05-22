require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET #index" do
    subject { get(posts_path) }
    context "投稿が存在するとき" do
        let(:user) { create(:user) }
        let(:post) { create(:post, user_id: user.id) }
      before do
        create(:like, user_id: user.id, post_id: post.id)
        sign_in user
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
    context 'ログインしている場合' do
      let(:user) { create(:user) }
      before do
        sign_in user
      end
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it "リダイレクトが成功する" do
        subject
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST #create" do
    subject { post(posts_path, params: params) }
    let(:user) { create(:user) }
    before do
        sign_in user
    end

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

      it "ユーザ投稿画面ページへレンダリングされる" do
        subject
        expect(response.body).to include "ユーザ投稿画面"
      end
    end
  end
end