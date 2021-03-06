class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :image, ImageUploader

  validates :title, 
    presence: true

  validates :director, 
    presence: true

  validates :runtime_in_minutes, 
    numericality: { only_integer: true }

  validates :description, 
    presence: true

  # validates :poster_image_url, 
    # presence: true

  validates :release_date, 
    presence: true

  validate :release_date_in_the_future

  scope :with_title_like, -> (title) {
    where("title LIKE ?", "%title%")
  }

  scope :with_director_like, -> (director) {
    where("director LIKE ?", "%#director%")
  }

  scope :under_ninety, -> (duration){
    where("runtime_in_minutes < ?", duration)
  }

  scope :between_ninety_and_onetwenty, -> (duration){
    where("runtime_in_minutes <= ?", duration)
  }

  scope :over_onetwenty, -> (duration){
    where("runtime_in_minutes > ?", duration)
  }


  def review_average
    if reviews.size < 1
      return 0
    else
      reviews.sum(:rating_out_of_ten)/reviews.size 
    end
  end

  protected

  def release_date_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
