class AccountsController < ApplicationController

  before_action :require_authentication

  def index
    @user_id = current_user.id
    user = User.find_by(id: current_user.id)
    @account = user.accounts.find_by(user_id: current_user.id)
    if @account
      @account
      @account_id = @account.id
      @accounts = Account.where.not(id: @account_id)
    end
  end

  def create
    return head :unprocessable_entity unless Account.open(account_params)
    redirect_to root_path, notice: "Created!"
  end

  def deposit
    account = Account.find(params[:id])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.deposit(account, amount)
    render json: {deposited: true}
  end

  def withdraw
    account = Account.find(params[:id])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.withdraw(account, amount)
    render json: {withdrawn: true}
  end

  def transfer
    account = Account.find(params[:id])
    return head :not_found unless account

    recipient_param = params.permit(:recipient_id)
    recipient = Account.find(recipient_param[:recipient_id])
    return head :not_found unless recipient

    return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
    render json: {transfered: true}
  end

  private
  def account_params
    params.require(:account).permit(:name, :user_id, :balance)
  end

  def amount
    param = params.permit(:amount)
    param[:amount].to_f
  end

  def require_authentication
    redirect_to login_path unless current_user
  end

end