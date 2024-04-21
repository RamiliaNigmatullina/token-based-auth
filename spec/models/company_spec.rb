# frozen_string_literal: true

RSpec.describe Company do
  let(:company) { build(:company, name: "Example Company", subdomain:) }
  let(:subdomain) { "custom-subdomain" }

  describe "before_validation" do
    subject(:validate_company) { company.valid? }

    it "does not overwrite the existing subdomain" do
      company.valid?

      expect(company.subdomain).to eq("custom-subdomain")
    end

    context "when subdomain is not provided" do
      let(:subdomain) { "" }

      it "sets the subdomain from the name" do
        company.valid?

        expect(company.subdomain).to eq("example-company")
      end

      context "when subdomain is nil" do
        let(:subdomain) { nil }

        it "sets the subdomain from the name" do
          company.valid?

          expect(company.subdomain).to eq("example-company")
        end
      end
    end
  end
end
