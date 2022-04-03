class PaymentController < ApplicationController
  def view
  	base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
  	firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
  	puts "Created Cloud Firestore client with given project ID."
  	users_ref = firestore.col "transaction"
  	#puts @users_ref.inspect
  	@transactions = users_ref.get
  end
end
