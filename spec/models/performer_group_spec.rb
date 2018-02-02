require 'rails_helper'

RSpec.describe PerformerGroup, type: :model do
  it '#name' do
    expected_name = 'foo'
    performer_group = create(:performer_group, name: expected_name)
    expect(performer_group.name).to eq(expected_name)
  end

  it '#performers' do
    expected_number_of_performers = 3
    performer_group = create(:performer_group_with_performers, performer_count: expected_number_of_performers)
    actual_number_of_performers = performer_group.performers.length
    expect(actual_number_of_performers).to eq(expected_number_of_performers)
  end

  it '#shows' do
    show = create(:show)
    performer_group = create(:performer_group, shows: [show])
    expect(performer_group.shows).to include(show)
  end
end
