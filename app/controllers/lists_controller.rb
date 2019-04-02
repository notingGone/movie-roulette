class ListsController < ApplicationController
  before_action :set_list, only: [:edit, :delete, :show]

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List created successfully.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: unprocessable_entity }
      end
    end
  end

  def all
    @lists = current_user.lists
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
  end

  def delete
  end

  private

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
