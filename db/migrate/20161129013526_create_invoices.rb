class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :invoices do |t|
      t.citext :status
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true

      t.timestamps null: false
    end
  end
end
