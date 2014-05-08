class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def current
    company = params['company']
    @service = Service.last
    response = @service

    msg = {
      :status   => "Current service!",
      :service  => company,
      :current  => response,
    }

    render :json => msg # don't do msg.to_json
  end

  def next
    company = params['company']
    @service = Service.new( name: company, description: '' )
    @service.save

    msg = {
      :status   => "Next service!",
      :service  => company,
      :new => @service,
    }

    render :json => msg # don't do msg.to_json
  end

  def add
    company = params['company']
    @service = Service.find_by( name: company )
    currentDescription = @service['description']
    @service['description'] = @service['description'] + ' ' + currentDescription
    @service.save

    msg = {
      :status   => "Added!",
      :service  => company,
      :old => currentDescription,
      :new => @service['description'],
    }

    render :json => msg # don't do msg.to_json

  end

  def endpoint
    company = params['company']
    @service = Service.find_by( name: company )
    response = @service['description']
    msg = {
      :status   => "Success!",
      :service  => company,
      :response => response,
    }

    render :json => msg # don't do msg.to_json

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :action, :description)
    end
end
