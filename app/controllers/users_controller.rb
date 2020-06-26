class UsersController < ApplicationController

    before_action :find_user, only: [:show, :edit, :update, :destroy]

    def index()
        @users = User.all
    end

    def show()
    end

    def new()
        @user = User.new()
    end

    def create()
        @user = User.new(user_params)
        validate(new_user_path)
    end

    def edit()
    end

    def update()
        @user.update(user_params)
        validate(edit_user_path(@user))
    end

    def destroy()
        @user.delete
        redirect_to users_path
    end

    private

    def user_params
        params.require(:user).permit(:name)
    end

    def find_user()
        @user = User.find(params[:id])
    end

    def validate(valid_path = user_path(@user) , error_path)
        if @user.valid?
            @user.save
            redirect_to valid_path
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to error_path
        end
    end


end
