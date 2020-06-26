class NeighborhoodsController < ApplicationController
    before_action :find_neighborhood, only: [:show, :edit, :update, :destroy]
    before_action :get_cities, only: [:edit, :new]
    def index()
        @neighborhoods = Neighborhood.all
    end

    def show()
    end

    def new()
        @neighborhood = Neighborhood.new()
    end

    def create()
        @neighborhood = Neighborhood.new(neighborhood_params)
        validate(new_neighborhood_path)
    end

    def edit()
    end

    def update()
        @neighborhood.update(neighborhood_params)
        validate(edit_neighborhood_path(@neighborhood))
    end

    def destroy()
        @neighborhood.delete
        redirect_to neighborhoods_path
    end

    private

    def neighborhood_params
        params.require(:neighborhood).permit(:name)
    end

    def find_neighborhood()
        @neighborhood = Neighborhood.find(params[:id])
    end

    def get_cities()
        @cities = City.all
    end

    def validate(valid_path = neighborhood_path(@neighborhood), error_path)
        if @neighborhood.valid?
            @neighborhood.save
            redirect_to valid_path
        else
            flash[:errors] = @neighborhood.errors.full_messages
            redirect_to error_path
        end
    end
end
