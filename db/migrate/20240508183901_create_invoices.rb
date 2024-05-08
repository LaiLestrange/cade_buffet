class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.decimal :base_price
      t.decimal :discount
      t.decimal :increase
      t.string :description
      t.date :expiration_date
      # t.references :payment_methods, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.decimal :final_price

      t.timestamps
    end
  end
end
