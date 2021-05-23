require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe  "Logind" do
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    describe "GET #edit" do
      subject { get(edit_user_path(user_id), xhr: true) }

      context "ユーザーが存在するとき" do
        let(:user_id) { user.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

      #   it "content が表示されている" do
      #     subject
      #     expect(response.body).to include post.content
      #   end
      end

      # context "idに対応する投稿が存在しないとき" do
      #   let(:post_id) { 1 }

      #   it "エラーが発生する" do
      #     expect { subject }.to raise_error ActiveRecord::RecordNotFound
      #   end
      # end
    end
  end
end
