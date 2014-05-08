class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def current
    company     = params['company']
    @service    = Service.last
    response    = @service

    msg = {
      :status   => "Current service!",
      :service  => company,
      :current  => response,
    }

    render :json => msg # don't do msg.to_json
  end

  def loadNext
    company     = params['company']
    @service    = Service.new( name: company, description: [].to_json )
    @service.save

  end

  def add
    company                 = params['company']
    newDescription          = params['newDescription']
    @service                = Service.last
    currentDescription      = JSON::parse(@service['description'])
    currentDescription      = currentDescription.push(newDescription)
    @service['description'] = currentDescription.to_json
    @service.save

    msg = {
      :status   => "Added!",
      :service  => company,
      :new      => newDescription,
      :all      => @service['description'],
    }

    render :json => msg # don't do msg.to_json

  end

  def endpoint
    company   = params['company']
    @service  = Service.last
    response  = @service['description']
    msg = {
      :status   => "Success!",
      :service  => company,
      :response => response,
    }
    loadNext

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
