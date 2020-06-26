class ListingsController < ApplicationController
    before_action :find_listing, only: [:show, :edit, :update, :destroy]
    before_action :get_hosts, only: [:new, :edit]
    before_action :get_neighborhoods, only: [:new, :edit]
    def index()
        @listings = Listing.all
    end

    def show()
        rejected_vals = ["title"]
        @cols = Listing.valid_column_names.reject {|val|
            rejected_vals.include?(val)
        }
    end

    def new()
        @listing = Listing.new()
    end

    def create()
        @listing = Listing.new(listing_params)
        validate(new_listing_path)
    end

    def edit()
    end

    def update()
        @listing.update(listing_params)
        validate(edit_listing_path(@listing))
    end

    def destroy()
        @listing.delete
        redirect_to listings_path
    end

    private

    def listing_params
        params.require(:listing).permit(:address, :listing_type, :title, :description, :price, :neighborhood_id, :host_id)
    end

    def find_listing()
        @listing = Listing.find(params[:id])
    end

    def get_neighborhoods()
        @neighborhoods =Neighborhood.all()
    end

    def get_hosts()
        @hosts = User.hosts()
    end

    def validate(valid_path = listing_path(@listing), error_path)
        if @listing.valid?
            @listing.save
            redirect_to valid_path
        else
            flash[:errors] = @listing.errors.full_messages
            redirect_to error_path
        end
    end
end
