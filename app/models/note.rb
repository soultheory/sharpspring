class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body,  type: String

  validate :validate_title_and_body
  validates :title, length: { minimum: 2, maximum: 30 }
  validates :body, length: { minimum: 2, maximum: 1000 }

  embedded_in :user

  def friendly_date
    created_at&.strftime("%a %l:%M %p")
  end

  private

  # Valid if:
  # 1) Have just a title with no more than 30 characters
  # 2) Don't have a title but have a body and skim the first 30 characters of it
  # 3) Have a body with no more than 1000 characters
  def validate_title_and_body
    return true unless self[:title].blank?
    return raise("Title and Body are required") if self[:body].blank?
    self[:title] = self[:body][0..29]
  end
end
