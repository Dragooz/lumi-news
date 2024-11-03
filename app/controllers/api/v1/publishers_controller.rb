# https://claude.ai/chat/ca6099b8-de78-480f-b97d-c1a307569f66
# Continue here 12.
class Api::V1::PublishersController < ApplicationController
  def index
    @publishers = Publisher.all
    render json: @publishers
  end
end
