require 'rails_helper'

context 'As an admin' do
  describe 'When I visit the stations index, in addition to everything a visitor can see' do
    before(:each) do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      create_list(:station, 3)
    end
    scenario 'I see a button next to each station to edit that station' do
      visit stations_path

      expect(page).to have_link('Edit')
    end

    scenario 'I also see a button next to each station to delete that station' do
      visit stations_path

      expect(page).to have_link('Delete')
    end
  end
end
