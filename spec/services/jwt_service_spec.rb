# frozen_string_literal: true

RSpec.describe JwtService do
  let(:payload) { { "sub" => 1 } }
  let(:token) { described_class.encode(payload:) }

  describe ".encode" do
    subject(:encode) { token }

    it { is_expected.to be_a(String) }
  end

  describe ".decode" do
    subject(:decode) { described_class.decode(token:) }

    it { is_expected.to be_a(ActiveSupport::HashWithIndifferentAccess) }
    it { is_expected.to eq(payload) }

    context "when token is invalid" do
      let(:token) { "invalid_token" }

      it { is_expected.to be_nil }
    end
  end
end
