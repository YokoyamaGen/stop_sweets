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
    context "name が50文字のとき" do
      let(:user) { build(:user, name: "a" * 50) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
    context "name が51文字以上のとき" do
      let(:user) { build(:user, name: "a" * 51) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include "は50文字以内で入力してください"
      end
    end
    context "name(両方が小文字) が重複するとき" do
      let(:user) { build(:user, name: "hogehoge") }
      it "エラーが発生する" do
        create(:user, name: "hogehoge")
        expect(subject).to eq false
        expect(user.errors.messages[:name]).to include "はすでに存在します"
      end
    end
    context "name(片方が大文字、片方が小文字) が重複するとき" do
      let(:user) { build(:user, name: "HOGEHOGE") }
      it "保存できる" do
        create(:user, name: "hogehoge")
        expect(subject).to eq true
      end
    end
    context "email が空のとき" do
      let(:user) { build(:user, email: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "を入力してください"
      end
    end
    context "email が255文字のとき" do
      let(:user) { build(:user, email: "a" * 243 + "@example.com") }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
    context "email が256文字以上のとき" do
      let(:user) { build(:user, email: "a" * 244 + "@example.com") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "は255文字以内で入力してください"
      end
    end
    context "email(両方が小文字) が重複するとき" do
      let(:user) { build(:user, email: "aaron@example.com") }
      it "エラーが発生する" do
        create(:user, email: "aaron@example.com")
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "はすでに存在します"
      end
    end
    context "email(片方が大文字、片方が小文字) が重複するとき" do
      let(:user) { build(:user, email: "AARON@EXAMPLE.COM") }
      it "エラーが発生する" do
        create(:user, email: "aaron@example.com")
        expect(subject).to eq false
        expect(user.errors.messages[:email]).to include "はすでに存在します"
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
    context "profile が160文字のとき" do
      let(:user) { build(:user, profile: "a" * 160) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
    context "profile が161文字以上のとき" do
      let(:user) { build(:user, profile: "a" * 161) }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(user.errors.messages[:profile]).to include "は160文字以内で入力してください"
      end
    end
  end

  describe "インスタンスメソッド" do
    context "save_money のデータが条件を満たすとき" do
      let(:user) { build(:user, cost: 500, created_at: Date.current - 2) }
      it "お菓子を辞めたことによる節約金額が想定通りになる" do
          expect(user.save_money).to eq 1500
      end
    end

    context "calc_stop_day のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.current - 2, eat_day:1) }
      it "お菓子を辞めた合計日数から食べてしまった日数を差し引いた日数が想定通りになる" do
          expect(user.calc_stop_day).to eq 2
      end
    end
    context "ユーザ登録した日が前月末の場合で、calc_stop_day_month のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.today.beginning_of_month - 1, eat_day_month:1) }
      it "お菓子を辞めた合計日数から食べてしまった日数を差し引いた日数が想定通りになる" do
          expect(user.calc_stop_day_month).to eq (Date.today - Date.today.beginning_of_month).to_i
      end
    end
    context "ユーザ登録した日が月初1日の場合で、calc_stop_day_month のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.today.beginning_of_month, eat_day_month:1) }
      it "お菓子を辞めた合計日数から食べてしまった日数を差し引いた日数が想定通りになる" do
          expect(user.calc_stop_day_month).to eq (Date.today - Date.today.beginning_of_month).to_i
      end
    end
    context "ユーザ登録した日が月初2日の場合で、calc_stop_day_month のデータが条件を満たすとき" do
      let(:user) { build(:user, created_at: Date.today.beginning_of_month + 1, eat_day_month:1) }
      it "お菓子を辞めた合計日数から食べてしまった日数を差し引いた日数が想定通りになる" do
          expect(user.calc_stop_day_month).to eq (Date.today - user.created_at.to_date).to_i
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