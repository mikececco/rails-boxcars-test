require 'boxcars'

class BoxcarsController < ApplicationController

    def index
        session[:qa] ||= []


        if params[:textcommand]
            # Instantiate the Active Record BoxCar
            ar_boxcar = Boxcars::ActiveRecord.new

            # The user's question is passed in via the textcommand parameter
            @question = params[:textcommand]

            # We send the question to AI and have it run the Active Record query
            @answer = ar_boxcar.run @question

            # We add the question, answer, and current time into an array
            # and store it in the session
            @qa = [@question, @answer, Time.now ]
            session[:qa].prepend @qa

        end
        @qalist = session[:qa]

        respond_to do |format|
            format.html
            format.turbo_stream
        end
    end
end
