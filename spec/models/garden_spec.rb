require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plant_plots).through(:plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe "instance methods" do
    let!(:garden1) { Garden.create!(name: "Turing Community Garden", organic: true) }

    let!(:plot_1) { garden1.plots.create!(number: 25, size: "Large", direction: "East") }
    let!(:plot_2) { garden1.plots.create!(number: 26, size: "Medium", direction: "West") }

    let!(:plant_1) { Plant.create!(name: "Lavender", description: "Purple", days_to_harvest: 120) }
    let!(:plant_2) { Plant.create!(name: "Rosemary", description: "Green", days_to_harvest: 90) }
    let!(:plant_3) { Plant.create!(name: "Thyme", description: "Green", days_to_harvest: 80) }
    let!(:plant_4) { Plant.create!(name: "Basil", description: "Green", days_to_harvest: 70) }
    let!(:plant_5) { Plant.create!(name: "Lavender", description: "Purple", days_to_harvest: 120) }
    let!(:plant_6) { Plant.create!(name: "Basil", description: "Green", days_to_harvest: 70) }

    before do
      PlantPlot.create!(plant: plant_1, plot: plot_1)
      PlantPlot.create!(plant: plant_2, plot: plot_1)
      PlantPlot.create!(plant: plant_3, plot: plot_1)
      PlantPlot.create!(plant: plant_4, plot: plot_2)
      PlantPlot.create!(plant: plant_5, plot: plot_2)
    end

    it "#unique_plants" do
      expect(garden1.unique_plants).to eq([plant_2.name, plant_3.name, plant_4.name].sort)
      expect(garden1.unique_plants).to_not eq(plant_1.name)
      expect(garden1.unique_plants).to_not eq(plant_6.name)
    end
  end
end
