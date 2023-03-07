class CreatePlantPlots < ActiveRecord::Migration[5.2]
  def change
    create_table :plant_plots do |t|
      t.belongs_to :plant, foreign_key: true
      t.belongs_to :plot, foreign_key: true

      t.timestamps
    end
  end
end
