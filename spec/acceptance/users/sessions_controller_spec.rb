# frozen_string_literal: true

resource "Users/Sessions" do
  let!(:user) { create(:user, :john_smith) }

  header "Content-Type", "application/json"

  post "/users/sessions" do
    with_options scope: :user, required: true do
      parameter :email, "User email", required: true
      parameter :password, "User password", required: true
    end

    let(:email) { "john.smith@example.com" }
    let(:password) { "password" }
    let(:expected_data) do
      {
        data: {
          id: user.id.to_s,
          type: "user",
          attributes: {
            email: "john.smith@example.com",
            first_name: "John",
            last_name: "Smith"
          }
        }
      }.deep_stringify_keys
    end

    example "Sign in" do
      do_request

      expect(status).to eq(201)
      expect(json_response_body).to eq(expected_data)
      expect(response_headers["Authorization"]).to start_with("Bearer ")
    end

    context "when password is invalid" do
      let(:password) { "wrong_password" }
      let(:expected_error) do
        {
          error: {
            message: "Invalid credentials"
          }
        }.deep_stringify_keys
      end

      example "Sign in with invalid credentials" do
        do_request

        expect(status).to eq(401)
        expect(json_response_body).to eq(expected_error)
      end
    end
  end

  delete "/users/sessions" do
    example "Sign out" do
      do_request

      expect(status).to eq(204)
    end
  end
end
