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
            only: [:id, :title, :start, :end]
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
        end: params[:end]
      }
      event.save
      respond_to do |format|
        format.json {
          render json:
          @events.to_json(
            only: [:id, :title, :start, :end]
          )
        }
      end
    end


    def update
      event = Event.find_by(id: params[:id]);
      event.attributes = {
        title: params[:title],
        start: params[:start],
        end: params[:end]
      }
      event.save
      respond_to do |format|
        format.json {
          render json:
          @events.to_json(
            only: [:id, :title, :start, :end]
          )
        }
      end
    end

    def destroy
      event = Event.find_by(id: params[:id]);
      event.destroy
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

end
