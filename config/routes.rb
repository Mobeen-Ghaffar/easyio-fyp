Rails.application.routes.draw do
  get 'payment/view'
  get 'customer/add'
  get 'product/add'
  get 'admin/dashboard'
  get 'user/login'
  post 'customer/add_customer', to: "customer#add_customer",as: :customer_add_customer
  post 'user/signin'
  post 'product/item_location', to: "product#item_location",as: :product_item_location
  post 'product/edit_item', to: "product#edit_item",as: :product_edit_item
  post 'product/add_item', to: "product#add_item",as: :product_add_item
  get 'product/edit'
  get 'product/view'
  get 'product/location'
  get 'product/adddiscount'
  get 'product/removediscount'
  post 'product/add_product_discount' , to: "product#add_product_discount",as: :product_add_product_discount
  post 'product/remove_product_discount' , to: "product#remove_product_discount",as: :product_remove_product_discount
  get 'product/location_predicator', to: "product#location_predicator",as: :product_location_predicator
  get 'customer/view'

 post "/generate/image" => "product#generate"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
