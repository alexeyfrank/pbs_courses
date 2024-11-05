module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @courses = Course.includes(:author, :skills).all
      end

      def show
        @course = Course.includes(:author, :skills).find(params[:id])
      end

      def create
        @course = Ba::Courses::Create.new(course_params).call

        if @course.persisted?
          render :show, status: :created
        else
          render "api/v1/errors", locals: { errors: @course.errors }, status: :unprocessable_entity
        end
      end

      def update
        @course = Ba::Courses::Update.new(course_params).call

        if @course.persisted?
          render :show, status: :ok
        else
          render "api/v1/errors", locals: { errors: @course.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @course = Course.find(params[:id])

        if @course.destroy
          head :no_content
        else
          render "api/v1/errors", locals: { errors: @course.errors }, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(:title, :description, :author_id, skill_slugs: [])
      end
    end
  end
end
