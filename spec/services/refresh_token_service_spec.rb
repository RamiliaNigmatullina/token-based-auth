# frozen_string_literal: true

RSpec.describe RefreshTokenService do
  subject(:refresh_token_service) { described_class.new(user:) }

  include_context "when time is frozen"

  let(:user) { create(:user) }

  before do
    allow(SecureRandom).to receive(:uuid).and_return("secure_random_string")
  end

  describe "#refresh_token_cookie" do
    subject(:refresh_token_cookie) { refresh_token_service.refresh_token_cookie }

    let(:expected_cookie_options) do
      {
        value: "secure_random_string",
        httponly: true,
        secure: Rails.env.production?,
        samesite: :strict,
        expires: 3.months.since
      }
    end

    it { is_expected.to eq(expected_cookie_options) }

    context "when the refresh token cannot be created" do
      before do
        allow(RefreshToken).to receive(:create!).and_raise(ActiveRecord::RecordInvalid)
        allow(Rails.logger).to receive(:error).with(/Refresh token cannot be created: /)
      end

      it "raises RefreshTokenCreationError" do
        expect { refresh_token_cookie }.to raise_error(RefreshTokenCreationError)
      end
    end
  end
end
