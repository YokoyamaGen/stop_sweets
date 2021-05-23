require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe  "Logind" do
    let(:user) { create(:user) }
    before do
      sign_in user
    end
  end
end
