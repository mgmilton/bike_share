require "rails_helper"

describe Condition, type: :model do
  describe "validations" do
    # it {should validate_presence_of(:date)}
    # it {should validate_presence_of(:max_temperature)}
    # it {should validate_presence_of(:mean_temperature)}
    # it {should validate_presence_of(:min_temperature)}
    # it {should validate_presence_of(:mean_humidity)}
    # it {should validate_presence_of(:zip_code)}
  end

  describe "class methods" do
    before(:each) do
      create_list(:condition, 10)
    end

    describe ".set_divisions" do
      it "returns a number for amount of divisions" do
        expect(Condition.set_divisions(2,10,2)).to eq(4)
        expect(Condition.set_divisions(13,100,10)).to eq(8)
      end
    end

    describe ".set_range" do
      it "returns an array of ranges based on amount of divisions" do
        expect(Condition.set_range(2,10,2)).to eq([[2.0, 4.0], [4.0, 6.0], [6.0, 8.0], [8.0, 10.0], [10.0, 12.0]])
        expect(Condition.set_range(13,100,10)).to eq([[13.0, 23.0], [23.0, 33.0], [33.0, 43.0], [43.0, 53.0], [53.0, 63.0], [63.0, 73.0], [73.0, 83.0], [83.0, 93.0], [93.0, 103.0]])
      end
    end

    describe ".temperature_range" do
      it "returns an array of temperature ranges" do
        expect(Condition.temperature_range).to eq([[0.105e3, 0.115e3]])
      end
    end

    describe ".precipitation_range" do
      it "returns an array of precipitation ranges" do
        expect(Condition.precipitation_range).to eq([[0.0, 0.5e0]])
      end
    end

    describe ".wind_range" do
      it "returns an array of wind ranges" do
        expect(Condition.wind_range).to eq([[0.3e1, 0.7e1]])
      end
    end

    describe ".visibility_range" do
      it "returns an array of visibility ranges" do
        expect(Condition.visibility_range).to eq([[0.3e1, 0.7e1]])
      end
    end

    describe ".min" do
      it "returns the minimum from a descending array of ride counts" do
        expect(Condition.min([])).to eq(0)
        expect(Condition.min([3,2,1])).to eq(1)
        expect(Condition.min([100,20,3])).to eq(3)
      end
    end

    describe ".max" do
      it "returns the maximum from a descending array of ride counts" do
        expect(Condition.max([])).to eq(0)
        expect(Condition.max([3,2,1])).to eq(3)
        expect(Condition.max([100,20,3])).to eq(100)
      end
    end

    describe ".average" do
      it "returns the average from a descending array of ride counts" do
        expect(Condition.average([])).to eq(0)
        expect(Condition.average([3,2,1])).to eq(2)
        expect(Condition.average([100,20,3])).to eq(41)
      end
    end
  end
end
