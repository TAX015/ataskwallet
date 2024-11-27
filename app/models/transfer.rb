class Transfer < Transaction
  before_create :transfer

  private
  def transfer
    source_wallet.decrement! :balance, amount.to_i
    target_wallet.increment! :balance, amount.to_i
  end
end
