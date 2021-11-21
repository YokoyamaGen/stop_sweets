require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe  "Logind" do
    before do
      sign_in user
    end

    describe "GET #index" do
      let(:user) { create(:user) }
      subject { get(users_path) }
      context "ユーザーが存在するとき" do
        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "name が表示されている" do
          subject
          expect(response.body).to include user.name      
        end

        it "stop_eat_sweets_day_month が表示されている" do
          subject
          expect(response.body).to include user.calc_stop_day_month.to_s
        end
      end
    end

    describe "GET #show" do
      let(:user) { create(:user) }
      subject { get(user_path(user_id)) }
      context "ユーザーが存在するとき" do
        let(:user_id) { user.id }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(200)
        end

        it "name が表示されている" do
          subject
          expect(response.body).to include user.name
        end

        it "email が表示されている" do
          subject
          expect(response.body).to include user.email
        end

        it "created_at が表示されている" do
          subject
          expect(response.body).to include user.created_at.strftime("%Y/%m/%d")
        end

        it "stop_eat_sweets_day が表示されている" do
          subject
          expect(response.body).to include user.calc_stop_day.to_s
        end

        it "save_money が表示されている" do
          subject
          expect(response.body).to include user.calc_save_money(user.calc_stop_day).to_s
        end

        it "stop_eat_sweets_day_month が表示されている" do
          subject
          expect(response.body).to include user.calc_stop_day_month.to_s
        end

        it "save_money_month が表示されている" do
          subject
          expect(response.body).to include user.calc_save_money(user.calc_stop_day_month).to_s
        end
      end

      context ":idに対応するユーザーが存在しないとき" do
        let(:user_id) { 1 }

        it "404.htmlが表示される" do
          subject
          expect(response.body).to include 'お探しのページは見つかりませんでした(404)'
        end
      end
    end

    describe "PATCH #update_eat_day" do
      let(:user_id) { user.id }
      subject { patch(update_eat_day_user_path(user_id)) }
      context "お菓子を食べてしまった日を更新できるとき" do
        let(:user) { create(:user, eat_day_updated_on: Date.today - 1, created_at: Date.today - 2 ) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "eat_dayに1日加算される" do
          expect { subject }.to change { user.reload.eat_day }.by(1)
        end

        it "eat_day_updated_onが今日に更新される" do
          origin_updated_on = user.eat_day_updated_on
          new_updated_on = Date.today
          expect { subject }.to change { user.reload.eat_day_updated_on }.from(origin_updated_on).to(new_updated_on)
        end

        it "マイページページにリダイレクトされる" do
          subject
          expect(response).to redirect_to user_path(user_id)
        end
      end

      context "お菓子を食べてしまった日を更新でないとき" do
        let(:user) { create(:user, eat_day_updated_on: Date.today, created_at: Date.today) }

        it "リクエストが成功する" do
          subject
          expect(response).to have_http_status(302)
        end

        it "eat_dayが更新されない" do
          expect { subject }.not_to change { user.reload.eat_day }
        end

        it "マイページページにリダイレクトされる" do
          subject
          expect(response).to redirect_to user_path(user_id)
        end
      end
    end
  end

  describe  "Not Logged in" do
    describe "GET #new" do
      let(:user) { create(:user) }
      let(:user_id) { user.id }
      subject { get(user_path(user_id)) }

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