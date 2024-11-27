class Wallet < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :source_transactions, class_name: "Transaction", foreign_key: "source_wallet_id"
  has_many :target_transactions, class_name: "Transaction", foreign_key: "target_wallet_id"

  # Behavior
  def calculate_balance
    target_transactions.sum(:amount) - source_transactions.sum(:amount)
  end
end
