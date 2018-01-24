class NamesController < ApplicationController
  include MyUtility
  before_action :set_name, only: [:show, :edit, :update, :destroy]

  # GET /names
  def index
    param_set
    @count	= Name.search(params[:q]).result.count()
    @search	= Name.page(params[:page]).search(params[:q])
    @search.sorts = 'id asc' if @search.sorts.empty?
    @names	= @search.result.per(50)
  end

  def param_set
    last_result = Name.maximum('result_no')
    @result_no_form = params[:q] ? params["result_no_form"] : last_result
    params[:q]  = params[:q] ? params[:q] : {"result_no_gteq_any"=>[last_result], "result_no_lteq_any"=>[last_result]}
    
    reference_number_assign(params, "result_no", "result_no_form")
    reference_number_assign(params, "e_no", "e_no_form")
    reference_word_assign(params, "name", "name_form", "cont")
    reference_word_assign(params, "nickname", "nickname_form", "cont")
    
    @e_no_form = params["e_no_form"]
    @name_form = params["name_form"]
    @nickname_form = params["nickname_form"]
  end
  # GET /names/1
  #def show
  #end

  # GET /names/new
  #def new
  #  @name = Name.new
  #end

  # GET /names/1/edit
  #def edit
  #end

  # POST /names
  #def create
  #  @name = Name.new(name_params)

  #  if @name.save
  #    redirect_to @name, notice: 'Name was successfully created.'
  #  else
  #    render action: 'new'
  #  end
  #end

  # PATCH/PUT /names/1
  #def update
  #  if @name.update(name_params)
  #    redirect_to @name, notice: 'Name was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /names/1
  #def destroy
  #  @name.destroy
  #  redirect_to names_url, notice: 'Name was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name
      @name = Name.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def name_params
      params.require(:name).permit(:result_no, :generate_no, :e_no, :name, :nickname)
    end
end