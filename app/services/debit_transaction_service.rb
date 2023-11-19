class DebitTransactionService < TransactionService
  def process
    return unless should_run?

    ActiveRecord::Base.transaction do
      from_wallet.update!(balance: from_wallet.balance - amount)
    end
  end

  def log_message
    "Debit Transaction processed: amount #{amount} from wallet #{from_wallet.id}"
  end

  private

  def should_run?
    from_wallet.present? &&
      amount.to_f > 0 &&
      from_wallet.balance >= amount
  end
end
