class CustomerController < ApplicationController
  require 'firebase'
  require "google/cloud/firestore"

  def add
  end
  def add_customer
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "customer"
    query = cities_ref.where("CNIC", "=", params[:customer][:cnic])
    q=query
    
    i=0
    q.get do |p|
      i=i+1
    end

    if i==0
      flash.now[:notice] = 'Customer Already Exist!'
      render "layouts/flash.js.erb"
      return
    end

    puts i
       doc_ref = firestore.col "customer"
        data={
        CNIC: params[:customer][:cnic],
        name: params[:customer][:name],
        phone:  params[:customer][:phone],
        email: params[:customer][:email]
      }
      added_doc_ref = doc_ref.add data

    flash.now[:notice] = 'Customer Account Created!'
    render "layouts/flash.js.erb"

  end

  def view
  	base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
  	firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
  	puts "Created Cloud Firestore client with given project ID."
  	users_ref = firestore.col "customer"
  	#puts @users_ref.inspect
  	@customers = users_ref.get
  	#puts @users_ref.inspect
  end
end
 