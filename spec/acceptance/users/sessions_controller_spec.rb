# frozen_string_literal: true

resource "Users/Sessions" do
  let!(:user) { create(:user, :john_smith) }

  include_context "with api headers"
  include_context "when time is frozen"

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
    let(:refresh_token_cookie_regexp) do
      %r{_token_based_auth_refresh_token=[^;]+; path=/; expires=Sat, 20 Jul 2024 12:00:00 GMT; httponly; SameSite=Lax}
    end

    example "Sign in" do
      do_request

      expect(status).to eq(201)
      expect(json_response_body).to eq(expected_data)
      expect(response_headers["Authorization"]).to start_with("Bearer ")
      expect(response_headers["Set-Cookie"]).to match(refresh_token_cookie_regexp)
    end

    context "with invalid credentials" do
      let(:expected_error) do
        {
          error: {
            message: "Invalid credentials"
          }
        }.deep_stringify_keys
      end

      context "when password is invalid" do
        let(:password) { "wrong_password" }

        example "Sign in with invalid password" do
          do_request

          expect(status).to eq(401)
          expect(json_response_body).to eq(expected_error)
        end
      end

      context "when email is invalid" do
        let(:email) { "wrong.email@example.com" }

        example "Sign in with invalid email" do
          do_request

          expect(status).to eq(401)
          expect(json_response_body).to eq(expected_error)
        end
      end
    end
  end

  delete "/users/sessions" do
    include_context "with authorization header"

    let(:current_user) { user }

    example "Sign out" do
      do_request

      expect(status).to eq(204)
    end
  end
end
