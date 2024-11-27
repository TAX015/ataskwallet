require "./db/migrate/20241123130536_create_abstract"

class CreateWalletAndTransaction < CreateAbstract
  def change
    create_table :wallets do |t|
      t.references :user, references: :users, index: true
      t.bigint :balance, default: 0, null: false
    end
    additional_columns(:wallets)

    create_table :transactions do |t|
      t.references :source_wallet, references: :wallets, index: true
      t.references :target_wallet, references: :wallets, index: true
      t.bigint :amount, default: 0, null: false
      t.string :transaction_type
      t.string :status
      t.text :description
    end
    additional_columns(:transactions)
  end
end
