class Review < ActiveRecord::Base
  belongs_to :reviewee, class_name: "User"
  belongs_to :reviewer, class_name: "User"

  def clean_comment
    if comment.present?
      self.comment = comment.gsub("shit", "****")
    end
  end
end
