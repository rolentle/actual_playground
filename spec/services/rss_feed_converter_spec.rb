require 'rails_helper'

RSpec.describe RssFeedConverter, type: :service do
  describe 'RssFeedConverter' do
    describe '#episodes' do
      let(:response) do
        VCR.use_cassette('protean_city') do
          RssFeedConverter.execute('https://pinecast.com/feed/protean-city-comics')
        end
      end
      it 'returns the number of services' do
          expect(response.episodes.length).to eq(26)
      end

      describe RssFeedEpisode do
        let(:episode) { response.episodes.first }
        describe '.class' do
          it 'is RssFeedEpisode' do
            expect(episode.class).to be(RssFeedEpisode)
          end
        end

        describe '#title' do
          it 'returns a title' do
            expected_title = 'Volume 6 Issue 3 - Click...BOOM'
            expect(episode.title).to eq(expected_title)
          end
        end

        describe '#published_at' do
          it 'returns a date time' do
            expected_published_date = Time.parse('2018-01-31 08:00:53 UTC')
            expect(episode.published_at).to eq(expected_published_date)
          end
        end

        describe '#description' do
          it 'has a description' do
            expect(episode.description).to be_present
          end
        end

        describe '#duration_time' do
          it 'has a length' do
            expect(episode.duration_time).to eq("00:53:32")
          end
        end
      end
    end
  end
end
