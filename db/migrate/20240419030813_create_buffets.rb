class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :brand_name
      t.string :company_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.string :full_address
      t.string :state
      t.string :city
      t.string :zip_code
      t.string :description
      t.references :buffet_admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
