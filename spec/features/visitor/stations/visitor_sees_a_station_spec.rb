require 'rails_helper'

context 'As a visitor' do
  describe 'when I visit the station show' do
    before(:each) { @station = create(:station) }
    scenario "I see the url '/:station-name' with that station's name instead of :id" do
      visit station_path(@station)

      expect(current_path).to eq('/stations/Station-1')
    end
    scenario 'I see all attributes for that station.' do
      visit station_path(@station)

      expect(page).to have_content(@station.name)
      expect(page).to have_content(@station.dock_count)
      expect(page).to have_content(@station.city)
      expect(page).to have_content(@station.format_date)
      expect(page).to have_content(@station.latitude)
      expect(page).to have_content(@station.longitude)
    end
  end
end
