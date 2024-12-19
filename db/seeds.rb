10.times do |i|
    title = ["Samsung TV", "Apple Watch", "Nike Shoes", "PlayStation 5", "Canon Camera", "Dell Laptop", "Iphone 13", "Adidas Shoes", "Sony Headphones", "Xbox Series X"][i]
    price = rand(10..1000)
    stock = rand(1..100)
    image_url = "https://picsum.photos/300/300?random=#{i+1}"
    sales_count = rand(1..100)
    discount = rand(1.0..10.0).round(2)
    description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestibulum magna sed, convallis ex. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed at nulla auctor, vestibulum magna sed, convallis ex. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
    Product.create!(title: title, price: price, stock: stock, image_url: image_url, sales_count: sales_count, discount: discount, description: description)
  end
  
  
  
  User.create(email: 'walid@gmail.com', password: 'walid12', role: 'user', first_name: 'Regular', last_name: 'User')
  User.create(email: 'test@admin.com', password: 'admin12', role: 'admin', first_name: 'Admin', last_name: 'User')
  User.create(email: 'test@user.com', password: 'user12', role: 'user', first_name: 'Regular', last_name: 'User')
  
  