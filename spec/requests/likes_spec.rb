require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  describe "POST #create" do
    let(:new_post) { create(:post, user_id: user.id) }
    let(:post_id) { new_post.id }
    subject { post(post_likes_path(post_id), xhr: true) }

    it "リクエストが成功する" do
      subject
      expect(response).to have_http_status(200)
    end

    it "いいねが保存される" do
      expect { subject }.to change { Post.count }.by(1)
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post, user_id: user.id) }
    before do
      create(:like, user_id: user.id, post_id: post.id)
    end
    subject { delete(post_likes_path(post.id), xhr: true) }

    it 'リクエストが成功する' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'いいねが削除される' do
      expect { subject }.to change(Like, :count).by(-1)
    end
  end
end

