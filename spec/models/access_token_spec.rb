# frozen_string_literal: true

RSpec.describe AccessToken do
  subject(:access_token) { described_class.new(user) }

  include_context "when time is frozen"

  let(:user) { create(:user) }
  let(:token_ttl) { Rails.application.credentials.access_token_ttl_sec }

  describe "#payload" do
    subject(:payload) { access_token.payload }

    let(:expected_payload) do
      {
        sub: user.id,
        exp: 1_713_614_700,
        iat: 1_713_614_400,
        iss: "token-based-auth",
        aud: "token-based-auth"
      }
    end

    it { is_expected.to eq(expected_payload) }
  end
end
