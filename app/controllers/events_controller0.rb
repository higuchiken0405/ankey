class EventsController < ApplicationController

  def new
    @event = Event.new
  end


  def show
      @events = Event.all
      # render :json => @event
      respond_to do |format|
        format.json {
          render json:
          @events.to_json(
            only: [:title, :start, :end]
          )
        }
      end
    end

    def create
      @event = Event.new(event_params)
      @event.user_id = current_user.id
      if @event.start.blank?
        @event.start = Time.now
        @event.end = Time.now
      end
      if @event.save
        flash[:sucsess] = "イベント作成に成功しました"
        redirect_to user_calendar_index_path(current_user)
      else
        flash[:danger] = "イベント作成に失敗しました"
        render user_calendar_index_path(current_user)
      end
    end

    def edit
      @event = Event.find_by(id: params[:id])
    end
    def update

    end

    def destroy
      @events.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


    private
      def event_params
        params.require(:event).permit(:title, :start, :end)
      end

end
