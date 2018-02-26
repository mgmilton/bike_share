class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def map

  end
end
