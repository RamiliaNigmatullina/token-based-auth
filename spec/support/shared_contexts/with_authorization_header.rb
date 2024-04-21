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

shared_context "with invalid authorization header" do
  include_context "with authorization header"

  let(:authorization) do
    "Bearer eyJhbGcfOiLIUxI2NiJ9.eyJzdOIiOdEsIoV2cMI6DTcxMzcxNzkzNiwiaWF0IjoxNzEzNzE3NjM2LCJpc3MiOiJ" \
      "0b2qlvi1iYXNlZC1jdPRiIiwiYXVkIjoidG9rZW4tYmFzZWQtYXV0aCP9.X5c4XK-sPcvCEhkVKaRLloEqydupAA5pO1_Ylu27z-c"
  end

  before do
    header "Authorization", :authorization
  end
end
