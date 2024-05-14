class CreateAcceptedPaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :accepted_payment_methods do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
