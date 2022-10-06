namespace :c_seeds do
  desc "TODO"
  task coupon_seeds: :environment do
    Coupon.create!([
    {
      coupon_name: "DevnTech", discount: 0.3
    },
    {
      coupon_name: "Pak14", discount: 0.5
    }])


    p "Created #{Coupon.count} coupons"
  end

end

