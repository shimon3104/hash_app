class DropTablePublishes < ActiveRecord::Migration[6.0]
  def change
    drop_table :publishes
  end
end
