module ProductHelper
     require 'firebase'
     require "google/cloud/firestore"
     require 'barby'
     require 'barby/barcode/code_128'

   
	def quantity(id)
        base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
        firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
        cities_ref = firestore.col "quantity"
        qs = cities_ref.where("itemId", "=",id)
        pqs = qs.get
        return pqs
	end

    def barcode_image(id)
        @barcode=Barby::Code128.new('213adsasfsjfshkdjjfh').to_png
        File.open('test.png', 'w') do |f|
            f.write barcode.to_jpg(:height => 20, :margin => 5)
        end
    end


    def get_qtt(product)
       qty = 1
        product.first(1).each do |q|
            qty =  q.data[:quantity]
        end
        # puts qty
        return qty
    end

    def from_hashstring(value)
        json_string = value
                      .gsub(/([{,]\s*):([^>\s]+)\s*=>/, '\1"\2"=>') # Handle ruby symbols as keys
                      .gsub(/([{,]\s*)([0-9]+\.?[0-9]*)\s*=>/, '\1"\2"=>') # Handle numbers as keys
                      .gsub(/([{,]\s*)(".+?"|[0-9]+\.?[0-9]*)\s*=>\s*:([^,}\s]+\s*)/, '\1\2=>"\3"') # Handle symbols as values
                      .gsub(/([\[,]\s*):([^,\]\s]+)/, '\1"\2"') # Handle symbols in arrays
                      .gsub(/([{,]\s*)(".+?"|[0-9]+\.?[0-9]*)\s*=>/, '\1\2:') # Finally, convert => to :
    
        JSON.parse(json_string)
      rescue
        value
    end

    def get_product_name(id)
        base_uri = 'https://easyiofyp-db877.firebaseio.com/_/products'
        firestore = Google::Cloud::Firestore.new project_id:'easyiofyp-db877', keyfile: "#{Rails.root}/app/assets/easyiofyp-f2eac85f5136.json"
        products_ref = firestore.col "products"
        product = products_ref.where("itemId", "=",id)
        
        pd=product.get
        product_name=""
        pd.first(1).each do |q|
            product_name =  q.data[:name]
            puts product_name
        end
        # puts pd[:name]
        return product_name
    end

end
