module AcceptanceHelper
  def json_response_body
    JSON.parse(response_body)
  end
end
