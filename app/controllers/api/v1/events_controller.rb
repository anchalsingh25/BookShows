module Api
  module V1
    class EventsController < ApplicationController
      before_action :authorized
      before_action :set_event, only: %i[show update destroy]

      def index
        events = Event.all
        render json: events
      end

      def show
        render json: @event
      end

      # def create
      #   if current_user.admin?
      #     event = Event.new(event_params)
      #     event.user_id = current_user.id
      #     if event.save
      #       render json: event, status: :created
      #     else
      #       render json: event.errors, status: :unprocessable_entity
      #     end
      #   else
      #     render json: { error: 'Only admins are allowed to create events' }, status: :forbidden
      #   end
      # end

      def create
        unless current_user.admin?
          return render json: { error: 'Only admins are allowed to create events' }, status: :forbidden
        end

        event = current_user.events.build(event_params)

        if event.save
          render json: event, status: :created
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end


      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: @event.error, status: :unprocessable_entity
        end
      end

      def destroy
        @event.destroy
        head :no_content
      end

      private

      def set_event
        @event = Event.find_by(id: params[:id])
        return render json: { error: 'Events not found' }, status: :not_found if @event.nil?
      end

      def event_params
        params.require(:events).permit(:title, :description, :category, :startTime, :endTime, :date)
      end
    end
  end
end
