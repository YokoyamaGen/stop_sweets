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

  describe "インスタンスメソッド" do
    context "calc_use_day のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.current - 1) }
      it "ユーザのサービス利用日数が想定通りになる" do
          expect(user.calc_use_day).to eq 1
      end
    end
    context "calc_save_money(use_days) のデータが条件を満たすとき" do
      let(:user) { build(:user, cost: 500) }
      it "お菓子を辞めたことによる節約金額が想定通りになる" do
          expect(user.calc_save_money(2)).to eq 1000
      end
    end
    context "calc_stop_day のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.current - 2, eat_day:1) }
      it "お菓子を辞めた合計日数から食べてしまった日数を差し引いた日数が想定通りになる" do
          expect(user.calc_stop_day).to eq 1
      end
    end
  end

  describe "クラスメソッド" do
    context "クラスメソッドguestを呼び出したとき" do
      it "User.guest.name がゲストユーザになること" do
        expect(User.guest.name).to eq "ゲストユーザ"
      end
      it "User.guest.email がguest@example.comになること" do
        expect(User.guest.email).to eq "guest@example.com"
      end
    end
  end

  describe "アソシエーション" do
    subject { user.destroy }
    let(:user) { create(:user) }
    context "ユーザーが削除されたとき" do
      it "削除されたユーザーのメッセージも削除される" do
        create_list(:post, 2, user: user)
        create(:post)
        expect { subject }.to change { user.posts.count }.by(-2)
      end
      it "削除されたユーザーのいいねも削除される" do
        create_list(:like, 2, user: user)
        create(:like)
        expect { subject }.to change { user.likes.count }.by(-2)
      end
    end
  end
end