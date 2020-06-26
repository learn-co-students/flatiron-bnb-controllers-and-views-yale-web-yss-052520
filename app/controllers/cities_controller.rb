class CitiesController < ApplicationController
    before_action :find_city, only: [:show, :edit, :update, :destroy]

    def index()
        @cities = City.all
    end

    def show()
    end

    def new()
        @city = City.new()
    end

    def create()
        @city = City.new(city_params)
        validate(new_city_path)
    end

    def edit()
    end

    def update()
        @city.update(city_params)
        validate(edit_city_path(@city))
    end

    def destroy()
        @city.delete
        redirect_to cities_path
    end

    private

    def city_params
        params.require(:city).permit(:name)
    end

    def find_city()
        @city = City.find(params[:id])
    end

    def validate(error_path)
        if @city.valid?
            @city.save
            redirect_to city_path(@city)
        else
            flash[:errors] = @city.errors.full_messages
            redirect_to error_path
        end
    end
end
