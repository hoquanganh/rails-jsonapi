# wallet transactional API

Things you may want to cover:

* Models
  user: rails generate model User name:string email:string password_digest:string role:integer
  team: rails generate model Team name:string description:text
  stock: rails generate model Stock symbol:string company_name:string price:decimal
  wallet:
    rails generate model Wallet balance:decimal currency:string walletable:references{polymorphic}
  transaction:
    rails generate model Transaction amount:decimal{10,2} transaction_type:integer to_wallet:references{to_table: :wallets} from_wallet:references{to_table: :wallets}

* Wallet
  create wallet:
    - POST /wallets

  get wallet balance:
    - GET /wallets/:id/balance

* Transaction:
  Credit Transaction (Deposit):
    - request: POST /transactions/credit
    - params: { "to_wallet_id": <to_wallet_id>, "amount": 50.00 }

  Debit Transaction (Withdrawal):
    - POST /transactions/debit
    - { "from_wallet_id": <from_wallet_id>, "amount": 50.00 }

  Transfer Transaction
    - POST /transactions/transfer
    - { "from_wallet_id": <from_wallet_id>, "to_wallet_id": <to_wallet_id>, "amount": 75 }

  Transaction History:
    - GET /transactions
