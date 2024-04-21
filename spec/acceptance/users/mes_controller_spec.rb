# frozen_string_literal: true

resource "Users/Me" do
  include_context "with authorization header"

  let(:expected_data) do
    {
      data: {
        id: current_user.id.to_s,
        type: "user",
        attributes: {
          email: "john.smith@example.com",
          first_name: "John",
          last_name: "Smith"
        }
      }
    }.deep_stringify_keys
  end
  let(:expected_error) do
    {
      error: {
        message: "Unauthorized"
      }
    }.deep_stringify_keys
  end

  get "/users/me" do
    example "Get current user info" do
      do_request

      expect(status).to eq(200)
      expect(json_response_body).to eq(expected_data)
    end

    context "with invalid token" do
      include_context "with invalid authorization header"

      example "Get current user info with invalid token" do
        do_request

        expect(status).to eq(401)
        expect(json_response_body).to eq(expected_error)
      end
    end

    context "with expired token" do
      before do
        allow(Time).to receive(:current).and_return(10.minutes.ago)
      end

      example "Get current user info with expired token" do
        do_request

        expect(status).to eq(401)
        expect(json_response_body).to eq(expected_error)
      end
    end
  end
end
