class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, type|
        item
      end
    end.uniq
  end

  def total_inventory
    item_list.each_with_object({}) do |item, items|
      items[item] = {quantity: 0, vendors: []}
      vendors_that_sell(item).each do |vendor|
        items[item][:vendors] << vendor
        items[item][:quantity] += vendor.check_stock(item)
      end
    end
  end
end