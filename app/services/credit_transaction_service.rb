class CreditTransactionService < TransactionService
  def process
    return unless should_run?

    ActiveRecord::Base.transaction do
      to_wallet.update!(balance: to_wallet.balance + amount)
    end
  end

  def log_message
    "Credit Transaction processed: amount #{amount} to wallet #{to_wallet.id}"
  end

  private

  def should_run?
    to_wallet.present? && amount.positive?
  end
end
