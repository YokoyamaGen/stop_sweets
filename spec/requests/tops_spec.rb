require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET #index" do
    subject { get(root_path) }

    it "リクエストが成功する" do
      subject
      expect(response).to have_http_status(200)
    end
  end
end
