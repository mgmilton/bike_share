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

  before(:each) do
    @station_1 = create(:station, dock_count: 20, installation_date: Time.strptime('2/8/18', '%m/%d/%y'))
    @station_2 = create(:station, dock_count: 10, installation_date: Time.strptime('4/7/14', '%m/%d/%y'))
    @station_3 = create(:station, dock_count: 30, installation_date: Time.strptime('6/8/14', '%m/%d/%y'))
  end
  context 'instance methods' do
    describe '#zip_code' do

    end

    describe '#trip_start_count' do
      it 'returns the number of trips started at the station' do
        create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id)
        create_list(:trip, 5, station: @station_2, start_station_id: @station_2.id)

        expect(@station_1.trip_start_count).to eq(3)
        expect(@station_2.trip_start_count).to eq(5)
      end
    end

    describe '#trip_end_count' do
      it 'returns the number of trips ended at the station' do
        create_list(:trip, 4, end_station_id: @station_3.id)
        create_list(:trip, 2, end_station_id: @station_2.id)

        expect(@station_3.trip_end_count).to eq(4)
        expect(@station_2.trip_end_count).to eq(2)
      end
    end

    describe '#most_frequent_destination' do
      it 'returns the most frequent destination station for rides that began at the station' do
        create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_3.id)
        create_list(:trip, 4, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_2.id)

        expect(@station_1.most_frequent_destination).to eq(@station_2.name)
      end
    end

    describe '#most_frequent_origination' do
      it 'returns the most frequent origination station for rides that ended at the station' do
        create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_1.id)
        create_list(:trip, 4, station: @station_3, start_station_id: @station_3.id, end_station_id: @station_1.id)

        expect(@station_1.most_frequent_origination).to eq(@station_3.name)
      end
    end

    describe '#busiest_date' do
      it 'returns the date with the highest number of trips started at the station' do
        create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id, end_station_id: @station_1.id)
        create_list(:trip, 4, station: @station_3, start_station_id: @station_3.id, end_station_id: @station_1.id, start_date: Time.parse('3/7/17'))

        expect(@station_3.busiest_date).to eq(Time.parse('3/7/17'))
      end
    end

    describe '#most_frequent_zip_code' do
      it 'returns the Most frequent zip code for users starting trips at this station' do
        create_list(:trip, 3, station: @station_1, start_station_id: @station_1.id, zip_code: 91407)
        create_list(:trip, 4, station: @station_3, start_station_id: @station_3.id, zip_code: 94301)

        expect(@station_3.most_frequent_zip_code).to eq(94301)
      end
    end
  end

  context 'class methods' do

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
        expect(Station.highest_dock_count).to eq([@station_3.name])
      end
    end

    describe '.fewest_bikes_available' do
      it 'returns the lowest dock count of all stations' do
        expect(Station.fewest_bikes_available).to eq(@station_2.dock_count)
      end
    end

    describe '.lowest_dock_count' do
      it 'returns the stations with the lowest dock counts' do
        expect(Station.lowest_dock_count).to eq([@station_2.name])
      end
    end

    describe '.most_recent' do
      it 'returns the station most recently installed' do
        expect(Station.most_recent).to eq(@station_1.name)
      end
    end

    describe '.oldest' do
      it 'returns the station least recently installed' do
        expect(Station.oldest).to eq(@station_2.name)
      end
    end
  end
end
