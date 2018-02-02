require 'rails_helper'

feature 'Performer Show Page' do
  let(:performer) { create(:performer) }
  let(:show) { create(:show, creator: performer) }
  let(:performer_group) { create(:performer_group, performers: [performer]) }

  before do
    show
    performer_group
    visit performer_path(performer)
  end

  scenario 'has name' do
    expect(page).to have_text(performer.name)
  end

  scenario 'has shows' do
    performer.shows.each do |show|
      expect(page).to have_text(show.title)
    end
    click_on(show.title)

    expect(current_path).to eq(show_path(show))
  end

  scenario 'has performer groups' do
    performer.performer_groups.each do |performer_group|
      expect(page).to have_text
    end

    click_on(performer_group.name)
    expect(current_path).to eq(performer_group_path(performer_group))
  end
end
