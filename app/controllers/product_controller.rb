class ProductController < ApplicationController

  require 'firebase'
  require 'rqrcode'
  require "google/cloud/firestore"
  require 'barby'
  require 'barby/barcode/code_128'
  require 'Apriori'
  require'barby'
'barby/outputter/jpeg_outputter'
'barby/outputter/pdfwriter_outputter'
'barby/outputter/svg_outputter'

  def add_item
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    puts "Created Cloud Firestore client with given project ID."
    users_ref = firestore.col "products"
    query = users_ref.where("category", "=", params[:product][:category]).where("name", "=", params[:product][:name]).limit(1) 
    print(query);
    query.get do |product|
        flash.now[:notice] = 'Item Already Exist!'
        render "layouts/flash.js.erb"
        return
    end
    #puts @users_ref.inspect 
   puts 'New Item'
   collection_path="products"
         doc_ref = firestore.col  'products'
         data={
        category: params[:product][:category],
        name: params[:product][:name],
        price:  params[:product][:price]
      }
        added_doc_ref = doc_ref.add data
        puts "Added document with ID: #{added_doc_ref.document_id}."
        puts "Added data to the alovelace document in the users collection."
        # barcode = Barby::Code128.new('I am losing sleep over their racket', true)
        # puts "BarCOde Value #{barcode}"
        doc_ref = firestore.doc "quantity/#{added_doc_ref.document_id}"
        doc_ref.set(
          itemId: "#{added_doc_ref.document_id}",
          itemSold: "0",
          quantity: params[:product][:quantity]
        )
        flash.now[:notice] = 'Item Added Successfully'
        render "layouts/flash.js.erb"
  end

  def add
  	
  end
  
  def edit_item
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "products"
    query = cities_ref.where("category", "==", params[:product][:category]).where("name", "==", params[:product][:name]) 
   # puts query.inspect
    q=query
    
    i=0
    q.get do |p|
      i=i+1
    end

    if i==0
      flash.now[:notice] = 'Item Not Exist!'
      render "layouts/flash.js.erb"
      return
    end

    puts i

    query.get do |city|
    puts "Document #{city.document_id} returned by query capital=true."
    product = firestore.doc "products/#{city.document_id}"
    updated = firestore.transaction do |tx|
    tx.update  product, price: params[:product][:price]
  end
   flash.now[:notice] = 'Item Details updated!'
      render "layouts/flash.js.erb"
  end 

end

  def item_location
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "products"
    query = cities_ref.where("category", "=", params[:product][:category]).where("name", "=", params[:product][:name]) 
    
    q=query
    
    i=0
    q.get do |p|
      i=i+1
    end

    if i==0
      flash.now[:notice] = 'Item Not Exist!'
      render "layouts/flash.js.erb"
      return
    end

    puts i

    query.get do |city|
    puts "Document #{city.document_id} returned by query capital=true."
    doc_ref = firestore.doc "location/#{city.document_id}"
        doc_ref.set(
          itemId: "#{city.document_id}",
          startrow: params[:product][:startrow],
          startcolumn: params[:product][:startcolumn],
          endrow: params[:product][:endrow],
          endcolumn: params[:product][:endcolumn],
          floor: params[:product][:floor]
        )
        break
  end
  end

  def add_product_discount
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "products"
    query = cities_ref.where("category", "=", params[:product][:category]).where("name", "=", params[:product][:name]) 
      q=query
    
    i=0
    q.get do |p|
      i=i+1
    end

    if i==0
      flash.now[:notice] = 'Item Not Exist!'
      render "layouts/flash.js.erb"
      return
    end

    puts i

    query.get do |city|
    puts "Document #{city.document_id} returned by query."
    product = firestore.doc "products/#{city.document_id}"
    updated = firestore.transaction do |tx|
    tx.update  product, discount: params[:product][:discount], promocode: params[:product][:promocode]
  end
  end 
  end

  def remove_product_discount
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
    firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
    cities_ref = firestore.col "products"
    query = cities_ref.where("category", "=", params[:product][:category]).where("name", "=", params[:product][:name]) 
      q=query
    
    i=0
    q.get do |p|
      i=i+1
    end

    if i==0
      flash.now[:notice] = 'Item Not Exist!'
      render "layouts/flash.js.erb"
      return
    end

    puts i

    query.get do |city|
    puts "Document #{city.document_id} returned by query."
    product = firestore.doc "products/#{city.document_id}"
    updated = firestore.transaction do |tx|
    tx.update  product, discount: "", promocode: ""
  end
  end 
  end


  def adddiscount
  end

  def removediscount
  end


  def edit 
  end
  
  def view
  	base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
  	firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
  	# puts "Created Cloud Firestore client with given project ID."
  	users_ref = firestore.col "products"
  	#puts @users_ref.inspect
  	@products = users_ref.get 
    @products.each do |p|
    #  puts p.inspect
    end
   
  end

  def vew_product_location
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
  	firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
  	puts "Created Cloud Firestore client with given project ID."
  	users_ref = firestore.col "transactions/sale"
  	#puts @users_ref.inspect
  	@sales = users_ref.get 
  end

  def generate
    puts"ads", params.inspect
    qrcode = RQRCode::QRCode.new(params[:id])

    # NOTE: showing with default options specified explicitly
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )

    IO.binwrite(params[:id]+".png", png.to_s)
#    
#     # puts"id", params.id
#     puts params[:id]
#     puts 'here'
#     barcode = Barby::Code128B.new('xxxx')
# File.open('exleaz1s.svg', 'wb'){|f|
#   f.write barcode.to_svg
# }
#     # @barcode = Barby::Code128B.new('IM-IN-UR-BARCODE')
#     barcode = Barby::Code128B.new('saritha')
#     File.open('exleaz', 'wb'){|f|
#     f.write barcode.to_png(:height => 20, :margin => 5)
#     }

  #   @blob = Barby::PngOutputter.new(barcode).to_png
  #   File.open('test.png', 'w') do |f|
  #    f.write barcode.to_png(:height => 20, :margin => 5)
  #   end
  #   File.open('code128b.png', 'w'){|f|
  #   f.write barcode.to_png(:height => 20, :margin => 5)
  # }
  # File.open('f.pdf','wb'){|f| f << @barcode.to_pdf }


    # barcode=Barby::Code128.new("pasds").to_png
    #  File.open('test.png', 'w') do |f|
    #     f.write barcode.to_jpg(:height => 20, :margin => 5)
    #  end
  end 

  def location_predicator
    base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
  	firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
  	# puts "Created Cloud Firestore client with given project ID."
  	
    users_ref = firestore.col "transaction" #reference to transactions
    @total_sale_products
    @support=0
    puts "Apriori Algorithm"
    @total_transactions=[]  # All transactions in 2d array
  	#puts @users_ref.inspect
  	@transactions = users_ref.get
    @transactions.each do |t|
      # puts t.document_id
      @transaction=[] # products in each transaction
      @count=0
      sales_ref =firestore.col("transaction").doc(t.document_id).col("sale")
      @sale_products = sales_ref.get
      
      @sale_products.each do |s|
      #  puts s.data[:itemId]
        @count=@count+1
        @transaction.append(s.data[:itemId])
      end

      @total_transactions.append(@transaction) # append to 2d array..
      if @count>@support
        @support=@count 
      end
    end
    puts 'Total Transactions'
    puts @total_transactions
    @item_set = Apriori::ItemSet.new(@total_transactions)

   # @support =4
    @confidence = 0
    
    puts @item_set.mine(@confidence,@support)
    @product_hash=@item_set.mine(@confidence,@support)
  end

end
