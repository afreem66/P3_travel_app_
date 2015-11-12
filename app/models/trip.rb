class Trip < ActiveRecord::Base

  # TRIPTYPE = [
  #   'Spring', 'Summer', 'Fall', 'Winter', 'Family', 'Friends', 'Honeymoon', 'Vacation', 'Other'
  # ]

  validates :title, presence: true
  validates :destination, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  # validates :trip_type, inclusion: { in: TRIPTYPE }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

end
