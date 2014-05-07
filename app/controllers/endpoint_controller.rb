class EndpointController < ApplicationController

  def show
    msg = {
      :status  => "Success!",
      :service  => params['company'],
      :action   => params['request'],
    }
    render :json => msg # don't do msg.to_json

  end

end
