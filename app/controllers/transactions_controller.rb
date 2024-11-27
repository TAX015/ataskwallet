class TransactionsController < ApplicationController
  layout "transaction"

  def deposit
    @transaction = Transaction.new
  end

  def withdraw
    @transaction = Transaction.new
  end

  def transfer
    @transaction = Transaction.new
    @targets = Wallet.joins(:user).where.not(wallets: { user_id: @current_user.id }).select("wallets.id, users.name")
  end

  def create_deposit
    # render json: params
    # return false
    ActiveRecord::Base.transaction do
      wallet = Wallet.find(params[:wallet_id])
      amount = params[:amount].to_f
      description = params[:description]

      raise ActiveRecord::Rollback, "Invalid amount" if amount <= 0

      Deposit.create!(
        target_wallet_id: wallet.id,
        amount: amount,
        transaction_type: "debit",
        status: "complete",
        description: description,
      )

      flash[:success] = "Successfully deposited #{amount} into your wallet"
      redirect_to deposit_transactions_path
    rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
      flash[:error] = "Failed to deposit money: #{e.message}"
      redirect_to deposit_transactions_path
    end
  end

  def create_withdraw
    ActiveRecord::Base.transaction do
      wallet = Wallet.find(params[:wallet_id])
      amount = params[:amount].to_f
      description = params[:description]

      raise ActiveRecord::Rollback, "Invalid amount" if amount <= 0
      raise ActiveRecord::Rollback, "Insufficient balance" if wallet.balance < amount

      Withdrawal.create!(
        source_wallet_id: wallet.id,
        amount: amount,
        transaction_type: "credit",
        status: "complete",
        description: description,
      )

      flash[:success] = "Successfully withdraw #{amount} into your wallet"
      redirect_to withdraw_transactions_path
    rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
      flash[:error] = "Failed to withdraw money: #{e.message}"
      redirect_to withdraw_transactions_path
    end
  end

  def create_transfer
    ActiveRecord::Base.transaction do
      raise ActiveRecord::Rollback, "Invalid target wallet" if params[:target_wallet_id].blank?

      source = Wallet.find(params[:wallet_id])
      target = Wallet.find(params[:target_wallet_id])
      amount = params[:amount].to_f
      description = params[:description]

      raise ActiveRecord::Rollback, "Invalid amount" if amount <= 0
      raise ActiveRecord::Rollback, "Insufficient balance" if source.balance < amount

      Transfer.create!(
        source_wallet_id: source.id,
        target_wallet_id: target.id,
        amount: amount,
        transaction_type: "credit",
        status: "complete",
        description: description,
      )

      flash[:success] = "Successfully transfer #{amount} from #{source.user.name} to #{target.user.name}"
      redirect_to transfer_transactions_path
    rescue ActiveRecord::RecordInvalid, ActiveRecord::Rollback => e
      flash[:error] = "Failed to transfer money: #{e.message}"
      redirect_to transfer_transactions_path
    end
  end
end
