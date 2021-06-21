class Webhook::StoreHippoEventsController < ApplicationController
    # skip_before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

	def create
		store_hippo_params && lms = StoreHippoEvent.new(store_hippo_params)
		if lms.save
			render json: { success: true, data: lms.as_json }.to_json, status: :ok
		else
			render json: { success: false, errors: lms.errors.full_messages }.to_json, status: :ok
		end
	end

	def store_hippo_params
		{event_name: 'order_create', data: params}
	end
end
