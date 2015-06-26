class RequestsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if@request.save
      flash[:notice] = "Request successfully submitted!"
      redirect_to requests_path
    else
      render :new
    end
  end

  def index
    @requests = Request.order(sort_column + " " + sort_direction)
  end

  def show
    @request = Request.find(params[:id])
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if@request.update(request_params)
      flash[:notice] = "Request successfully updated!"
      redirect_to requests_path
    else
      render :edit
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:notice] = "Request successfully deleted."
    redirect_to requests_path
  end

private
  def request_params
    params.require(:request).permit(:loan_number,
                                    :borrower_name,
                                    :reason)
  end

  def sort_column
    Request.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
