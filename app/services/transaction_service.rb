class TransactionService
  attr_accessor :amount, :from_wallet, :to_wallet

  def initialize(transaction)
    @transaction = transaction
    @amount = transaction.amount
    @from_wallet = transaction.from_wallet
    @to_wallet = transaction.to_wallet
  end

  def process
    raise NotImplementedError, "Subclasses must implement the 'process' method."
  end
end
