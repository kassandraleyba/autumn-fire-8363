class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def unique_plants
    plants.distinct.where("days_to_harvest < 100").pluck(:name)
  end
end
