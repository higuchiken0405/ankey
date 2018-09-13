class CalendarController < ApplicationController
  def index
    # イベント作成フォーム用
    @event = Event.new
  end

end
