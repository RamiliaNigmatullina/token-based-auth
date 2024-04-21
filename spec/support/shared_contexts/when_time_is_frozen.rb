# frozen_string_literal: true

shared_context "when time is frozen" do
  before do
    travel_to Time.zone.local(2024, 4, 20, 12, 0, 0)
  end
end
