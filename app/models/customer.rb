class Customer < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.customer_randomizer
    total = all.count - 1
    random_position = rand(0..total)
    all[random_position]
  end
    
  def favorite_merchant
    merchants.joins(invoices: :transactions).merge(Transaction.success)
                                            .order("transactions.count DESC")
                                            .group(:id).first
  end
  
  private
  
  def self.valid_search_parameters(params)
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
  
end