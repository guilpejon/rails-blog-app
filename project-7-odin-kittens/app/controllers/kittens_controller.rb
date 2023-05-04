class KittensController < ApplicationController
  before_action :set_kitten, only: %i[show edit update destroy]

  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit; end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save!
      flash[:success] = 'Kitten created!'
      redirect_to @kitten
    else
      render :new
    end
  end

  def update
    if @kitten.update(kitten_params)
      flash[:success] = 'Kitten updated!'
      redirect_to @kitten
    else
      render :edit
    end
  end

  def destroy
    @kitten.destroy

    flash[:success] = 'Kitten was destroyed!'
    redirect_to kittens_url
  end

  private

  def set_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
