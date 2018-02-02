require 'rails_helper'

feature 'Performer Group Show Page' do
  let(:performer_group) { create(:performer_group_shows_and_performers) }
  before do
    visit performer_group_path(performer_group)

  end

  scenario 'has performer group name' do
    expect(page).to have_text(performer_group.name)
  end

  scenario 'has performers' do
    performer_group.performers.each do |performer|
      expect(page).to have_text(performer.name)
    end

    first_performer = performer_group.performers.first
    click_on(first_performer.name)

    expect(current_path).to eq(performer_path(first_performer))
  end

  scenario 'has shows' do
    performer_group.shows.each do |show|
      expect(page).to have_text(show.title)
    end

    first_show = performer_group.shows.first
    click_on(first_show.title)
    expect(current_path).to eq(show_path(first_show))
  end
end
