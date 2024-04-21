# frozen_string_literal: true

shared_context "with authorization header" do
  include_context "with api headers"

  let(:current_user) { create(:user, :john_smith) }
  let(:access_token) { AccessTokenService.new(user: current_user).access_token }
  let(:authorization) { "Bearer #{access_token}" }

  before do
    header "Authorization", :authorization
  end
end
