require 'rails_helper'

RSpec.describe 'Garden Show Page' do
  describe "As a visitor" do
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

      visit "/gardens/#{garden1.id}}"
    end
    # User Story 3, Garden's Plants

    # As a visitor
    # When I visit a garden's show page ('/gardens/:id')
    # Then I see a list of plants that are included in that garden's plots
    # And I see that this list is unique (no duplicate plants)
    # And I see that this list only includes plants that take less than 100 days to harvest
    
    describe "When I visit the /gardens/:id" do
      it "I see a unique list of plants that are included in that garden's plots that take less than 100 days to harvest" do
        expect(page).to have_content(plant_2.name)
        expect(page).to have_content(plant_3.name)
        expect(page).to have_content(plant_4.name)
        
        expect(page).to_not have_content(plant_1.name)
        expect(page).to_not have_content(plant_5.name)
        expect(page).to_not have_content(plant_6.name)
      end
    end
  end
end