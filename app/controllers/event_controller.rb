class EventController < ApplicationController

  def show
      @event = Event.all
      # render :json => @event
      respond_to do |format|
        format.json {
          render json:
          @event.to_json(
            only: [:title, :start, :end]
          )
        }
      end
    end

    def create
      event = Event.new
      event.user_id = current_user.id
      event.attributes = {
        title: params[:title],
        start: params[:start],
        end: params[:end],
      }
      event.save
      respond_to do |format|
        format.json {
          render json:
          @event.to_json(
            only: [:title, :start, :end]
          )
        }
      end
    end


    def update

    end

    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
end
