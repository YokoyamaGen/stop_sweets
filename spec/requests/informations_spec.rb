require 'rails_helper'

RSpec.describe "Informations", type: :request do
  describe  "Logind" do
    let(:user) { create(:user) }
    before do
      sign_in user
    end

    describe "GET #index" do
      let(:information) { create(:information) }
      subject { get(informations_path) }

      context "ニュースが存在するとき" do
        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end
      end
    end

    describe "GET #show" do
      subject { get(information_path(information_id)) }

      context "ニュースが存在するとき" do
        let(:information) { create(:information) }
        let(:information_id) { information.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "information.content が表示されている" do
          subject
          expect(response.body).to include information.content
        end
      end
    end
  end

  describe  "Not Logged in" do
    describe "GET #index" do
      subject { get(informations_path) }

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
