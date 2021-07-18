require 'rails_helper'

RSpec.describe Information, type: :model do
  describe "バリデーション" do
    subject { information.valid? }
    context "データが条件を満たすとき" do
      let(:information) { build(:information) }
      it "保存できる" do
        expect(subject).to eq true
      end
    end
    context "title が空のとき" do
      let(:information) { build(:information, title: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(information.errors.messages[:title]).to include "を入力してください"
      end
    end
    context "content が空のとき" do
      let(:information) { build(:information, content: "") }
      it "エラーが発生する" do
        expect(subject).to eq false
        expect(information.errors.messages[:content]).to include "を入力してください"
      end
    end
  end
end
