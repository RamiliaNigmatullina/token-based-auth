# frozen_string_literal: true

RSpec.describe AccessTokenService do
  subject(:access_token_service) { described_class.new(user:) }

  include_context "when time is frozen"

  let(:user) { create(:user) }

  describe "#access_token" do
    subject(:access_token) { access_token_service.access_token }

    let(:expected_payload) do
      {
        sub: user.id,
        exp: 1_713_614_700,
        iat: 1_713_614_400,
        iss: "token-based-auth",
        aud: "token-based-auth"
      }
    end
    let(:stubbed_jwt_token) { "stubbed.jwt.token" }

    before do
      allow(JwtService).to receive(:encode).with(payload: expected_payload).and_return(stubbed_jwt_token)
    end

    it { is_expected.to eq(stubbed_jwt_token) }
  end
end
