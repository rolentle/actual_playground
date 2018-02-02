require 'rails_helper'

RSpec.describe Performer, type: :model do
  it '#shows' do
    show = create(:show)
    performer = create(:performer, shows: [show])
    expect(performer.shows).to include(show)
  end

  it '#performer_groups' do
    performer_group = create(:performer_group)
    performer = create(:performer, performer_groups: [performer_group])
    expect(performer.performer_groups).to include(performer_group)
  end
end
