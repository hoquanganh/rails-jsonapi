class Transaction < ApplicationRecord
  belongs_to :to_wallet, class_name: "Wallet"
  belongs_to :from_wallet, class_name: "Wallet"

  # If there are many types, consider using a model instead of enum
  enum transaction_type: { credit: 0, debit: 1 }

  validates :transaction_type, presence: true
  validates :amount, presence: true, numericality: true
  validate :from_wallet_presence, if: :credit?
  validate :to_wallet_presence, if: :debit?

  private

  def from_wallet_presence
    errors.add(:from_wallet, "must be present for credit transactions") if from_wallet.nil?
  end

  def to_wallet_presence
    errors.add(:to_wallet, "must be present for debit transactions") if to_wallet.nil?
  end
end
