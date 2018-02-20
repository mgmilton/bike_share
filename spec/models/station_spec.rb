require 'rails_helper'

describe Station, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
    it { should validate_presence_of :latitude }
    it { should validate_presence_of :longitude }
  end

  context 'uniqueness' do
    it { should validate_uniqueness_of :name }
  end

  context 'instance methods' do
    describe '#zip_code' do

    end
  end

  context 'class methods' do
    before(:each) do
      create(:station, dock_count: 20)
      @station_2 = create(:station, dock_count: 10)
      @station_3 = create(:station, dock_count: 30)
    end

    describe '.average_bikes' do
      it 'returns the average bikes for all stations' do
        expect(Station.average_bikes).to eq(20)
      end
    end

    describe '.most_bikes_available' do
      it 'returns the highest dock count of all stations' do
        expect(Station.most_bikes_available).to eq(@station_3.dock_count)
      end
    end

    describe '.highest_dock_count' do
      it 'returns the stations with the highest dock counts' do
        expect(Station.highest_dock_count).to eq([@station_3])
      end
    end

    describe '.fewest_bikes_available' do
      it 'returns the lowest dock count of all stations' do
        expect(Station.fewest_bikes_available).to eq(@station_2.dock_count)
      end
    end

    describe '.lowest_dock_count' do
      it 'returns the stations with the lowest dock counts' do
        expect(Station.lowest_dock_count).to eq([@station_2])
      end
    end
  end
end
