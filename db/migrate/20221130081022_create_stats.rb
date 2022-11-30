class CreateStats < ActiveRecord::Migration[6.1]
  def change
    create_table :stats do |t|
      t.integer :counter, default: 0
      t.integer :wins, default: 0
      t.integer :loses, default: 0
      t.decimal :percentage, default: 0.0, precision: 8, scale: 2

      t.timestamps
    end
  end
end
