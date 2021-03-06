class EventsController < ApplicationController
  def live_data
    event = Event.find(params[:id])
    render :nothing => true if event.nil?
    render :json => {
      :photos_count => event.photos_count, 
      :users_count => event.users_count, 
      :comments_count => event.comments_count, 
      :rating => event.rating}
  end

  def close_to_user
    @close_events = Event.close_to(
      request.location.latitude,
      request.location.longitude).
    actives.
    paginate(page: params[:page], per_page: 9)
  end

  def next_events
    @next_events = Event.close_to_without_order(
      request.location.latitude,
      request.location.longitude).
    next_events.
    paginate(page: params[:page], per_page: 9)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(session[:events_created].last)
    @event.user_photos.build if @event.user_photos.blank?
  end

  def update
    @event = Event.find(session[:events_created].last)
    @event.user_id = current_user.id
    if @event.update_with_first_photo(params[:event],params[:first_photo])
      redirect_to event_path(@event)
    else
      raise @event.errors.inspect
    end
  end

  def create
    @event = Event.new(params[:event])
    # @event.user_id = current_user.id if user_signed_in?
    if @event.save
      session[:events_created] ||= []
      session[:events_created] << @event.id
      redirect_to edit_event_path(:atual), notice: 'Evento criado com sucesso'
    else
      render action: :new
    end
  end
end
