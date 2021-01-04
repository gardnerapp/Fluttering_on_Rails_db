class V1::ItemsController < ApplicationController
  before_action :find_item, only: %i[show update destroy]
  
  #GET /items
  def index
    @items = Item.all
    render json: @items, status: :ok
  end

  #GET /item/:id
  def show
      render json: @item, status: :ok
  end

  #POST /items
  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item
    else
      render error: { error: 'Unable to create item' }, status: :bad_request
    end
  end

  def update
    if @item
      @item.update(item_params)
      render json: { message: 'Item successfully updated' }, status: :ok
    else
      render json: { error: 'unable to update item'}, status: :bad_request
    end
  end

  def destroy
    if @item
      @item.destroy
      render json: { message: 'Item successfully destroy' }, status: :ok
    else
      render json: { message: 'unable to delete item' }, status: :bad_request
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price)
  end
  #fix this how to integrate begin, rescue
  def find_item
    begin
      @item = Item.find(params[:id])
    rescue StandardError 
      @item = nil
      end
  end

end
