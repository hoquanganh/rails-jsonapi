class Api::V1::TransactionsController < ApiController
  before_action :init_transaction, only: [:credit, :debit, :transfer]

  def credit
    process_transaction(CreditTransactionService.new(@transaction))
  end

  def debit
    process_transaction(DebitTransactionService.new(@transaction))
  end

  def transfer
    process_transaction(TransferTransactionService.new(@transaction))
  end

  def index
    @transactions = Transaction.all
    render json: @transactions, status: :ok
  end

  private

  def init_transaction
    @transaction = Transaction.new(transaction_params.merge(transaction_type: transaction_type))
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :to_wallet_id, :from_wallet_id)
  end

  def transaction_type
    case action_name
    when 'debit'
      :debit
    when 'credit'
      :credit
    when 'transfer'
      :transfer
    end
  end

  def process_transaction(service)
    if @transaction.save
      service.process
      render json: service.log_message, status: :ok
    else
      render json: @transaction.errors.full_messages, status: :unprocessable_entity
    end
  end
end
