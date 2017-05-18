class CreateFiguresTitles < ActiveRecord::Migration
  def change
    create_table :figures_titles do |t|
      t.references :figure
      t.references :title
    end
  end
end
