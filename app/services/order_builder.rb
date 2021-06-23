# frozen_string_literal: true

class OrderBuilder
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def call
    customer = find_customer(object['shipping_address'])
    shipping_address = find_shipping_address(object['shipping_address'], customer)
    seller = find_seller(object['seller_details'])
    order_items = build_items(object['items'])
    order_tax = build_tax(object['taxes'])

    order = build_order(seller)
    order.order_items = order_items
    order.taxes = order_tax
    order.shipping_address = shipping_address
    order.save
  end

  private

  def find_shipping_address(shipping_address, customer)
    ShippingAddress.new(name: shipping_address['full_name'], phone: shipping_address['phone'],
                        city: shipping_address['city'], zipcode: shipping_address['zip'], address: shipping_address['address'], customer: customer)
  end

  def find_customer(shipping_address)
    address = Customer.find_or_initialize_by(phone: shipping_address['phone'])
    if address.new_record?
      address.name = shipping_address['full_name']
      address.save
    end
    address
  end

  def find_seller(seller_details)
    seller = Seller.find_or_initialize_by(email: seller_details['user']['email'])
    if seller.new_record?
      seller.phone = seller_details['user']['phone']
      seller.pan = seller_details['pan']
      seller.city = seller_details['city']
      seller.save
    end
    seller
  end

  def build_items(items)
    order_items = []
    items.each do |item|
      product_obj = item['product']
      
      product = Product.find_or_initialize_by(store_pid: product_obj['_id'])
      if product.new_record?
        product.sku = product_obj['sku']
        product.store_product_id = product_obj['id']
        product.name = product_obj['name']
        product.description = product_obj['description']
        product.price = product_obj['price']
        product.images = product_obj['images'].map { |img| Image.new(url: img['tempSrc']) }

        school_attr = product_obj['attributes'].find { |attribute| attribute['name'] == 'School' }
        product.school = School.find_or_create_by(name: school_attr['value']) if school_attr && school_attr['value']

        product.save!
      end
      product_obj['variants'].each do |variant|
        variant_obj = product.variants.find_or_initialize_by(sku: variant['sku'])
        next unless variant_obj.new_record?

        variant_obj.price = variant['price']
        variant_obj.name = variant['name']
        variant_obj.value = variant['options'].join(', ')
        variant_obj.save!
      end
      product_obj['attributes'].each do |attribute|
        product.product_attributes.find_or_create_by(name: attribute['name'], value: attribute['value'])
      end
      order_items << OrderItem.new(name: item['name'], price: item['price'], 
                                   quantity: item['quantity'], product: product, options: item['selected_options'])
    end
    order_items
  end

  def build_tax(tax_properties)
    tax_properties.map do |tax|
      Tax.new({
                name: tax['name'],
                rate: tax['rate'],
                total: tax['tax_amount']
              })
    end
  end

  def build_order(seller)
    Order.new(store_order_id: object['order_id'], subtotal: object['sub_total'],
              shipping_total: object['shipping_total'], status: object['fulfillment_status'],
              payment: object['payment_method']['name'], seller: seller)
  end
end
