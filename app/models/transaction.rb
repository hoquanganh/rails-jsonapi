class Transaction < ApplicationRecord
  belongs_to :to_wallet, class_name: "Wallet", optional: true
  belongs_to :from_wallet, class_name: "Wallet", optional: true

  enum transaction_type: { credit: 0, debit: 1, transfer: 3 }

  validates :transaction_type, presence: true
  validates :amount, presence: true, numericality: true
  validate :source_wallet_presence, if: :debit? # Deposits into wallet
  validate :to_wallet_presence, if: :credit?    # Withdrawals from wallet

  private

  def source_wallet_presence
    errors.add(:from_wallet, "must be present for credit transactions") if from_wallet.nil?
  end

  def to_wallet_presence
    errors.add(:to_wallet, "must be present for debit transactions") if to_wallet.nil?
  end
end
