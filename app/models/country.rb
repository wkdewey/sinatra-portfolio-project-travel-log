class Country < ActiveRecord::Base
  has_many :cities
  has_many :places, through: :cities
  validates :name, presence: true
end
