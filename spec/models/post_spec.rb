require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    subject { post.valid? }
    context "データが条件を満たすとき" do
      let(:post) { build(:post) }
      it "保存できる" do 
        expect(subject).to eq true
      end
    end
    context "content が空のとき" do
      let(:post) { build(:post, content: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:content]).to include "を入力してください"
      end
    end
    context "content  が141文字以上のとき" do
      let(:post) { build(:post, content: "a" * 141) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(post.errors.messages[:content]).to include "は140文字以内で入力してください"
      end
    end
  end

  context "投稿が削除されたとき" do
    subject { post.destroy }

    let(:post) { create(:post) }
    before do
      create_list(:like, 2, post: post)
      create(:like)
    end
    it "その投稿のいいねも削除される" do
      expect { subject }.to change { post.likes.count }.by(-2)
    end
  end
end