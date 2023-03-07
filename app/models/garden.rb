class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots
end
