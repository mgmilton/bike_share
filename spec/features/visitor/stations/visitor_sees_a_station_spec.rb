require 'rails_helper'

context 'As a visitor' do
  describe 'when I visit the station show' do
    scenario "I see the url '/:station-name' with that station's name instead of :id" do
      station = create(:station)

      visit station_path(station)

      expect(current_url).to eq('/stations/Station-1')
    end
    scenario 'I see all attributes for that station.' do

    end
  end
end
