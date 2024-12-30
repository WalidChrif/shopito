require 'faker'

['admin', 'seller'].each do |role|
  2.times do |i|
    User.create!(email: "#{role}#{i}@#{role}.com", password: "#{role}123", role: role, first_name: "#{role.capitalize} #{i+1}", last_name: "#{role.capitalize} #{i+1}")
  end
end

10.times do |i|
  title = ["Samsung TV", "Apple Watch", "Nike Shoes", "PlayStation 5", "Canon Camera", "Dell Laptop", "Iphone 13", "Adidas Shoes", "Sony Headphones", "Xbox Series X"][i]
  price = rand(10..1000)
  stock = rand(1..100)
  image_url = "https://picsum.photos/300/300?random=#{i+1}"
  sales_count = rand(1..100)
  discount = rand(1.0..10.0).round(2)
  description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestibulum magna sed, convallis ex. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed at nulla auctor, vestibulum magna sed, convallis ex. Cras justo odio, dapibus ac facilisis in, egestas eget quam."
  seller = User.where(role: 'seller').sample
  Product.create!(title: title, price: price, stock: stock, image_url: image_url, sales_count: sales_count, discount: discount, description: description, user_id: seller.id)
end  

10.times do |i|
  customer = Customer.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address
  )
  
  # Create an order with multiple different products
  total_items = rand(1..5) # Reduce max items per order
  products = Product.all.sample(total_items) # Get different random products
  total_price = 0
  
  order = Order.create!(
    customer_id: customer.id,
    total_items: total_items,
    total_price: 0, # Will calculate after creating items
    shipping_address: customer.address,
    status: ['pending', 'processing', 'shipped', 'delivered', 'cancelled'].sample
  )

  # Create order items with different products
  products.each do |product|
    quantity = rand(1..3) # Random quantity for each product
    item_price = product.price * quantity
    total_price += item_price
    
    OrderItem.create!(
      order_id: order.id,
      product_id: product.id,
      quantity: quantity,
      price: product.price,
      title: product.title,
      discount: product.discount
    )
  end
  
  # Update order with correct total price
  order.update!(total_price: total_price)
end