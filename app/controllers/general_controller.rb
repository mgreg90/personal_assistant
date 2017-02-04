class GeneralController < ApplicationController

# validate request with uCQtLmtK6EycKlaxXfHDMNEI

  def start_conversation
    render json: params
    # Context.new(params)
  end

  private

  def _params

  end

end
