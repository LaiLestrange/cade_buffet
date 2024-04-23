class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :details
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
