class QueriesController < ApplicationController
  # layout 'base'
  # before_action :set_query, only: [:show, :edit, :update, :destroy]
  require 'csv'
  # require 'query_storage'

  # GET /queries
  # GET /queries.json
  def index
    @queries = Query.all
    # if @queries.present?
    #   @queries.order(:updated_at).reverse_order
    # end
  end

  # GET /queries/1
  # GET /queries/1.json
  def show
    @query = Query.find_by_id(params[:id])
    sql = @query.sql
    @result = QueryStorage.execute_sql(sql)
    # has_header = true
    # @csv_date = QueryStorage.get_csv_data(@result, has_header)
    # @tsv_date = QueryStorage.get_tsv_data(@result, has_header)
    @header = @result[0].keys
    @result = Kaminari.paginate_array(@result.to_a).page(params[:page]).per(1000)
  end

  # GET /queries/new
  def new
    @query = Query.new
  end

  # GET /queries/1/edit
  def edit
    @query = Query.find_by_id(params[:id])
  end

  # POST /queries
  # POST /queries.json
  def create
    @query = Query.new(params[:query])
    # update,insert文だと思われる場合は登録を禁止する。
    if QueryStorage.is_insert_or_update_sql(@query.sql)
      flash.now[:alert] =  "更新処理(UPDATE文,INSERT文)の恐れがあるため登録を禁止します."
      render :new
      return
    end

    respond_to do |format|
      if @query.save
        format.html { redirect_to @query, :notice => 'Query was successfully created.' }
        format.json { render :show, :status => :created, :location => @query }
      else
        format.html { render :new }
        format.json { render :json => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /queries/1
  # PATCH/PUT /queries/1.json
  def update
    @query = Query.find_by_id(params[:id])
    # update,insert文だと思われる場合は登録を禁止する。
    if QueryStorage.is_insert_or_update_sql(@query.sql)
      flash.now[:alert] =  "更新処理(UPDATE文,INSERT文)の恐れがあるため登録を禁止します."
      render :edit
      return
    end
    respond_to do |format|
      if @query.update_attributes(params[:query])
        format.html { redirect_to @query, :notice => 'Query was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @query }
      else
        format.html { render :edit }
        format.json { render :json => @query.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /queries/1
  # DELETE /queries/1.json
  def destroy
    @query = Query.find_by_id(params[:id])
    @query.destroy
    respond_to do |format|
      format.html { redirect_to queries_url, :notice => 'Query was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download_csv
    query = Query.find_by_id(params[:id])
    result = QueryStorage.execute_sql(query.sql)
    has_header = true
    csv_data = QueryStorage.get_csv_data(result, has_header)
    csv_data = csv_data.encode(Encoding::SJIS, :invalid => :replace, :undef => :replace)
    respond_to do |format|
      format.html
      format.csv { send_data csv_data, :type => 'text/csv; charset=shift_jis', :filename => query.title+".csv" }
    end
  end

  def download_tsv
    query = Query.find_by_id(params[:id])
    result = QueryStorage.execute_sql(query.sql)
    has_header = true
    csv_data = QueryStorage.get_tsv_data(result, has_header)
    csv_data = csv_data.encode(Encoding::SJIS, :invalid => :replace, :undef => :replace)
    respond_to do |format|
      format.html
      format.csv { send_data csv_data, :type => 'text/csv; charset=shift_jis', :filename => query.title+".tsv" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = Query.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_params
      params.require(:query).permit(:title, :sql, :category_id)
    end
end
