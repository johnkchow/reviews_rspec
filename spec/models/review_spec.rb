require 'rails_helper'

RSpec.describe Review, type: :model do
  # By default subject will just call .new on the described
  # class, but you can be explicit here if you want special
  # setup
  subject { Review.new }

  describe "#clean_comment" do
    it "should strip out 'shit'" do
      subject.comment = "You're the shit!"

      subject.clean_comment

      expect(subject.comment).to eq "You're the ****!"
    end
  end
end
