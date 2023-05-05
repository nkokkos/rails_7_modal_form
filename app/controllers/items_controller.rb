class ItemsController < ApplicationController

  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all
  end

  # GET /items/1 or /items/1.json
  def show
    @selected = @item.student_ids
  end

  # GET /items/new
  def new
    @item = Item.new
    @selected = Array.new
  end

  # GET /items/1/edit
  def edit
    @selected = @item.student_ids
    @selected_for_tomselect = @selected.collect { |x| {id: Student.find(x).id,  first_name: Student.find(x).first_name} }
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save!
        format.html { redirect_to items_url, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        puts @item.inspect
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_url, notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def autocomplete

    if params[:q].length > 2

      search_string = []

      columns.each do |term|
        search_string << "#{term} like :search"
      end

      # the following commands don't seem to work:
      # list = Category.order(:name).where("email like :q", q: "%#{params[:q]}%").or(Category.order(:name).where("email like :q", q: "%#{params[:q]}%"))
      # list = Category.where("email like :q", q: "%#{params[:q]}%").or(Category.where("email like :q", q: "%#{params[:q]}%"))

      list = Student.where(search_string.join(' or '), search: "%#{params[:q]}%")
      render json: list.map { |u|
        { id: u.id,
          first_name: u.first_name,
          last_name:  u.last_name,
          email: u.email_address
        }
      }

    end

  end

  def columns
    %w(first_name last_name email_address)
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :description, :can_send_email,
        :graduation_year, :body_temperature, :birthday, :favorite_time, :price, 
        :status, roles: [], student_ids: [] )
    end
end
