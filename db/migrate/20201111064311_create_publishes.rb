class CreatePublishes < ActiveRecord::Migration[6.0]
  def change
    create_table :publishes do |t|
      t.references :user, foreign_key: true
      t.references :note, foreign_key: true
      t.timestamps
    end
  end
end
