require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  describe "As a visitor" do
    let!(:garden1) { Garden.create!(name: "Turing Community Garden", organic: true) }

    let!(:plot_1) { garden1.plots.create!(number: 25, size: "Large", direction: "East") }
    let!(:plot_2) { garden1.plots.create!(number: 26, size: "Medium", direction: "West") }

    let!(:plant_1) { Plant.create!(name: "Lavender", description: "Purple", days_to_harvest: 100) }
    let!(:plant_2) { Plant.create!(name: "Rosemary", description: "Green", days_to_harvest: 90) }
    let!(:plant_3) { Plant.create!(name: "Thyme", description: "Green", days_to_harvest: 80) }
    let!(:plant_4) { Plant.create!(name: "Basil", description: "Green", days_to_harvest: 70) }
    let!(:plant_5) { Plant.create!(name: "Lavender", description: "Purple", days_to_harvest: 100) }

    before do
      PlantPlot.create!(plant: plant_1, plot: plot_1)
      PlantPlot.create!(plant: plant_2, plot: plot_1)
      PlantPlot.create!(plant: plant_3, plot: plot_1)
      PlantPlot.create!(plant: plant_4, plot: plot_2)
      PlantPlot.create!(plant: plant_5, plot: plot_2)

      visit '/plots'
    end

    # User Story 1, Plots Index Page
    describe "When I visit the /plots" do
      it "I see a list of all plot numbers and the names of all that plot's plants" do
        within "#plot-#{plot_1.id}" do
          expect(page).to have_content("Plot")
          expect(page).to have_content(plot_1.number)

          expect(page).to have_content("Plants")
          expect(page).to have_content(plant_1.name)
          expect(page).to have_content(plant_2.name)
          expect(page).to have_content(plant_3.name)

          expect(page).to_not have_content(plant_4.name)
        end

        within "#plot-#{plot_2.id}" do
          expect(page).to have_content("Plot")
          expect(page).to have_content(plot_2.number)

          expect(page).to have_content("Plants")
          expect(page).to have_content(plant_4.name)
          expect(page).to have_content(plant_5.name)

          expect(page).to_not have_content(plant_2.name)
          expect(page).to_not have_content(plant_3.name)
        end
      end
    end

    # User Story 2, Remove a Plant from a Plot
    describe "When I visit the /plots" do
      it "I see a link to remove that plant from that plot" do
        within "#plot-#{plot_1.id}" do
          expect(page).to have_link("Remove #{plant_1.name} from #{plot_1.number}")
          
          click_on "Remove #{plant_1.name} from #{plot_1.number}"
          
          expect(current_path).to eq('/plots')
          
          expect(page).to_not have_content(plant_1.name)

          expect(page).to have_content(plant_2.name)
          expect(page).to have_content(plant_3.name)
        end

        within "#plot-#{plot_2.id}" do
          expect(page).to have_link("Remove #{plant_5.name} from #{plot_2.number}")
          
          click_on "Remove #{plant_5.name} from #{plot_2.number}"
          
          expect(current_path).to eq('/plots')
          
          expect(page).to_not have_content(plant_5.name)

          expect(page).to have_content(plant_4.name)
        end
      end
    end
  end
end
