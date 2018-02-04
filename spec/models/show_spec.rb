require 'rails_helper'

RSpec.describe Show, type: :model do
  scenario '.by_avg_scores' do
    good_show = create(:show_with_high_ratings, title: 'good')
    bad_show = create(:show_with_low_ratings, title: 'bad')
    show_with_no_ratings = create(:show, title: 'Not Found')
    non_approved_show = create(:show, status: 'pending')

    actual_shows = Show.by_avg_scores

    expect(actual_shows.length).to eq(3)
    expect(actual_shows.first).to eq(good_show)
    expect(actual_shows[1]).to eq(bad_show)
    expect(actual_shows.last).to eq(show_with_no_ratings)
    expect(actual_shows).not_to include(non_approved_show)
  end

  scenario '#avg_rating' do
    ok_show = create(:show_with_ok_ratings)
    expect(ok_show.avg_rating).to eq(3)
  end

  scenario '#avg_rating without ratings' do
    show = create(:show)
    expect(show.avg_rating).to eq(nil)
  end

  context '#pending?' do
    it 'is true when status is pending' do
      show = create(:show, status: :pending)
      expect(show.pending?).to eq(true)
    end

    it 'is fale when status is approved' do
      show = create(:show, status: :approved)
      expect(show.pending?).to eq(false)
    end
  end

  context '#creator_name' do
    context 'creator is a performer' do
      it "is the performer's name" do
        expected_name = 'foo'
        performer = create(:performer, name: expected_name)
        show = create(:show_created_by_a_performer, creator: performer)
        expect(show.creator_name).to eq(expected_name)
      end
    end
    context 'creator is a performer group' do
      it "is the performer group's name" do
        expected_name = 'foo'
        performer_group = create(:performer_group, name: expected_name)
        show = create(:show_created_by_a_performer_group, creator: performer_group)
        expect(show.creator_name).to eq(expected_name)
      end
    end
  end

  context '#stories' do
    context 'it has episodes and campaigns' do
      it 'rerurns them both' do
        episode = create(:episode)
        campaign = create(:campaign)
        show = create(:show)
        episode_story = create(:story, show: show, storyable: episode)
        campaign_story = create(:story, show: show,  storyable: campaign)
        expect(show.stories).to include(episode)
        expect(show.stories).to include(campaign)
      end
    end
  end
end
