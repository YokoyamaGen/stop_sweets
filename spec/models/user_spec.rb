require 'rails_helper'

RSpec.describe User, type: :model do
    describe "バリデーション" do
      subject { user.valid? }
      context "データが条件を満たすとき" do
        let(:user) { build(:user) }
        it "保存できる" do
          expect(subject).to eq true
        end
      end
      context "name が空のとき" do
        let(:user) { build(:user, name: "") }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:name]).to include "を入力してください"
        end
      end
      context "name が51文字以上のとき" do
        let(:user) { build(:user, name: "a" * 51) }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:name]).to include "は50文字以内で入力してください"
        end
      end
      context "email が空のとき" do
        let(:user) { build(:user, email: "") }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:email]).to include "を入力してください"
        end
      end
      context "email が256文字以上のとき" do
        let(:user) { build(:user, email: "a" * 256) }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:email]).to include "は255文字以内で入力してください"
        end
      end
      context "cost が負の整数のとき" do
        let(:user) { build(:user, cost: -1) }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:cost]).to include "は0以上の値にしてください"
        end
      end
      context "cost が文字列のとき" do
        let(:user) { build(:user, cost: "a") }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:cost]).to include "は数値で入力してください"
        end
      end
      context "cost が小数点のとき" do
        let(:user) { build(:user, cost: 2.0) }
        it "エラーが発生する" do
          expect(subject).to eq false
          expect(user.errors.messages[:cost]).to include "は整数で入力してください"
        end
      end
    end

  subject { user.destroy }
  let(:user) { create(:user) }
  context "ユーザーが削除されたとき" do
    before do
      create_list(:post, 2, user: user)
      create(:post)
    end
    it "そのユーザーのメッセージも削除される" do
      expect { subject }.to change { user.posts.count }.by(-2)
    end
  end

  context "ユーザーが削除されたとき" do
    before do
      create_list(:like, 2, user: user)
      create(:like)
    end

    it "そのユーザーのいいねも削除される" do
      expect { subject }.to change { user.likes.count }.by(-2)
    end
  end
end