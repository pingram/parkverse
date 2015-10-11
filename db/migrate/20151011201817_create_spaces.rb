class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.integer :owner_id,  null: false
      t.string  :address,   null: false
      t.float   :lat,       null: false
      t.float   :lng,       null: false

      t.timestamps          null: false
    end
  end
end
