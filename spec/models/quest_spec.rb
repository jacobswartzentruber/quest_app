require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "has a valid factory" do
  	expect(build(:quest)).to be_valid
  end

  it "is invalid without a name" do 
  	expect(build(:quest, name: "")).to_not be_valid
  end

  it "is invalid without a goal time" do
  	expect(build(:quest, goal: nil)).to_not be_valid
  end

  it "is invalid with a goal time less than 1" do
  	expect(build(:quest, goal: 0)).to_not be_valid
  end

  it "starts with a rank of 'Newborn'" do
  	expect(build(:quest).rank).to eql("Newborn")
  end

  it "starts with a last_record of 0" do
  	expect(build(:quest).last_record).to eql(0)
  end

  subject { create(:quest) }

  describe "#percent_last_record" do
  	it "returns 0 if current progress matches or is greater than last_record" do
  		subject.last_record = 20
  		subject.start_day = Date.today-20.days
  		expect(subject.percent_last_record).to eql(0)
  	end

  	it "returns correct percent if current progress less than last_record" do
  		subject.last_record = 20
  		subject.start_day = Date.today-10.days
  		expect(subject.percent_last_record).to eql(25)
  	end
  end
end
