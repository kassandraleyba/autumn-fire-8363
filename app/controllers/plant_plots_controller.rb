class PlantPlotsController < ApplicationController
  def destroy
    plot = Plot.find(params[:plot_id])
    plant = plot.plants.find(params[:id])
    plot.plants.destroy(plant)
    redirect_to '/plots'
  end
end