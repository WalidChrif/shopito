# 10.times do |i|
#     title = ["Samsung TV", "Apple Watch", "Nike Shoes", "PlayStation 5", "Canon Camera", "Dell Laptop", "Iphone 13", "Adidas Shoes", "Sony Headphones", "Xbox Series X"][i]
#     price = rand(10..1000)
#     stock = rand(1..100)
#     image_url = "https://picsum.photos/300/300?random=#{i+1}"
#     sales_count = rand(1..100)
#     discount = rand(1.0..10.0).round(2)
#     description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestibulum magna sed, convallis ex. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed at nulla auctor, vestibulum magna sed, convallis ex. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
#     seller = User.where(role: 'seller').sample
#     Product.create!(title: title, price: price, stock: stock, image_url: image_url, sales_count: sales_count, discount: discount, description: description, user_id: seller[:id])
#   end  
  
  
  # User.create(email: 'user@user.com', password: 'user123', role: 'customer', first_name: 'Customer', last_name: 'Customer')
  # User.create(email: 'admin@admin.com', password: 'admin123', role: 'admin', first_name: 'Admin', last_name: 'Admin')
  # User.create(email: 'seller@seller.com', password: 'seller123', role: 'seller', first_name: 'Seller', last_name: 'Seller')
  # User.create(email: 'seller2@seller.com', password: 'seller123', role: 'seller', first_name: 'Seller2', last_name: 'Seller2')
  
  
