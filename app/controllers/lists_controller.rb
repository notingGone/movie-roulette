class ListsController < ApplicationController
  def new
  end

  def all
  end

  def view
    @lists = current_user.lists
  end

  def edit
  end
end
