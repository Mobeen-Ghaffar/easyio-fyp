module PaymentHelper
	 require 'firebase'
     require "google/cloud/firestore"

	def customer(id)
	base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "customer"
    customers = cities_ref.where("customerId", "=",id)
    cus = customers.get
    # puts cus[1]
    return cus
	end

	def product(id)
    begin
        base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
        firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
        cities_ref = firestore.doc "products/#{id}"
        products = cities_ref.get
    
        return products
    rescue Exception
        puts 'Error'
    end
	end

	def salelist(id)
	base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "transaction/#{id}/sale"
    sales=cities_ref.get
    return sales
	end
end
