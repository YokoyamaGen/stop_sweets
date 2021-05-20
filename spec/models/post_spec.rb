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

  describe "アソシエーション" do
    context "投稿が削除されたとき" do
      subject { post.destroy }
      let(:post) { create(:post) }      
      it "削除された投稿のいいねも削除される" do
        create_list(:like, 2, post: post)
        create(:like)
        expect { subject }.to change { post.likes.count }.by(-2)
      end
    end
  end

  describe "インスタンスメソッド" do
    before do
      create(:like, user_id: user.id, post_id: post.id)
    end
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    context "投稿したユーザIDとメソッド引数のユーザIDが一致する" do
      it "メソッドの戻り値がtrueである" do
        expect(post.liked_by?(user)).to eq true
      end
    end
    context "投稿したユーザIDとメソッド引数のユーザIDが不一致である" do
      let(:user2) { create(:user) }
      it "メソッドの戻り値がfalseである" do
        expect(post.liked_by?(user2)).to eq false
      end
    end
  end
end