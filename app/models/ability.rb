class Ability
  include CanCan::Ability

  def initialize(customer)
    customer ||= Customer.new
  end
end
