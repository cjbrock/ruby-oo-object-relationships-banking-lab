require 'pry'
class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    # if the transaction is valid and the sender has enough money and the status is pending
    if valid? && (sender.balance > self.amount) && (self.status == "pending")
      # then we need to subtract the amount from the sender
      sender.balance -= self.amount
      # add the amount to the receiver
      receiver.balance += self.amount
      # set the status to "complete"
      self.status = "complete"
    # OTHERWISE
    else
      # set the status to "rejected"
      transfer_denied
    end
  end


  def reverse_transfer
    if valid? && (receiver.balance > self.amount) && (self.status == "complete")
      # then we need to subtract the amount from the sender
      receiver.balance -= self.amount
      # add the amount to the receiver
      sender.balance += self.amount
      # set the status to "complete"
      self.status = "reversed"
    # OTHERWISE
    else
      # set the status to "rejected"
      transfer_denied
    end
  end

  def transfer_denied
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

end
