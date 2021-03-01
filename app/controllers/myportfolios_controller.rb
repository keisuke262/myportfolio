class MyportfoliosController < ApplicationController

  #application.html.erbを適用せずに新たに作ったindex.html.erbを適用する
  layout 'index'

  def index
  end
end

