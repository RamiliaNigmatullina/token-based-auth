RSpec.describe AccessToken, type: :model do
  subject(:access_token) { described_class.new(user) }
  
  let(:user) { create(:user) }
  let(:token_ttl) { Rails.application.credentials.access_token_ttl_sec }

  before do
    travel_to Time.zone.local(2024, 4, 20, 12, 0, 0)
  end
  
  describe "#payload" do
    subject(:payload) { access_token.payload }

    let(:expected_payload) do
      {
        sub: user.id,
        exp: 1713614700,
        iat: 1713614400,
        iss: "token-based-auth",
        aud: "token-based-auth"
      }
    end

    it { is_expected.to eq(expected_payload) }
  end

  after do
    travel_back
  end
end
