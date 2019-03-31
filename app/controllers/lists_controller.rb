class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :delete, :show]
  def new
    @list = List.new
  end

  def all
    @lists = current_user.lists
  end

  def show
  end

  def edit
  end

  def delete
  end

  private

    def set_list
      @list = List.find(params[:id])
    end
end
