require 'spec_helper'

describe Project do
  describe "with valid parameter" do
    it "should save to database" do
      Factory.build(:project).save.should be_true
    end
  end
end