class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :o_type
      t.string :password_digest
    end
  end
end
