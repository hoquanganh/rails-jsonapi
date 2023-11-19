class TransferTransactionService < TransactionService
  def process
    return unless should_run?

    ActiveRecord::Base.transaction do
      from_wallet.update!(balance: from_wallet.balance - amount)
      to_wallet.update!(balance: to_wallet.balance + amount)
    end
  end

  def log_message
    "Transfer processed: amount #{amount} from wallet #{from_wallet.id} to wallet #{to_wallet.id}"
  end

  private

  def should_run?
    from_wallet.present? &&
    to_wallet.present? &&
      amount.positive? &&
      from_wallet.balance >= amount
  end
end
