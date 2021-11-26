require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe  "Logind" do
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    describe "GET #new" do
      subject { get(new_post_comments_path(post_id)) }
      let(:post) { create(:post) }
      let(:post_id) { post.id }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end
    end

    describe "POST #create" do
      subject { post(post_comments_path(post_id), params: params) }
      let(:post_val) { create(:post) }
      let(:post_id) { post_val.id }

      context "パラメータが正常なとき" do
        let(:params) { { comment: attributes_for(:comment) } }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "コメントが保存される" do
          expect { subject }.to change { Comment.count }.by(1)
        end

        it "投稿詳細ページにリダイレクトされる" do
          subject
          expect(response).to redirect_to post_path(post_id)
        end
      end

      context "パラメータが異常なとき" do
        let(:params) { { comment: attributes_for(:comment, :comment_invalid) } }

        it "レンダリングが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "コメントが保存されない" do
          expect { subject }.not_to change(Comment, :count)
        end

        it "ユーザ投稿画面ページがレンダリングされる" do
          subject
          expect(response.body).to include "コメントする"
        end
      end
    end

    describe "GET #edit" do
      before do
        create(:comment, user_id: user.id, post_id: post.id)
      end
      subject { get(edit_post_comment_path(id: comment_post_id, post_id: comment_id)) }
      let(:post) { create(:post) }
      let(:comment_post_id) { post.comments[0].post_id }

      context "コメントが存在するとき" do
        let(:comment_id) { post.comments[0].id }
        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "content が表示されている" do
          subject
          expect(response.body).to include post.comments[0].content
        end
      end

      context "idに対応するコメントが存在しないとき" do
        let(:comment_id) { 1 }

        it "ステータスコード404が返ってくる" do
          subject
          expect(response).to have_http_status(404)
        end

        it "404.htmlが表示される" do
          subject
          expect(response.body).to include 'お探しのページは見つかりませんでした(404)'
        end
      end
    end

    describe 'PATCH #update' do
      before do
        create(:comment, user_id: user.id, post_id: post.id)
      end
      subject { patch(post_comment_path(id: comment_id, post_id: comment_post_id, params: params)) }
      let(:post) { create(:post) }
      let(:comment_post_id) { post.comments[0].post_id }
      let(:comment_id) { post.comments[0].id }
      let(:comment) { create(:comment, user_id: user.id, post_id: post.id) }

      context 'パラメータが正常な場合' do
        let(:params) { { comment: attributes_for(:comment) } }

        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(302)
        end

        it 'content が更新される' do
          origin_content = post.comments[0].content
          new_content = params[:comment][:content]
          expect { subject }.to change { post.comments[0].reload.content }.from(origin_content).to(new_content)
        end

        it "投稿詳細ページにリダイレクトされる" do
          subject
          expect(response).to redirect_to post_path(comment_post_id)
        end
      end

      context 'パラメータが異常なとき' do
        let(:params) { { comment: attributes_for(:comment, :comment_invalid) } }

        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(200)
        end

        it 'content が更新されない' do
          expect { subject }.not_to change(post.comments[0].reload, :content)
        end

        it '編集ページがレンダリングされる' do
          subject
          expect(response.body).to include 'コメント編集'
        end
      end
    end

    describe 'DELETE #destroy' do
      before do
        create(:comment, user_id: user.id, post_id: post.id)
      end
      subject { delete(post_comment_path(id: comment_post_id, post_id: comment_id)) }
      let(:post) { create(:post) }
      let!(:comment_post_id) { post.comments[0].post_id }
      let!(:comment_id) { post.comments[0].id }

      context 'パラメータが正常な場合' do
        it 'リクエストが成功する' do
          subject
          expect(response).to have_http_status(302)
        end

        it 'コメントが削除される' do
          expect { subject }.to change(Comment, :count).by(-1)
        end

        it '投稿一覧にリダイレクトすること' do
          subject
          expect(response).to redirect_to(post_path(comment_post_id))
        end
      end
    end
  end
  describe  "Not Logged in" do
    describe "GET #new" do
      subject { get(new_post_comments_path(post_id)) }
      let(:post) { create(:post) }
      let(:post_id) { post.id }

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