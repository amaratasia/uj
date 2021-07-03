class Webhook::LmsController < ApplicationController
	skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

	def create
		lms_params && lms = StoreHippoEvent.new(lms_params)
		if lms.save
			render json: { success: true, data: lms.as_json }.to_json, status: :ok
		else
			render json: { success: false, errors: lms.errors.full_messages }.to_json, status: :ok
		end
	end

	def lms_params
		params.permit(:event_name, data: {})
	end
end