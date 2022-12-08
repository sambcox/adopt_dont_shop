class CreateApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :address
      t.string :reason
      t.string :status
    end
  end
end
