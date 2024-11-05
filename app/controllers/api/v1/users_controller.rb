module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
      end

      def show
        @user = User.find(params[:id])
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render :show, status: :created
        else
          render "api/v1/errors", locals: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render :show, status: :ok
        else
          render "api/v1/errors", locals: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])

        if @user.destroy
          head :no_content
        else
          render "api/v1/errors", locals: { errors: @user.errors }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :full_name)
      end
    end
  end
end
