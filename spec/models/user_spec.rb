require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "#encrypted_first_name" do
    it "does not equal #first_name" do
      expect(user.encrypted_first_name).not_to eq(user.first_name)
    end
  end

  describe "#encrypted_last_name" do
    it "does not equal #last_name" do
      expect(user.encrypted_last_name).not_to eq(user.last_name)
    end
  end

  describe "#username" do
    it "is first name and last intial" do
      expect(user.username).to eq("#{user.first_name} #{user.last_name[0]}.")
    end
  end
end
