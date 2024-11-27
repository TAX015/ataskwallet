class Deposit < Transaction
  before_create :deposit

  private
  def deposit
    target_wallet.increment! :balance, amount.to_i
  end
end
