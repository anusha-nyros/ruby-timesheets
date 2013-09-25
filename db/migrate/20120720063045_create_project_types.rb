class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :type_name

      t.timestamps
    end
  end
end
