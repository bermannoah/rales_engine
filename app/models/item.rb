class Item < ApplicationRecord
  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.item_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end

  def self.most_revenue(quantity)
    find_items_with_successful_transactions
                                                      .group(:id)
                                                      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
                                                      .limit(quantity)
  end

  def self.most_items(quantity)
    find_items_with_successful_transactions
                                                      .group(:id)
                                                      .order("sum(invoice_items.quantity) DESC")
                                                      .limit(quantity)
  end

  def best_day
    invoices.joins(:transactions, :invoice_items).merge(Transaction.success)
                                                      .group(:created_at, :id)
                                                      .order("sum(invoice_items.quantity) DESC")
                                                      .first.created_at
  end
    
  def self.find_items_with_successful_transactions
    joins(:invoice_items, invoices: :transactions).merge(Transaction.success)
  end
    
end
