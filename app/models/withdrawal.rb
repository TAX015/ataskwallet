class Withdrawal < Transaction
  before_create :withdraw

  private
  def withdraw
    source_wallet.decrement! :balance, amount.to_i
  end
end
