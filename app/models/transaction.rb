class Transaction < ApplicationRecord
  # Associations
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true
end
