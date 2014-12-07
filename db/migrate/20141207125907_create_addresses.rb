class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :zip
      t.integer :person_id
      t.timestamps
    end
    add_index :addresses, :person_id
  end
end
