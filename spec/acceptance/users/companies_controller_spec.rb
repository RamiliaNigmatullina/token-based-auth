# frozen_string_literal: true

resource "Users/Companies" do
  include_context "with authorization header"

  let!(:company1) { create(:company, name: "Harvey-Schulist", subdomain: "harvey-schulist") }
  let!(:company2) { create(:company, name: "Nicolas and O'Hara", subdomain: "nicolas-and-ohara") }
  let(:expected_data) do
    {
      data: [
        {
          id: company1.id.to_s,
          type: "company",
          attributes: {
            name: "Harvey-Schulist",
            subdomain: "harvey-schulist"
          }
        },
        {
          id: company2.id.to_s,
          type: "company",
          attributes: {
            name: "Nicolas and O'Hara",
            subdomain: "nicolas-and-ohara"
          }
        }
      ]
    }.deep_stringify_keys
  end
  let(:expected_error) do
    {
      error: {
        message: "Unauthorized"
      }
    }.deep_stringify_keys
  end

  get "/users/companies" do
    example "Get companies list" do
      do_request

      expect(status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end

    context "with invalid authorization token" do
      include_context "with invalid authorization header"

      example "Get current user info with invalid token" do
        do_request

        expect(status).to eq(401)
        expect(json_response_body).to eq(expected_error)
      end
    end
  end
end
