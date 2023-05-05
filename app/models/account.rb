class Account < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :user_id, :balance

  def self.open(params)
    account = new(params)
    puts "Creating a account with #{account.attributes}"
    account.save!
  end

  def self.deposit(account, amount)
    puts "Depositing #{amount} on account #{account.id}"

    return false unless self.valid_deposit?(amount)
    account.balance = (account.balance += amount).round(2)
    account.save!
  end

  def self.withdraw(account, amount)
    puts "Withdrawing #{amount} on account #{account.id}"
    return false unless self.amount_valid?(account, amount)
    account.balance = (account.balance -= amount).round(2)
    account.save!
  end

  def self.transfer(account, recipient, amount)
    puts "Transfering #{amount} from account #{account.id} to account #{recipient.id}"
    tax = self.handle_taxes(amount)
    return false unless self.amount_valid?(account, amount, tax)
    ActiveRecord::Base.transaction do
      self.withdraw(account, amount + tax)
      self.deposit(recipient, amount + tax)
    end
  end

  private
  def self.amount_valid?(account, amount, tax = 0)
    if amount <= 0
      puts 'Transaction failed! Amount must be greater than 0.00'
      return false
    elsif amount + tax > account.balance 
      puts 'Transaction failed! Amount must be less than balance'
      return false
    else
      return true
    end
  end

  def self.valid_deposit?(amount)
    if amount <= 0
      puts 'Transaction failed! Amount must be greater than 0.00'
      return false
    else
      return true
    end
  end

  def self.handle_taxes(amount, datetime = Time.now)
    if amount >= 1000
      10
    elsif datetime.monday? || datetime.tuesday? || datetime.wednesday? || datetime.thursday? || datetime.friday?
      if datetime.in_time_zone("Brasilia").hour.between?(9, 18)
        5
      else
        7
      end
    else
      7
    end
  end

end