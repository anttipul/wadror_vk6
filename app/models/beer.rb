class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :style, presence: true

  belongs_to :style
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { uniq }, through: :ratings, source: :user

  def to_s
    "#{name} #{brewery.name}"
  end

  def self.top(n)
    all.sort_by{ |b| -(b.average_rating||0) }.take(n)
  end
end
