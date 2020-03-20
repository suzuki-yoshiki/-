class MemosController < ApplicationController
  before_action :set_user
  before_action :set_memo, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  
  def index
    @memos = Memo.all
    @memos = Memo.paginate(page: params[:page])
  end
  
  def new
    @user=User.find(params[:user_id])
    @memo = Memo.new
  end
  
  def show
    @memo = Memo.find_by(params[:user_id])
  end
  
  def create
    @memo = @user.memos.new(memo_params)
    if @memo.save
      flash[:success]="メモ新規作成しました。"
      redirect_to user_memos_url @user
    else
      flash.now[:danger] = "メモを作成できませんでした。"
      render :new
    end
  end
  
  def edit
    @memo = Memo.find_by(params[:user_id])
  end
  
  def update
    if @memo.update_attributes(memo_params)
      flash[:success] = "メモを更新しました。"
      redirect_to user_memo_url(@user, @memo)
    else
      render :edit
    end
  end
  
  def destroy
    @memo.destroy
    flash[:danger] = "メモを削除しました。"
    redirect_to user_memos_url @user
  end
  
  
  
  
  private
  
  def set_user
    @user=User.find(params[:user_id])
  end
  
  def memo_params
    params.require(:memo).permit(:title, :note, :user_id)
  end
  
  def set_memo
      unless @memo = @user.memos.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_memos_url @user
      end
  end
  
end
